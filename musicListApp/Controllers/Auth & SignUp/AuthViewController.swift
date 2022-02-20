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
    
    let mailLabel = UILabel(textLabel: "Почта",
                            fontLabel: UIFont.systemFont(ofSize: 17),
                            textAlpha: 0.9, textColor: .black)
    let mailTF = UITextField(fontTf: UIFont(name: "Gill Sans", size: 15))
    let passwordTf = UITextField(fontTf: UIFont(name: "Gill Sans", size: 15))
    let passwordLabel = UILabel(textLabel: "Пароль", fontLabel: UIFont.systemFont(ofSize: 17),
                                textAlpha: 0.9, textColor: .black)
    var activeTextField: UITextField? = nil
    let inputButton = UIButton(type: .system)
    let orLabel = UILabel(textLabel: "Или", fontLabel: UIFont(name: "Gill Sans", size: 20), textAlpha: 0.61, textColor: .black)
    var warningLabels = [UILabel]()
    var isError = false
    var changeMailAndPassword = false
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
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTf, warningLabels[1]])
        passwordStackView.axis = .vertical
        passwordStackView.spacing = 19
      
        
        let mailStackView = UIStackView(arrangedSubviews: [mailLabel,mailTF,warningLabels[2]])
        mailStackView.axis = .vertical
        mailStackView.spacing = 19
        
        let contentView = UIStackView(arrangedSubviews: [ mailStackView, passwordStackView, orLabel, phoneStackView, inputButton])
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
        phoneTfNameTF.delegate = self
        mailTF.delegate = self
        passwordTf.delegate = self
        phoneTfNameTF.tag = 1
        passwordTf.tag = 2
        mailTF.tag = 3
        passwordTf.textContentType = .oneTimeCode
        passwordTf.isSecureTextEntry = true
        inputButton.setTitle("Войти", for: .normal)
        inputButton.setTitleColor(.systemRed, for: .normal)
        inputButton.alpha = 0.81
        inputButton.titleLabel?.font = UIFont(name: "Gill Sans", size: 22)
        inputButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(keyBoardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func logIn() {
            print("wp")
        if changeMailAndPassword {
            print("gg")
            if !isError {
                print("jj")
                AuthService.shared.logIn(email: mailTF.text!, password: passwordTf.text!) { (result) in
                    switch result {
                    case .success(let user):
                        self.showAlert(title: "Успех", message: "gg", actionOne: "Ок", actionTwo: "Назад")
                    case .failure(let error):
                          self.showAlert(title: "Ошибка", message: error.localizedDescription,actionOne: "Ok", actionTwo: "Back")
                    }
                }
            }
        }
    }
    

    private func allWarningisHiden() {
        for item in 0..<3 {
            warningLabels[item].isHidden = true
        }
    }
    private func createWarningLabel() {
        for _ in 0..<3 {
            let label = UILabel()
            label.text = "Неправильный формат"
            label.textColor = .systemRed
            label.alpha = 0.8
            label.font = UIFont(name: "Gill Sans", size: 13)
            warningLabels.append(label)
        }
    }
}

extension AuthViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)}
    @objc func keyBoardWillShow(notification: NSNotification) {
        guard let keySize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? NSValue)?.cgRectValue else {return}
        var shouldMoveViewUp = false
        if let activeTF = activeTextField {
            let bottomOfTf = activeTF.convert(activeTF.bounds, to: self.view).maxY
            let topOfKeyboard = self.view.frame.height - keySize.height
            if bottomOfTf > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        if shouldMoveViewUp {
            self.view.frame.origin.y = 100 - keySize.height
        }
    }
    @objc func keyBoardWillHide(notification: Notification) {
        self.view.frame.origin.y = 0
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 3 {
            phoneTfNameTF.text = nil
            warningLabels[0].isHidden = true
            phoneTfNameTF.isUserInteractionEnabled = false
            isError = false
            changeMailAndPassword = true
        }
        
        if textField.tag == 1 {
            mailTF.text = nil
            mailTF.isUserInteractionEnabled = false
            warningLabels[2].isHidden = true
            warningLabels[1].isHidden = true
            passwordTf.text = nil
            passwordTf.isUserInteractionEnabled = false
            isError = false
            changeMailAndPassword = true
        }
        
        switch textField.tag {
            
        case 1:
            if !ValidateService.shared.validate(searchString: phoneTfNameTF.text!, mode: 1) {
                warningLabels[0].isHidden = false
                warningLabels[0].text = "Неккоректный ввод"
                       isError = true
            } else {
                warningLabels[0].isHidden = true
                       isError = false
            }
        case 2:
            if !ValidateService.shared.validate(searchString: passwordTf.text!, mode: 3) {
                warningLabels[1].isHidden = false
                warningLabels[1].text = "Неккоректный ввод"
                  isError = true
            } else {
                warningLabels[1].isHidden = true
                       isError = false
            }
        case 3:
            if !ValidateService.shared.validate(searchString: mailTF.text!, mode: 0) {
                warningLabels[2].isHidden = false
                warningLabels[2].text = "Неккоректный ввод"
                  isError = true
            } else {
                warningLabels[2].isHidden = true
                       isError = false
            }
            
        default:
            break
        }
        self.activeTextField = nil
    }
}
