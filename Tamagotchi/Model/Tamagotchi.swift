//
//  Tamagotchi.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/22/25.
//

import Foundation

struct Tamagotchi: Decodable {
    let image: String
    let nickname: String
    
    init(image: String = "noImage", nickname: String = "준비중이에요") {
        self.image = image
        self.nickname = nickname
    }
}
