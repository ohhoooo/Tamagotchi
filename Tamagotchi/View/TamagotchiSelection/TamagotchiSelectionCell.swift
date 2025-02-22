//
//  TamagotchiSelectionCell.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/22/25.
//

import UIKit
import SnapKit
import Then

final class TamagotchiSelectionCell: BaseCollectionViewCell {
    
    // MARK: - properties
    static let identifier = "TamagotchiSelectionCell"
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let nicknameButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.background.strokeWidth = 0.5
        config.background.strokeColor = .primaryColor
        config.background.cornerRadius = 4
        config.background.backgroundColor = .secondaryBackgroundColor
        config.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        $0.configuration = config
    }
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        nicknameButton.configuration?.attributedTitle = nil
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(nicknameButton)
    }
    
    override func configureConstraints() {
        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        nicknameButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(28)
        }
    }
    
    func bind(tamagotchi: Tamagotchi) {
        imageView.image = UIImage(named: tamagotchi.image)
        nicknameButton.configuration?.attributedTitle = AttributedString(
            tamagotchi.nickname,
            attributes: AttributeContainer([.foregroundColor: UIColor.primaryColor, .font: UIFont.boldSystemFont(ofSize: 12)])
        )
    }
}
