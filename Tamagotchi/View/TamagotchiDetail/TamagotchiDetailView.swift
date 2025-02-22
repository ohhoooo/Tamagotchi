//
//  TamagotchiDetailView.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/23/25.
//

import UIKit
import SnapKit
import Then

final class TamagotchiDetailView: BaseView {
    
    // MARK: - properties
    private let basedView = UIView().then {
        $0.clipsToBounds = true
        $0.backgroundColor = .primaryBackgroundColor
        $0.layer.cornerRadius = 8
    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let nicknameButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.background.strokeWidth = 0.5
        config.background.strokeColor = .primaryColor
        config.background.cornerRadius = 4
        config.background.backgroundColor = .secondaryBackgroundColor
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        $0.configuration = config
    }
    
    private let tamagotchiDividerView = UIView().then {
        $0.backgroundColor = .primaryColor
    }
    
    private let infoLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .primaryColor
        $0.textAlignment = .center
    }
    
    private let buttonDividerView = UIView().then {
        $0.backgroundColor = .systemGray4
    }
    
    let cancelButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.attributedTitle = AttributedString("취소", attributes: AttributeContainer([.foregroundColor: UIColor.primaryColor,
                                                                                        .font: UIFont.systemFont(ofSize: 14)]))
        config.background.backgroundColor = UIColor(red: 228/255, green: 237/255, blue: 239/255, alpha: 1)
        config.background.cornerRadius = 0
        $0.configuration = config
    }
    
    let startButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.attributedTitle = AttributedString("시작하기", attributes: AttributeContainer([.foregroundColor: UIColor.primaryColor,
                                                                                          .font: UIFont.systemFont(ofSize: 14)]))
        config.background.backgroundColor = .clear
        $0.configuration = config
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .black.withAlphaComponent(0.3)
    }
    
    override func configureHierarchy() {
        addSubview(basedView)
        basedView.addSubview(imageView)
        basedView.addSubview(nicknameButton)
        basedView.addSubview(tamagotchiDividerView)
        basedView.addSubview(infoLabel)
        basedView.addSubview(buttonDividerView)
        basedView.addSubview(cancelButton)
        basedView.addSubview(startButton)
    }
    
    override func configureConstraints() {
        basedView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.6)
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalTo(imageView.snp.width)
        }
        
        nicknameButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        tamagotchiDividerView.snp.makeConstraints {
            $0.top.equalTo(nicknameButton.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(44)
            $0.height.equalTo(0.5)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(tamagotchiDividerView.snp.bottom).offset(32)
            $0.horizontalEdges.equalTo(tamagotchiDividerView)
        }
        
        buttonDividerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(cancelButton.snp.top)
            $0.height.equalTo(0.5)
        }
        
        cancelButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(52)
        }
        
        startButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(52)
        }
    }
    
    func bind(tamagotchi: Tamagotchi) {
        imageView.image = UIImage(named: tamagotchi.image)
        nicknameButton.configuration?.attributedTitle = AttributedString(
            tamagotchi.nickname,
            attributes: AttributeContainer([.foregroundColor: UIColor.primaryColor, .font: UIFont.boldSystemFont(ofSize: 12)])
        )
        infoLabel.text = "저는 \(tamagotchi.nickname)입니당!"
    }
}
