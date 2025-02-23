//
//  SettingViewModel.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/24/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel: BaseViewModel {
    
    // MARK: - properties
    struct Input {
        let itemSelected: ControlEvent<IndexPath>
    }
    
    struct Output {
        let settings: Observable<[Setting]>
        let itemSelected: ControlEvent<IndexPath>
    }
    
    private let disposeBag = DisposeBag()
    
    let tapOkButton = PublishRelay<Void>()
    
    // MARK: - methods
    func transform(input: Input) -> Output {
        let settings = Observable.just(fetchSettings())
        
        tapOkButton
            .bind {
                UserDefaultsManager.isSelected = false
                UserDefaultsManager.tamagotchis = [
                    Tamagotchi(image: "1-1", nickname: "따끔따끔 다마고치", rice: 0, water: 0, isSelected: false),
                    Tamagotchi(image: "2-1", nickname: "방실방실 다마고치", rice: 0, water: 0, isSelected: false),
                    Tamagotchi(image: "3-1", nickname: "반짝반짝 다마고치", rice: 0, water: 0, isSelected: false)
                ]
            }
            .disposed(by: disposeBag)
        
        return Output(
            settings: settings,
            itemSelected: input.itemSelected
        )
    }
    
    private func fetchSettings() -> [Setting] {
        guard let data = loadData() else { return [] }
        
        do {
            return try JSONDecoder().decode([Setting].self, from: data)
        } catch {
            return []
        }
    }
    
    private func loadData() -> Data? {
        guard let url = Bundle.main.url(forResource: "Setting", withExtension: "json") else { return nil }
        
        do {
            return try Data(contentsOf: url)
        } catch {
            return nil
        }
    }
}
