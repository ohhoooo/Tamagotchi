//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/23/25.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController {
    
    // MARK: - properties
    private let mainView = MainView()
    private let viewModel = MainViewModel()
    
    private let disposeBag = DisposeBag()
    
    private let willApearView = PublishRelay<Void>()
    
    // MARK: - life cycles
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        willApearView.accept(())
    }
    
    // MARK: - methods
    override func bind() {
        let input = MainViewModel.Input(
            willAppearView: willApearView,
            riceTextFieldText: mainView.riceTextField.rx.text.changed,
            waterTextFieldText: mainView.waterTextField.rx.text.changed,
            tapRiceButton: mainView.riceButton.rx.tap,
            tapWaterButton: mainView.waterButton.rx.tap,
            tapSettingBarButtonItem: mainView.settingBarButtonItem.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.nickname
            .bind(with: self) { owner, value in
                owner.mainView.bind(nickname: value)
                owner.configureNavigation(nickname: value)
            }
            .disposed(by: disposeBag)
        
        output.tamagotchi
            .bind(with: self) { owner, value in
                owner.mainView.bind(tamagotchi: value)
            }
            .disposed(by: disposeBag)
        
        output.tapSettingBarButtonItem
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(SettingViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureNavigation(nickname: String) {
        navigationItem.title = "\(nickname)님의 다마고치"
        navigationItem.rightBarButtonItem = mainView.settingBarButtonItem
        navigationController?.navigationBar.tintColor = .primaryColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.primaryColor, .font: UIFont.boldSystemFont(ofSize: 17)]
    }
}
