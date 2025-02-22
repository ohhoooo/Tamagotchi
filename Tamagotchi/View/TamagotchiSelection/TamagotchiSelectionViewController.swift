//
//  TamagotchiSelectionViewController.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/22/25.
//

import UIKit
import RxSwift
import RxCocoa

final class TamagotchiSelectionViewController: BaseViewController {
    
    // MARK: - properties
    private let tamagotchiSelectionView = TamagotchiSelectionView()
    private let viewModel = TamagotchiSelectionViewModel()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    override func loadView() {
        view = tamagotchiSelectionView
    }
    
    // MARK: - methods
    override func bind() {
        let input = TamagotchiSelectionViewModel.Input(
            modelSelected: tamagotchiSelectionView.collectionView.rx.modelSelected(Tamagotchi.self)
        )
        
        let output = viewModel.transform(input: input)
        
        output.items
            .bind(to: tamagotchiSelectionView.collectionView.rx.items(
                cellIdentifier: TamagotchiSelectionCell.identifier,
                cellType: TamagotchiSelectionCell.self)
            ) { (row, element, cell) in
                cell.bind(tamagotchi: element)
            }
            .disposed(by: disposeBag)
        
        output.modelSelected
            .subscribe(with: self) { owner, value in
                if value.nickname != "준비중이에요" {
                    let tamagotchiDetailVM = TamagotchiDetailViewModel(tamagotchi: value)
                    let tamagotchiDetailVC = TamagotchiDetailViewController(viewModel: tamagotchiDetailVM)
                    
                    tamagotchiDetailVC.modalTransitionStyle = .crossDissolve
                    tamagotchiDetailVC.modalPresentationStyle = .overCurrentContext
                    
                    owner.present(tamagotchiDetailVC, animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
}
