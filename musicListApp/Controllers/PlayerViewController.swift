//
//  File.swift
//  musicListApp
//
//  Created by zz on 02.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit
import SDWebImage



class PlayerViewController: UIViewController {
    var song: Song?
    let imageView = UIImageView()
    let timeSlider = UISlider()
    let nameOfSong = UILabel()
    let nameOfCreator = UILabel()
    let plusButton = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    let stopButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let moreButton = UIButton(type: .system)
    let volumeSlider = UISlider()
    let volumeDownImage = UIImageView()
    let volumeUpImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    init?(song: Song) {
        super.init(nibName: nil, bundle: nil)
        self.song = song
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(timeSlider)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false 
        guard let url = URL(string: song!.avatarStringURL) else { return }
        imageView.sd_setImage(with: url, completed: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.4),
            imageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.2),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
}
