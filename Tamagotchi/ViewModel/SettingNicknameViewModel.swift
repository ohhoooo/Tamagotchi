//
//  SettingNicknameViewModel.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/24/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingNicknameViewModel: BaseViewModel {
    
    // MARK: - properties
    struct Input {
        let changedTextFieldText: ControlEvent<String?>
        let tapSaveBarButtonItem: ControlEvent<Void>
    }
    
    struct Output {
        let nickname: Observable<String>
        let saveCompletion: PublishRelay<Void>
    }
    
    private let disposeBag = DisposeBag()
    
    private var nicknameText = ""
    
    // MARK: - methods
    func transform(input: Input) -> Output {
        let nickname = Observable.just(UserDefaultsManager.nickname)
        let saveCompletion = PublishRelay<Void>()
        
        input.changedTextFieldText
            .bind(with: self) { owner, value in
                owner.nicknameText = value ?? ""
            }
            .disposed(by: disposeBag)
        
        input.tapSaveBarButtonItem
            .bind(with: self) { owner, _ in
                if owner.nicknameText.count >= 2 && owner.nicknameText.count <= 6 {
                    UserDefaultsManager.nickname = owner.nicknameText
                    saveCompletion.accept(())
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            nickname: nickname,
            saveCompletion: saveCompletion
        )
    }
}
