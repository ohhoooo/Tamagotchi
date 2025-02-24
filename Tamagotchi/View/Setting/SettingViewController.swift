//
//  SettingViewController.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/24/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingViewController: BaseViewController {
    
    // MARK: - properties
    private let settingView = SettingView()
    private let viewModel = SettingViewModel()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    override func loadView() {
        view = settingView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
    }
    
    // MARK: - methods
    override func bind() {
        let input = SettingViewModel.Input(
            itemSelected: settingView.tableView.rx.itemSelected
        )
        
        let output = viewModel.transform(input: input)
        
        output.settings
            .bind(to: settingView.tableView.rx.items(
                cellIdentifier: SettingCell.identifier,
                cellType: SettingCell.self)
            ) { (row, element, cell) in
                cell.bind(setting: element)
            }
            .disposed(by: disposeBag)
        
        output.itemSelected
            .bind(with: self) { owner, indexPath in
                switch indexPath.row {
                case 0:
                    owner.navigationController?.pushViewController(SettingNicknameViewController(), animated: true)
                case 1:
                    owner.navigationController?.pushViewController(SettingTamagotchiViewController(), animated: true)
                default:
                    owner.showAlert()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func configureNavigation() {
        navigationItem.title = "설정"
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "데이터 초기화",
                                      message: "정말 다시 처음부터 시작하실 건가용?",
                                      preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.viewModel.tapOkButton.accept(())
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
            window.rootViewController = UINavigationController(rootViewController: TamagotchiSelectionViewController())
            window.makeKeyAndVisible()
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
