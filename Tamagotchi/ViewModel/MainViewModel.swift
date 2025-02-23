//
//  MainViewModel.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/23/25.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel: BaseViewModel {
    
    // MARK: - properties
    struct Input {
        let riceTextFieldText: ControlEvent<String?>
        let waterTextFieldText: ControlEvent<String?>
        let tapRiceButton: ControlEvent<Void>
        let tapWaterButton: ControlEvent<Void>
    }
    
    struct Output {
        let tamagotchi: BehaviorRelay<Tamagotchi>
    }
    
    private let disposeBag = DisposeBag()
    
    private let tamagotchi = BehaviorRelay(value: UserDefaultsManager.tamagotchis?.filter { $0.isSelected == true }.first ?? Tamagotchi())
    private var riceText = ""
    private var waterText = ""
    
    // MARK: - methods
    func transform(input: Input) -> Output {
        input.riceTextFieldText
            .skip(1)
            .bind(with: self) { owner, value in
                owner.riceText = value ?? ""
            }
            .disposed(by: disposeBag)
        
        input.waterTextFieldText
            .skip(1)
            .bind(with: self) { owner, value in
                owner.waterText = value ?? ""
            }
            .disposed(by: disposeBag)
        
        input.tapRiceButton
            .bind(with: self) { owner, _ in
                var tamagotchi = owner.tamagotchi.value
                
                if owner.riceText.isEmpty {
                    tamagotchi.rice += 1
                } else if let rice = Int(owner.riceText), rice > 0 && rice < 100 {
                    tamagotchi.rice += rice
                }
                
                switch tamagotchi.lv {
                case 10:
                    tamagotchi.image = tamagotchi.image.prefix(2).description + "9"
                default:
                    tamagotchi.image = tamagotchi.image.prefix(2).description + String(tamagotchi.lv)
                }
                
                if let index = UserDefaultsManager.tamagotchis?.firstIndex(where: { $0.isSelected == true }) {
                    UserDefaultsManager.tamagotchis?[index].image = tamagotchi.image
                    UserDefaultsManager.tamagotchis?[index].rice = tamagotchi.rice
                    owner.tamagotchi.accept(tamagotchi)
                }
            }
            .disposed(by: disposeBag)
        
        input.tapWaterButton
            .bind(with: self) { owner, _ in
                var tamagotchi = owner.tamagotchi.value
                
                if owner.waterText.isEmpty {
                    tamagotchi.water += 1
                } else if let water = Int(owner.waterText), water > 0 && water < 50 {
                    tamagotchi.water += water
                }
                
                switch tamagotchi.lv {
                case 10:
                    tamagotchi.image = tamagotchi.image.prefix(2).description + "9"
                default:
                    tamagotchi.image = tamagotchi.image.prefix(2).description + String(tamagotchi.lv)
                }
                
                if let index = UserDefaultsManager.tamagotchis?.firstIndex(where: { $0.isSelected == true }) {
                    UserDefaultsManager.tamagotchis?[index].image = tamagotchi.image
                    UserDefaultsManager.tamagotchis?[index].water = tamagotchi.water
                    owner.tamagotchi.accept(tamagotchi)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            tamagotchi: tamagotchi
        )
    }
}
