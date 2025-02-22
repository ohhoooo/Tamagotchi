//
//  TamagotchiSelectionView.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/22/25.
//

import UIKit
import SnapKit
import Then

final class TamagotchiSelectionView: BaseView {
    
    // MARK: - properties
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.register(TamagotchiSelectionCell.self, forCellWithReuseIdentifier: TamagotchiSelectionCell.identifier)
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .primaryBackgroundColor
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let lineSpacing: CGFloat = 28
        let horizontalInset: CGFloat = 24
        let interitemSpacing: CGFloat = 28
        let width = (UIScreen.main.bounds.size.width - (horizontalInset * 2) - (interitemSpacing * 2)) / 3
        layout.itemSize = CGSize(width: width, height: width + 32.0)
        layout.sectionInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interitemSpacing
        
        return layout
    }
}
