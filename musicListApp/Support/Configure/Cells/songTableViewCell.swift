//
//  songTableViewCell.swift
//  musicListApp
//
//  Created by zz on 01.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit

class songTableViewCell: UITableViewCell {
    
    static let id = "songCellTableView"
    var numeration = UILabel()
           var nameOfSong = UILabel()
           var timeOfSong = UILabel()
           var sideButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier : reuseIdentifier)
        setUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        numeration.font = UIFont.systemFont(ofSize: 12)
        numeration.textColor = UIColor.black.withAlphaComponent(0.6)
        nameOfSong.font = UIFont.systemFont(ofSize: 12)
        nameOfSong.textColor = UIColor.black.withAlphaComponent(0.9)
        nameOfSong.textAlignment = .left
        timeOfSong.font = UIFont.systemFont(ofSize: 11)
        timeOfSong.textColor = UIColor.black.withAlphaComponent(0.6)
        sideButton.setImage(UIImage(named: "moreButton"), for: .normal)
        sideButton.tintColor = .systemBlue
    }
  

    private func setupConstraints() {

        let contentStackView = UIStackView(arrangedSubviews: [numeration, nameOfSong, timeOfSong, sideButton])
        contentStackView.axis = .horizontal
        contentStackView.spacing = 10
        self.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
             contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
