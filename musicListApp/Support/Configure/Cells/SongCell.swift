//
//  SongSection.swift
//  musicListApp
//
//  Created by zz on 22.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit
import SDWebImage

class SongCell: UICollectionViewCell, CellConfiguring{
    
    let userImage = UIImageView()
    let nameOfAlbumLabel = UILabel()
    let timeOfAlbum = UILabel()
    let containerView = UIView()
    static var reuseID = "SongCell"
    
    override func prepareForReuse() {
        userImage.image = nil
    }
    
    func configure<U>(value: U) where U : Hashable {
        guard let song:Song = value as? Song else {
            return
        }
        let imageUrl = URL(string: song.avatarStringURL)
        userImage.sd_setImage(with: imageUrl, completed: nil)
        DispatchQueue.main.async {
            self.nameOfAlbumLabel.text = song.username
            self.timeOfAlbum.text = "36:12"
        }
    }
    
    private func setupConstraints() {
        userImage.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        nameOfAlbumLabel.translatesAutoresizingMaskIntoConstraints = false
        timeOfAlbum.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        containerView.addSubview(userImage)
        containerView.addSubview(nameOfAlbumLabel)
        containerView.addSubview(timeOfAlbum)
        
        nameOfAlbumLabel.font = UIFont.systemFont(ofSize: 16)
        nameOfAlbumLabel.textColor = UIColor.black.withAlphaComponent(0.75)
        
        timeOfAlbum.font = UIFont.systemFont(ofSize: 10)
        timeOfAlbum.textColor = UIColor.black.withAlphaComponent(0.65)
        
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        userImage.contentMode = .scaleAspectFill
        userImage.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        userImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        userImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        userImage.heightAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        
        
        nameOfAlbumLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10).isActive = true
        nameOfAlbumLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
        nameOfAlbumLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        
        timeOfAlbum.topAnchor.constraint(equalTo: nameOfAlbumLabel.bottomAnchor, constant: 5).isActive = true
        timeOfAlbum.leadingAnchor.constraint(equalTo: nameOfAlbumLabel.leadingAnchor, constant: 0).isActive = true
        timeOfAlbum.trailingAnchor.constraint(equalTo: nameOfAlbumLabel.trailingAnchor, constant: -5).isActive = true
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //       self.layer.cornerRadius = 8
        //       self.clipsToBounds = true
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
