//
//  BaseViewModel.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/22/25.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
