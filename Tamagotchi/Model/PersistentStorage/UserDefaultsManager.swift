//
//  UserDefaultsManager.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/23/25.
//

import Foundation

enum UserDefaultsManager {
    enum Key: String {
        case isSelected
        case tamagotchis
    }
    
    @PrimitiveTypeStorage(key: Key.isSelected.rawValue, empty: false)
    static var isSelected: Bool
    
    @CustomTypeStorage(key: Key.tamagotchis.rawValue, empty: nil)
    static var tamagotchis: [Tamagotchi]?
}

@propertyWrapper
struct PrimitiveTypeStorage<T> {
    let key: String
    let empty: T
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? empty
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}

@propertyWrapper
struct CustomTypeStorage<T: Codable> {
    let key: String
    let empty: T?
    
    var wrappedValue: T? {
        get {
            if let data = UserDefaults.standard.data(forKey: key) {
                return (try? JSONDecoder().decode(T.self, from: data)) ?? empty
            }
            
            return empty
        }
        set {
            if let newValue {
                if let encodedData = try? JSONEncoder().encode(newValue) {
                    UserDefaults.standard.set(encodedData, forKey: key)
                }
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
}
