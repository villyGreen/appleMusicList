//
//  SongCellWithLogo.swift
//  musicListApp
//
//  Created by zz on 02.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//
import UIKit

class songCellTableViewWithLogo: UITableViewCell {
    
    static let id = "songCellTableViewWithLogo"
    var numeration = UILabel()
        var imageLogo = UIImageView()
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
        self.selectionStyle = .none
        imageLogo.image = UIImage(named: "defaultMusicLogo")
        imageLogo.contentMode = .scaleAspectFill
        numeration.font = UIFont.systemFont(ofSize: 13)
        numeration.textColor = UIColor.black.withAlphaComponent(0.6)
        nameOfSong.font = UIFont.systemFont(ofSize: 13)
        nameOfSong.textColor = UIColor.black.withAlphaComponent(0.9)
        nameOfSong.textAlignment = .left
        timeOfSong.font = UIFont.systemFont(ofSize: 12)
        timeOfSong.textColor = UIColor.black.withAlphaComponent(0.6)
        sideButton.setImage(UIImage(named: "moreButton"), for: .normal)
        sideButton.tintColor = .systemRed
    }
  

    private func setupConstraints() {
        self.addSubview(numeration)
        self.addSubview(nameOfSong)
        self.addSubview(timeOfSong)
        self.addSubview(sideButton)
        self.addSubview(imageLogo)
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        numeration.translatesAutoresizingMaskIntoConstraints = false
        nameOfSong.translatesAutoresizingMaskIntoConstraints = false
        timeOfSong.translatesAutoresizingMaskIntoConstraints = false
        sideButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numeration.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            numeration.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            imageLogo.heightAnchor.constraint(equalToConstant: 50),
            imageLogo.widthAnchor.constraint(equalToConstant: 50),
            imageLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageLogo.leadingAnchor.constraint(equalTo: numeration.trailingAnchor, constant: 15),
            nameOfSong.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameOfSong.leadingAnchor.constraint(equalTo: imageLogo.trailingAnchor, constant: 15),
            sideButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sideButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            timeOfSong.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timeOfSong.trailingAnchor.constraint(equalTo: self.sideButton.leadingAnchor, constant: -15)
        ])
    }
}
