//
//  TamagotchiSelectionView.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/22/25.
//

import UIKit

class TamagotchiSelectionView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

final class TamagotchiSelectionView: BaseView {
    
    // MARK: - properties
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }
    
    let image = UIImageView()
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .primaryBackgroundColor
        
        addSubview(image)
        image.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        image.image = UIImage(named: "_1_1")
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints {
            $0.verticalEdges.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let lineSpacing: CGFloat = 12
        let horizontalInset: CGFloat = 24
        let interitemSpacing: CGFloat = 12
        let width = (UIScreen.main.bounds.size.width - (horizontalInset * 2) - (interitemSpacing * 3)) / 4
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interitemSpacing
        
        return layout
    }
}
