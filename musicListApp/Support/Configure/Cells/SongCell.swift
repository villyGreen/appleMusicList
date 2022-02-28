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
    let userNameLabel = UILabel()
   let containerView = UIView()
   static var reuseID = "SongCell"
   
   override func prepareForReuse() {
       userImage.image = nil
   }
   
   func configure<U>(value: U) where U : Hashable {
       guard let song:Song = value as? Song else {
           return
       }
       userNameLabel.text = song.nameOfSong
       let imageUrl = URL(string: song.image)
    print(imageUrl);
       userImage.sd_setImage(with: imageUrl, completed: nil)
   }
   
   private func setupConstraints() {
       userImage.translatesAutoresizingMaskIntoConstraints = false
       userNameLabel.translatesAutoresizingMaskIntoConstraints = false
       containerView.translatesAutoresizingMaskIntoConstraints = false
       
       self.addSubview(containerView)
       containerView.addSubview(userImage)
       containerView.addSubview(userNameLabel)
       
       containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
       containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
       containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
       containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
       
        userImage.backgroundColor = .red
    userImage.contentMode = .scaleAspectFill
       userImage.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
       userImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
       userImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
       userImage.heightAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
       
       userNameLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10).isActive = true
       userNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
       userNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
       
   }
   
   override init(frame: CGRect) {
       super.init(frame: frame)
    print("asfsa");
       self.backgroundColor = .red
       self.layer.cornerRadius = 8
       self.clipsToBounds = true
       setupConstraints()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
}
