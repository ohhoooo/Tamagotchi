//
//  SettingNicknameView.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/24/25.
//

import UIKit
import SnapKit
import Then

final class SettingNicknameView: BaseView {
    
    // MARK: - properties
    let saveBarButtonItem = UIBarButtonItem().then {
        $0.style = .done
        $0.title = "저장"
        $0.setTitleTextAttributes([.foregroundColor: UIColor.primaryColor, .font: UIFont.systemFont(ofSize: 15)], for: .normal)
    }
    
    let textField = UITextField().then {
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .primaryColor
        $0.borderStyle = .none
        $0.placeholder = "대장님 이름을 알려주세요!"
    }
    
    private let dividerView = UIView().then {
        $0.backgroundColor = .primaryColor
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .primaryBackgroundColor
    }
    
    override func configureHierarchy() {
        addSubview(textField)
        addSubview(dividerView)
    }
    
    override func configureConstraints() {
        textField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(32)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(textField)
            $0.height.equalTo(1)
        }
    }
    
    func bind(nickname: String) {
        textField.text = nickname
    }
}
