//
//  AlbumViewController.swift
//  musicListApp
//
//  Created by zz on 01.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit
import  SDWebImage

class AlbumViewController: UIViewController {
    
    let mainImageView = UIImageView()
    let mainNameOfAlbum = UILabel()
    let timeOfAlbum = UILabel()
    let nameOfCreator = UILabel()
    let plusButton = UIButton(type: .system)
    let listenButton = UIButton(type: .system)
    var tableView : UITableView?
    var song: Song?
    
    
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
        view.addSubview(mainImageView)
       
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageUrl = URL(string: song!.avatarStringURL)
        mainImageView.sd_setImage(with: imageUrl, completed: nil)
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 10
        mainImageView.clipsToBounds = true
        
        mainNameOfAlbum.text = song?.username
        mainNameOfAlbum.font = UIFont.systemFont(ofSize: 15)
        
        timeOfAlbum.text = "35:12"
        timeOfAlbum.font = UIFont.systemFont(ofSize: 11)
        timeOfAlbum.textColor = UIColor.black.withAlphaComponent(0.6)
        
        nameOfCreator.text = "Test author"
        nameOfCreator.font = UIFont.systemFont(ofSize: 13)
        nameOfCreator.textColor = UIColor.black.withAlphaComponent(08)
        
        plusButton.setTitle("Добавить", for: .normal)
        plusButton.tintColor = .systemRed
        
        listenButton.setTitle("Слушать", for: .normal)
        listenButton.tintColor = .red
        
        let contentStack = UIStackView(arrangedSubviews: [mainNameOfAlbum, nameOfCreator, timeOfAlbum])
        contentStack.axis = .vertical
        contentStack.spacing = 10
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        tableView = UITableView(frame: CGRect(x: 0, y: 230, width: view.bounds.width, height: view.bounds.height - 300))
        tableView?.register(songTableViewCell.self, forCellReuseIdentifier: songTableViewCell.id)
        tableView?.separatorStyle = .none
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
        view.addSubview(contentStack)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [listenButton, plusButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 30
        buttonsStackView.distribution = .fillEqually
        
        view.addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            mainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainImageView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -150),
            mainImageView.heightAnchor.constraint(equalToConstant: 120),
            mainImageView.widthAnchor.constraint(equalToConstant: 120),
            contentStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            contentStack.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 30),
            contentStack.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: -20),
            buttonsStackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
}

extension AlbumViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: songTableViewCell.id, for: indexPath) as! songTableViewCell
        cell.numeration.text = "\(indexPath.row)"
        cell.nameOfSong.text = "test song"
        cell.timeOfSong.text = "3:21"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let playerVc = PlayerViewController(song: song!) else { return }
        self.present(playerVc, animated: true, completion: nil)
    }
}
