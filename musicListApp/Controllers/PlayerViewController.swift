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
    let currentTimeLabel = UILabel()
    let allTimelabel = UILabel()
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
        
        plusButton.setImage(UIImage(named: "Add"), for: .normal)
        plusButton.tintColor = .systemTeal
        moreButton.setImage(UIImage(named: "moreButton"), for: .normal)
        moreButton.tintColor = .systemTeal
        
        volumeDownImage.image = UIImage(named: "Icon Min")
        volumeDownImage.contentMode = .scaleAspectFill
        
        volumeUpImage.image = UIImage(named: "Icon Max")
        volumeUpImage.contentMode = .scaleAspectFill
        volumeSlider.tintColor = .systemBlue
        
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.tintColor = .black
        stopButton.setImage(UIImage(named: "Pause"), for: .normal)
        stopButton.tintColor = .black
        nextButton.setImage(UIImage(named: "forwardButton"), for: .normal)
        nextButton.tintColor = .black
        
        nameOfSong.font = UIFont.systemFont(ofSize: 23)
        nameOfCreator.font = UIFont.systemFont(ofSize: 18)
        nameOfSong.textColor = UIColor.black.withAlphaComponent(0.9)
        nameOfCreator.textColor = UIColor.systemRed.withAlphaComponent(0.6)
        nameOfSong.text = "Three little birds"
        nameOfCreator.text = "Bob Marley"
        
        currentTimeLabel.text = "0:00"
        allTimelabel.text = "4:21"
        currentTimeLabel.font = UIFont.systemFont(ofSize: 12)
        allTimelabel.font = UIFont.systemFont(ofSize: 12)
        currentTimeLabel.textColor = UIColor.black.withAlphaComponent(0.7)
        allTimelabel.textColor = UIColor.black.withAlphaComponent(0.7)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        timeSlider.translatesAutoresizingMaskIntoConstraints = false
        
        timeSlider.tintColor = .systemRed
        
        guard let url = URL(string: song!.avatarStringURL) else { return }
        imageView.sd_setImage(with: url, completed: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        let timeStackView = UIStackView(arrangedSubviews: [currentTimeLabel, allTimelabel])
        timeStackView.axis = .horizontal
        timeStackView.spacing = 30
        timeStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeStackView)
        
        let nameStack = UIStackView(arrangedSubviews: [nameOfSong,nameOfCreator])
        nameStack.axis = .vertical
        nameStack.spacing = 10
        nameStack.alignment = .center
        nameStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameStack)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [backButton, stopButton, nextButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 10
        buttonsStackView.alignment = .center
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsStackView)
        
        let volumeStackView = UIStackView(arrangedSubviews: [volumeDownImage, volumeSlider, volumeUpImage])
        volumeStackView.axis = .horizontal
        volumeStackView.spacing = 18
        volumeStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(volumeStackView)
        
        let sideButtonsStackView = UIStackView(arrangedSubviews: [plusButton, moreButton])
        sideButtonsStackView.axis = .horizontal
        sideButtonsStackView.spacing = 30
        sideButtonsStackView.distribution = .fillEqually
        sideButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sideButtonsStackView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.4),
            imageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.2),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            timeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            timeSlider.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            timeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            timeStackView.topAnchor.constraint(equalTo: timeSlider.bottomAnchor, constant: 10),
            timeStackView.leadingAnchor.constraint(equalTo: timeSlider.leadingAnchor),
            timeStackView.trailingAnchor.constraint(equalTo: timeSlider.trailingAnchor),
            nameStack.topAnchor.constraint(equalTo: timeSlider.bottomAnchor, constant: 40),
            nameStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 40),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            volumeStackView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 80),
            volumeStackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            volumeStackView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            sideButtonsStackView.topAnchor.constraint(equalTo: volumeStackView.bottomAnchor, constant: 30),
            sideButtonsStackView.leadingAnchor.constraint(equalTo: volumeStackView.leadingAnchor),
            sideButtonsStackView.trailingAnchor.constraint(equalTo: volumeStackView.trailingAnchor)
        ])
    }
}
