//
//  SettingCell.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/24/25.
//

import UIKit
import SnapKit
import Then

final class SettingCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = "SettingCell"
    
    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 13)
        $0.textColor = .black
    }
    
    private let forwardImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.forward")
        $0.contentMode = .scaleAspectFill
    }
    
    private let dividerView = UIView().then {
        $0.backgroundColor = .systemGray4
    }
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.image = nil
        titleLabel.text = nil
        forwardImageView.image = nil
    }
    
    // MARK: - methods
    override func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(forwardImageView)
        contentView.addSubview(dividerView)
    }
    
    override func configureConstraints() {
        iconImageView.snp.makeConstraints {
            $0.verticalEdges.leading.equalToSuperview().inset(16)
            $0.size.equalTo(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.centerY.equalTo(iconImageView)
        }
        
        forwardImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(10)
        }
        
        dividerView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func bind(setting: Setting) {
        iconImageView.image = UIImage(systemName: setting.icon)?.withTintColor(.primaryColor, renderingMode: .alwaysOriginal)
        titleLabel.text = setting.title
        forwardImageView.image = UIImage(systemName: setting.accessory)?.withTintColor(.systemGray3, renderingMode: .alwaysOriginal)
    }
}
