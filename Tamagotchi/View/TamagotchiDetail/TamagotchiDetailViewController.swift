//
//  TamagotchiDetailViewController.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/23/25.
//

import UIKit
import RxSwift
import RxCocoa

final class TamagotchiDetailViewController: BaseViewController {
    
    // MARK: - properties
    private let tamagotchiDetailView = TamagotchiDetailView()
    private let viewModel: TamagotchiDetailViewModel
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    init(viewModel: TamagotchiDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = tamagotchiDetailView
    }
    
    // MARK: - methods
    override func bind() {
        let input = TamagotchiDetailViewModel.Input(
            tapCancelButton: tamagotchiDetailView.cancelButton.rx.tap,
            tapStartButton: tamagotchiDetailView.startButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.tamagotchi
            .bind(with: self) { owner, value in
                owner.tamagotchiDetailView.bind(tamagotchi: value)
            }
            .disposed(by: disposeBag)
        
        output.tapCancelButton
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        output.tapStartButton
            .bind {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
                window.rootViewController = UINavigationController(rootViewController: MainViewController())
                window.makeKeyAndVisible()
            }
            .disposed(by: disposeBag)
    }
}
