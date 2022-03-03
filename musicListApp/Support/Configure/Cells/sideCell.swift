//
//  sideCell.swift
//  musicListApp
//
//  Created by Lytle Ashlyn on 3/3/22.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit

class sideCell: UITableViewCell {
    
    static let id = "sideCell"
    var actionButton = UIButton(type: .system)
    var textToButton = " "
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier : reuseIdentifier)
        setUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.selectionStyle = .none
        actionButton.setTitle("\(textToButton)", for: .normal)
        actionButton.tintColor = .white
    }
  

    private func setupConstraints() {
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            actionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
