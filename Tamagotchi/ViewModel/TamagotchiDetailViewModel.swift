//
//  TamagotchiDetailViewModel.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/23/25.
//

import Foundation
import RxSwift
import RxCocoa

final class TamagotchiDetailViewModel: BaseViewModel {
    
    // MARK: - properties
    struct Input {
        let tapCancelButton: ControlEvent<Void>
        let tapStartButton: ControlEvent<Void>
    }
    
    struct Output {
        let tamagotchi: Observable<Tamagotchi>
        let tapCancelButton: ControlEvent<Void>
        let tapStartButton: ControlEvent<Void>
    }
    
    private let disposeBag = DisposeBag()
    
    private let tamagotchi: Tamagotchi
    
    // MARK: - life cycles
    init(tamagotchi: Tamagotchi) {
        self.tamagotchi = tamagotchi
    }
    
    // MARK: - methods
    func transform(input: Input) -> Output {
        let tamagotchi = Observable.just(tamagotchi)
        
        input.tapStartButton.bind { _ in
            guard let tamagotchis = UserDefaultsManager.tamagotchis else { return }
            
            for (index, element) in tamagotchis.enumerated() {
                UserDefaultsManager.tamagotchis?[index].isSelected = element.nickname == self.tamagotchi.nickname ? true : false
            }
            
            UserDefaultsManager.isSelected = true
        }
        .disposed(by: disposeBag)
        
        return Output(
            tamagotchi: tamagotchi,
            tapCancelButton: input.tapCancelButton,
            tapStartButton: input.tapStartButton
        )
    }
}
