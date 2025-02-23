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
                UserDefaultsManager.tamagotchis = nil
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
