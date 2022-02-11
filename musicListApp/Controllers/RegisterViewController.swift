//
//  RegisterViewController.swift
//  musicListApp
//
//  Created by zz on 09.02.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit


class RegisterViewController: UIViewController {
    
    var scrollView = UIScrollView()
    let mainLabel = UILabel(textLabel: "Регистрация", fontLabel: UIFont(name: "Gill Sans", size: 25), textAlpha: 0.7, textColor: .black)
    let mainLogo = UIImageView(image: UIImage(named: "logo"))
    let userNameLabel = UILabel(textLabel: "Имя и Фамилия", fontLabel: UIFont.systemFont(ofSize: 17), textAlpha: 0.9, textColor: .black)
    let userNameTF = UITextField(fontTf: UIFont(name: "Gill Sans", size: 15))
    let phoneLabel = UILabel(textLabel: "Номер телефона", fontLabel: UIFont.systemFont(ofSize: 17), textAlpha: 0.9, textColor: .black)
    let phoneTf = UITextField(fontTf: UIFont(name: "Gill Sans", size: 15))
    let passwordTf = UITextField(fontTf: UIFont(name: "Gill Sans", size: 15))
    let passwordLabel = UILabel(textLabel: "Пароль", fontLabel: UIFont.systemFont(ofSize: 17), textAlpha: 0.9, textColor: .black)
    let confirmPasswordLabel = UILabel(textLabel: "Потвердите Пароль", fontLabel: UIFont.systemFont(ofSize: 17), textAlpha: 0.9, textColor: .black)
    let confirmPasswordTf = UITextField(fontTf: UIFont(name: "Gill Sans", size: 15))
    var warningLabels = [UILabel]()
    let inputButton = UIButton(type: .system)
    let alreadyRegisterlabel = UILabel(textLabel: "Уже зарегистрированы?",
                                       fontLabel: UIFont(name: "Gill Sans", size: 22),
                                       textAlpha: 0.9, textColor: .black)
    let alreadyRegisterbutton = UIButton()
    var activeTextField : UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createWarningLabel()
        allWarningisHiden()
        addNotificationObservers()
        setupElements()
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupScrollView()
    }
    
}

extension RegisterViewController {
    
    
    private func setupScrollView() {
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.contentSize =  CGSize(width: view.frame.size.width + 2, height: view.frame.size.height + 100)
    }
    
    private func setupElements() {
        
        alreadyRegisterbutton.setTitle("Войти", for: .normal)
        alreadyRegisterbutton.setTitleColor(.red, for: .normal)
        alreadyRegisterbutton.titleLabel?.font = UIFont(name: "Gill Sans", size: 22)
        alreadyRegisterbutton.alpha = 0.81
        
        inputButton.setTitle("Регистрация", for: .normal)
        inputButton.addTarget(self, action: #selector(touchesButton), for: .touchUpInside)
        inputButton.setTitleColor(.systemRed, for: .normal)
        inputButton.alpha = 0.81
        inputButton.titleLabel?.font = UIFont(name: "Gill Sans", size: 22)
        
    }
    
    @objc private func touchesButton() {
        for i in 0..<4 {
            warningLabels[i].isHidden = false
        }
    }
    
    private func setConstraints() {
        view.backgroundColor = .white
        
        scrollView.addSubview(mainLogo)
        mainLogo.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let userNameStackView = UIStackView(arrangedSubviews: [userNameLabel,userNameTF,warningLabels[0]])
        userNameStackView.axis = .vertical
        userNameStackView.spacing = 19
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let phoneStackView = UIStackView(arrangedSubviews: [phoneLabel,phoneTf,warningLabels[1]])
        phoneStackView.axis = .vertical
        phoneStackView.spacing = 19
        phoneStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel,passwordTf,warningLabels[2]])
        passwordStackView.axis = .vertical
        passwordStackView.spacing = 19
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordLabel,confirmPasswordTf,warningLabels[3]])
        confirmPasswordStackView.axis = .vertical
        confirmPasswordStackView.spacing = 19
        confirmPasswordStackView.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordStackView.widthAnchor.constraint(equalToConstant: (view.frame.width - 40)).isActive = true
        let contentView = UIStackView(arrangedSubviews: [userNameStackView,phoneStackView,passwordStackView,confirmPasswordStackView,inputButton])
        contentView.axis = .vertical
        contentView.spacing = 55
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        
        let bottomStack = UIStackView(arrangedSubviews: [alreadyRegisterlabel,alreadyRegisterbutton])
        bottomStack.axis = .vertical
        bottomStack.spacing = 10
        bottomStack.alignment = .center
        
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(bottomStack)
        
        // Cosntraints
        NSLayoutConstraint.activate([
            mainLogo.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.07),
            mainLogo.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.25),
            mainLogo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            mainLogo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: mainLogo.bottomAnchor, constant: 20),
            mainLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 50),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            bottomStack.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            bottomStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            bottomStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            bottomStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func allWarningisHiden() {
        for i in 0..<4 {
            warningLabels[i].isHidden = true
        }
    }
    
    private func createWarningLabel() {
        
        for _ in 0..<4 {
            let label = UILabel()
            label.text = "Неправильный формат"
            label.textColor = .systemRed
            label.alpha = 0.8
            label.font = UIFont(name: "Gill Sans", size: 13)
            warningLabels.append(label)
        }
    }
    
    private func addNotificationObservers() {
        
        
        userNameTF.delegate = self
        passwordTf.delegate = self
        confirmPasswordTf.delegate = self
        phoneTf.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}


extension RegisterViewController: UITextFieldDelegate {
    
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        guard  let keySize =  (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        
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
    
    @objc func keyBoardWillHide(notification : Notification) {
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
        self.activeTextField = nil
    }
}
