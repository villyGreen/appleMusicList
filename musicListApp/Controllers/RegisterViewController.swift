//
//  RegisterViewController.swift
//  musicListApp
//
//  Created by zz on 09.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit


class RegisterViewController: UIViewController {
    
    let mainLabel = UILabel(textLabel: "Регистрация", fontLabel: UIFont(name: "Gill Sans", size: 25), textAlpha: 0.7, textColor: .black)
    let mainLogo = UIImageView(image: UIImage(named: "logo"))
    let userNameLabel = UILabel(textLabel: "Имя и Фамилия", fontLabel: UIFont.systemFont(ofSize: 15), textAlpha: 0.7, textColor: .black)
    let userNameTF = UITextField(fontTf: UIFont(name: "Gill Sans", size: 15))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setScrollView()
    }
    
}


extension RegisterViewController {
    private  func setConstraints() {
        view.backgroundColor = .white
        view.addSubview(mainLogo)
        view.addSubview(mainLabel)
        
        let userNameView = CustomView(label: userNameLabel, tf: userNameTF)
        view.addSubview(userNameView)
        view.addSubview(userNameTF)
        

        let imageStackView = UIStackView(arrangedSubviews: [mainLogo])
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageStackView)
        NSLayoutConstraint.activate([
            imageStackView.heightAnchor.constraint(equalToConstant: 60),
            imageStackView.widthAnchor.constraint(equalToConstant: 110),
            imageStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            imageStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 27),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 50),
            userNameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
    }
    
    private func setScrollView() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height + 100)
        view.addSubview(scrollView)
    }
    
}
