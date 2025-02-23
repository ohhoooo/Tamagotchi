//
//  SettingNicknameViewController.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/24/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingNicknameViewController: BaseViewController {
    
    // MARK: - properties
    private let settingNicknameView = SettingNicknameView()
    private let viewModel = SettingNicknameViewModel()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    override func loadView() {
        view = settingNicknameView
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
    }
    
    override func bind() {
        let input = SettingNicknameViewModel.Input(
            changedTextFieldText: settingNicknameView.textField.rx.text.changed,
            tapSaveBarButtonItem: settingNicknameView.saveBarButtonItem.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.nickname
            .bind(with: self) { owner, value in
                owner.settingNicknameView.bind(nickname: value)
            }
            .disposed(by: disposeBag)
        
        output.saveCompletion
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureNavigation() {
        navigationItem.title = "대장님 이름 정하기"
        navigationItem.rightBarButtonItem = settingNicknameView.saveBarButtonItem
    }
}
