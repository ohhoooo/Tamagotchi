//
//  TamagotchiSelectionViewModel.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/22/25.
//

import Foundation
import RxSwift
import RxCocoa

final class TamagotchiSelectionViewModel: BaseViewModel {
    
    // MARK: - properties
    struct Input {
        let modelSelected: ControlEvent<Tamagotchi>
    }
    
    struct Output {
        let items: Observable<[Tamagotchi]>
        let modelSelected: ControlEvent<Tamagotchi>
    }
    
    // MARK: - methods
    func transform(input: Input) -> Output {
        let items = Observable.just(fetchTamagotchi())
        
        return Output(
            items: items,
            modelSelected: input.modelSelected
        )
    }
    
    private func fetchTamagotchi() -> [Tamagotchi] {
        guard let data = loadData() else { return [] }
        
        do {
            return try JSONDecoder().decode([Tamagotchi].self, from: data)
        } catch {
            return []
        }
    }
    
    private func loadData() -> Data? {
        guard let url = Bundle.main.url(forResource: "Tamagotchi", withExtension: "json") else { return nil }
        
        do {
            return try Data(contentsOf: url)
        } catch {
            return nil
        }
    }
}
