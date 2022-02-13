//
//  AuthViewController.swift
//  musicListApp
//
//  Created by zz on 13.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit



class AuthViewController: UIViewController {
    
    let mainLabel = UILabel(textLabel: "Авторизация",
                            fontLabel: UIFont(name: "Gill Sans", size: 25),
                            textAlpha: 0.7, textColor: .black)
    let mainLogo = UIImageView(image: UIImage(named: "logo"))
    let phoneTfNameTF = UITextField(fontTf: UIFont(name: "Gill Sans", size: 15))
    let phoneLabel = UILabel(textLabel: "Номер телефона",
                             fontLabel: UIFont.systemFont(ofSize: 17),
                             textAlpha: 0.9, textColor: .black)
    let passwordTf = UITextField(fontTf: UIFont(name: "Gill Sans", size: 15))
    let passwordLabel = UILabel(textLabel: "Пароль", fontLabel: UIFont.systemFont(ofSize: 17),
                                textAlpha: 0.9, textColor: .black)
    var activeTextField: UITextField? = nil
    let inputButton = UIButton(type: .system)
    var warningLabels = [UILabel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        createWarningLabel()
        allWarningisHiden()
        setConstraints()
        setupElements()
    }
}

extension AuthViewController {
    
    private func setConstraints() {
        view.backgroundColor = .white
        view.addSubview(mainLabel)
        view.addSubview(mainLogo)
        mainLogo.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let phoneStackView = UIStackView(arrangedSubviews: [phoneLabel, phoneTfNameTF, warningLabels[0]])
        phoneStackView.axis = .vertical
        phoneStackView.spacing = 19
        phoneStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTf, warningLabels[1]])
        passwordStackView.axis = .vertical
        passwordStackView.spacing = 19
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let contentView = UIStackView(arrangedSubviews: [ phoneStackView,
                                                          passwordStackView, inputButton])
        contentView.axis = .vertical
        contentView.spacing = 55
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            mainLogo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            mainLogo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            mainLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            mainLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: mainLogo.bottomAnchor, constant: 20),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 50),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)])
    }
    
    private func setupElements() {
        phoneTfNameTF.tag = 1
        passwordTf.tag = 2
        passwordTf.textContentType = .oneTimeCode
        passwordTf.isSecureTextEntry = true
        inputButton.setTitle("Войти", for: .normal)
        inputButton.setTitleColor(.systemRed, for: .normal)
        inputButton.alpha = 0.81
        inputButton.titleLabel?.font = UIFont(name: "Gill Sans", size: 22)
        inputButton.addTarget(self, action: #selector(unwindFunc), for: .touchUpInside)
    }
    
    @objc private func unwindFunc() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func allWarningisHiden() {
        for item in 0..<2 {
            warningLabels[item].isHidden = true
        }
    }
    private func createWarningLabel() {
        for _ in 0..<2 {
            let label = UILabel()
            label.text = "Неправильный формат"
            label.textColor = .systemRed
            label.alpha = 0.8
            label.font = UIFont(name: "Gill Sans", size: 13)
            warningLabels.append(label)
        }
    }
}
