//
//  Tamagotchi.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/22/25.
//

import Foundation

struct Tamagotchi: Codable {
    var image: String
    let nickname: String
    var rice: Int
    var water: Int
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
    
    init(image: String = "noImage", nickname: String = "준비중이에요", rice: Int = 0, water: Int = 0, isSelected: Bool = false) {
        self.image = image
        self.nickname = nickname
        self.rice = rice
        self.water = water
        self.isSelected = isSelected
    }
}
