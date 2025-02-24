//
//  MainView.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/23/25.
//

import UIKit
import SnapKit
import Then

final class MainView: BaseView {
    
    // MARK: - properties
    let settingBarButtonItem = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "person.crop.circle")?.withTintColor(.primaryColor, renderingMode: .alwaysOriginal)
    }
    
    private let bubbleImageView = UIImageView().then {
        $0.image = .bubble
        $0.contentMode = .scaleAspectFill
    }
    
    private let bubbleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .primaryColor
        $0.numberOfLines = 3
        $0.textAlignment = .center
    }
    
    private let tamagotchiImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
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
    
    private let statusLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 13)
        $0.textColor = .primaryColor
        $0.textAlignment = .center
    }
    
    let riceTextField = UITextField().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .black
        $0.borderStyle = .none
        $0.placeholder = "밥주세용"
        $0.textAlignment = .center
        $0.keyboardType = .numberPad
    }
    
    private let riceDividerView = UIView().then {
        $0.backgroundColor = .primaryColor
    }
    
    let riceButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "drop.circle")?.withTintColor(.primaryColor, renderingMode: .alwaysOriginal)
        config.imagePadding = 4
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        config.attributedTitle = AttributedString(
            "밥먹기",
            attributes: AttributeContainer([.foregroundColor: UIColor.primaryColor, .font: UIFont.boldSystemFont(ofSize: 13)])
        )
        config.background.strokeWidth = 1
        config.background.strokeColor = .primaryColor
        config.background.cornerRadius = 6
        config.background.backgroundColor = .clear
        $0.configuration = config
    }
    
    let waterTextField = UITextField().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .black
        $0.borderStyle = .none
        $0.placeholder = "물주세용"
        $0.textAlignment = .center
        $0.keyboardType = .numberPad
    }
    
    private let waterDividerView = UIView().then {
        $0.backgroundColor = .primaryColor
    }
    
    let waterButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "leaf.circle")?.withTintColor(.primaryColor, renderingMode: .alwaysOriginal)
        config.imagePadding = 4
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        config.attributedTitle = AttributedString(
            "물먹기",
            attributes: AttributeContainer([.foregroundColor: UIColor.primaryColor, .font: UIFont.boldSystemFont(ofSize: 13)])
        )
        config.background.strokeWidth = 1
        config.background.strokeColor = .primaryColor
        config.background.cornerRadius = 6
        config.background.backgroundColor = .clear
        $0.configuration = config
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .primaryBackgroundColor
    }
    
    override func configureHierarchy() {
        addSubview(bubbleImageView)
        bubbleImageView.addSubview(bubbleLabel)
        addSubview(tamagotchiImageView)
        addSubview(nicknameButton)
        addSubview(statusLabel)
        addSubview(riceTextField)
        addSubview(riceDividerView)
        addSubview(riceButton)
        addSubview(waterTextField)
        addSubview(waterDividerView)
        addSubview(waterButton)
    }
    
    override func configureConstraints() {
        bubbleImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(bubbleImageView.snp.width).multipliedBy(0.7)
            $0.bottom.equalTo(tamagotchiImageView.snp.top).offset(-20)
        }
        
        bubbleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        tamagotchiImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.95)
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(tamagotchiImageView.snp.width)
        }
        
        nicknameButton.snp.makeConstraints {
            $0.top.equalTo(tamagotchiImageView.snp.bottom).offset(8)
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        riceTextField.snp.makeConstraints {
            $0.horizontalEdges.equalTo(riceDividerView)
            $0.centerY.equalTo(riceButton)
        }
        
        riceDividerView.snp.makeConstraints {
            $0.leading.equalTo(tamagotchiImageView).offset(-20)
            $0.trailing.equalTo(riceButton.snp.leading).offset(-12)
            $0.bottom.equalTo(riceButton)
            $0.height.equalTo(1)
        }
        
        riceButton.snp.makeConstraints {
            $0.top.equalTo(statusLabel.snp.bottom).offset(28)
            $0.centerX.equalToSuperview().multipliedBy(1.5)
        }
        
        waterTextField.snp.makeConstraints {
            $0.horizontalEdges.equalTo(waterDividerView)
            $0.centerY.equalTo(waterButton)
        }
        
        waterDividerView.snp.makeConstraints {
            $0.leading.equalTo(tamagotchiImageView).offset(-20)
            $0.trailing.equalTo(waterButton.snp.leading).offset(-12)
            $0.bottom.equalTo(waterButton)
            $0.height.equalTo(1)
        }
        
        waterButton.snp.makeConstraints {
            $0.top.equalTo(riceButton.snp.bottom).offset(12)
            $0.centerX.equalToSuperview().multipliedBy(1.5)
        }
    }
    
    func bind(tamagotchi: Tamagotchi) {
        tamagotchiImageView.image = UIImage(named: tamagotchi.image)
        nicknameButton.configuration?.attributedTitle = AttributedString(
            tamagotchi.nickname,
            attributes: AttributeContainer([.foregroundColor: UIColor.primaryColor, .font: UIFont.boldSystemFont(ofSize: 13)])
        )
        statusLabel.text = "LV\(tamagotchi.lv) · 밥알 \(tamagotchi.rice)개 · 물방울 \(tamagotchi.water)개"
    }
    
    func bind(nickname: String) {
        bubbleLabel.text = randomContents(nickname: nickname)
    }
    
    private func randomContents(nickname: String) -> String {
        let contents = ["복습 아직 안하셨다구요?\n지금 잠이 오세여?\n\(nickname)님?",
                        "\(nickname)님, 밥주세요",
                        "좋은 하루에요, \(nickname)님",
                        "과제는 하고 누으신 건가요?\n\(nickname)님?"]
        
        return contents.randomElement()!
    }
}
