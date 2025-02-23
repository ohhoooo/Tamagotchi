//
//  Tamagotchi.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/22/25.
//

import Foundation

struct Tamagotchi: Codable {
    let image: String
    let nickname: String
    let rice: Int
    let water: Int
    var isSelected: Bool
    
    var lv: Int {
        let lv = Int(((Double(rice) / 5.0) + (Double(water) / 2.0)) / 10.0)
        
        switch lv {
        case 0...1:
            return 1
        case 2...9:
            return lv
        default:
            return 10
        }
    }
}
