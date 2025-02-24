//
//  SettingView.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/24/25.
//

import UIKit
import SnapKit
import Then

final class SettingView: BaseView {
    
    // MARK: - properties
    let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .primaryBackgroundColor
    }
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
