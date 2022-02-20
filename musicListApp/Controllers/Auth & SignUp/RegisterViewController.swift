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
    let mainLabel = UILabel(textLabel: "Регистрация",
                            fontLabel: UIFont(name: "Gill Sans", size: 25),
                            textAlpha: 0.7, textColor: .black)
    let mainLogo = UIImageView(image: UIImage(named: "logo"))
    let userNameLabel = UILabel(textLabel: "Имя пользователя",
                                fontLabel: UIFont.systemFont(ofSize: 17),
                                textAlpha: 0.9, textColor: .black)
    let userNameTF = UITextField(fontTf: UIFont(name: "Gill Sans", size: 15))
    let phoneLabel = UILabel(textLabel: "Номер телефона",
                             fontLabel: UIFont.systemFont(ofSize: 17),
                             textAlpha: 0.9, textColor: .black)
    let phoneTf = UITextField(fontTf: UIFont(name: "Gill Sans", size: 15))
    let passwordTf = UITextField(fontTf: UIFont(name: "Gill Sans", size: 15))
    let passwordLabel = UILabel(textLabel: "Пароль", fontLabel: UIFont.systemFont(ofSize: 17),
                                textAlpha: 0.9, textColor: .black)
    let confirmPasswordLabel = UILabel(textLabel: "Потвердите Пароль", fontLabel: UIFont.systemFont(ofSize: 17),
                                       textAlpha: 0.9, textColor: .black)
    let confirmPasswordTf = UITextField(fontTf: UIFont(name: "Gill Sans", size: 15))
    let mailLabel = UILabel(textLabel: "Почта",
                            fontLabel: UIFont.systemFont(ofSize: 17),
                            textAlpha: 0.9, textColor: .black)
    let mailTF = UITextField(fontTf: UIFont(name: "Gill Sans", size: 15))
    var warningLabels = [UILabel]()
    let inputButton = UIButton(type: .system)
    let alreadyRegisterlabel = UILabel(textLabel: "Уже зарегистрированы?",
                                       fontLabel: UIFont(name: "Gill Sans", size: 22),
                                       textAlpha: 0.9, textColor: .black)
    let alreadyRegisterbutton = UIButton()
    var activeTextField: UITextField? = nil
    var isError = false
    // MARK: - ViewDidLoad
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
    // MARK: - Scroll view
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.contentSize =  CGSize(width: view.frame.size.width + 2, height: view.frame.size.height + 100)
    }
    // MARK: - Setup elements
    private func setupElements() {
        userNameTF.tag = 1
        phoneTf.tag = 2
        passwordTf.tag = 3
        confirmPasswordTf.tag = 4
        mailTF.tag = 5
        passwordTf.textContentType = .oneTimeCode
        confirmPasswordTf.textContentType = .oneTimeCode
        mailTF.autocapitalizationType = .none
        passwordTf.isSecureTextEntry = true
        confirmPasswordTf.isSecureTextEntry = true
        alreadyRegisterbutton.setTitle("Войти", for: .normal)
        alreadyRegisterbutton.setTitleColor(.red, for: .normal)
        alreadyRegisterbutton.titleLabel?.font = UIFont(name: "Gill Sans", size: 22)
        alreadyRegisterbutton.alpha = 0.81
        inputButton.setTitle("Регистрация", for: .normal)
        inputButton.setTitleColor(.systemRed, for: .normal)
        inputButton.alpha = 0.81
        inputButton.titleLabel?.font = UIFont(name: "Gill Sans", size: 22)
        inputButton.addTarget(self, action: #selector(touchesButton), for: .touchUpInside)
        alreadyRegisterbutton.addTarget(self, action: #selector(unwindFunc), for: .touchUpInside)
        
    }
    @objc private func touchesButton() {
        if !isError {
            AuthService.shared.register(email: mailTF.text!, password: passwordTf.text!) { result in
                switch result {
                    
                case .success(let user):
                    self.showAlert(title: "Успешно", message: "Пользователь успешно зарегистрирован", actionOne: "Ok", actionTwo: "Back")
                case .failure(let error):
                    self.showAlert(title: "Ошибка", message: error.localizedDescription,actionOne: "Ok", actionTwo: "Back")
                }
            }
            }
        }
    
    @objc private func unwindFunc() {
        self.dismiss(animated: true, completion: nil)
    }
    private func setConstraints() {
        view.backgroundColor = .white
        scrollView.addSubview(mainLogo)
        mainLogo.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let mailStackView = UIStackView(arrangedSubviews: [mailLabel, mailTF, warningLabels[0]])
        mailStackView.axis = .vertical
        mailStackView.spacing = 19
        let userNameStackView = UIStackView(arrangedSubviews: [userNameLabel, userNameTF, warningLabels[1]])
        userNameStackView.axis = .vertical
        userNameStackView.spacing = 19
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        let phoneStackView = UIStackView(arrangedSubviews: [phoneLabel, phoneTf, warningLabels[2]])
        phoneStackView.axis = .vertical
        phoneStackView.spacing = 19
        phoneStackView.translatesAutoresizingMaskIntoConstraints = false
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTf, warningLabels[3]])
        passwordStackView.axis = .vertical
        passwordStackView.spacing = 19
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordLabel,
                                                                      confirmPasswordTf,
                                                                      warningLabels[4]])
        confirmPasswordStackView.axis = .vertical
        confirmPasswordStackView.spacing = 19
        confirmPasswordStackView.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordStackView.widthAnchor.constraint(equalToConstant: (view.frame.width - 40)).isActive = true
        let contentView = UIStackView(arrangedSubviews: [userNameStackView, mailStackView, phoneStackView,
                                                         passwordStackView, confirmPasswordStackView, inputButton])
        contentView.axis = .vertical
        contentView.spacing = 55
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        let bottomStack = UIStackView(arrangedSubviews: [alreadyRegisterlabel, alreadyRegisterbutton])
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
        for item in 0..<5 {
            warningLabels[item].isHidden = true
        }
    }
    private func createWarningLabel() {
        for _ in 0..<5 {
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
        mailTF.delegate = self
        confirmPasswordTf.delegate = self
        phoneTf.delegate = self
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(keyBoardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
}
extension RegisterViewController: UITextFieldDelegate {
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
        
        switch textField.tag {
            
        case 1:
            if !ValidateService.shared.validate(searchString: userNameTF.text!, mode: 3) {
                warningLabels[1].isHidden = false
                warningLabels[1].text = "Неккоректный ввод"
                isError = true
            } else {
                warningLabels[1].isHidden = true
                isError = false
            }
        case 2:
            if !ValidateService.shared.validate(searchString: phoneTf.text!, mode: 1) {
                warningLabels[2].isHidden = false
                warningLabels[2].text = "Неккоректный ввод"
                  isError = true
            } else {
                warningLabels[2].isHidden = true
                isError = false
            }
        case 3:
            if !ValidateService.shared.validate(searchString: passwordTf.text!, mode: 2) {
                warningLabels[3].isHidden = false
                warningLabels[3].text = "Неккоректный ввод"
                  isError = true
            } else {
                warningLabels[3].isHidden = true
                isError = false
            }
        case 4:
            if !ValidateService.shared.comparePassword(firstPassword: passwordTf.text!, secondPassword: confirmPasswordTf.text!) {
                warningLabels[4].isHidden = false
                warningLabels[4].text = "Пароли не совпадают"
                  isError = true
            } else {
                warningLabels[4].isHidden = true
                  isError = false
            }
        case 5:
            print("tuts")
            if !ValidateService.shared.validate(searchString: mailTF.text!, mode: 0) {
                warningLabels[0].isHidden = false
                warningLabels[0].text = "Неккоректный ввод"
            } else {
                warningLabels[0].isHidden = true
            }
            
        default:
            break
        }
        self.activeTextField = nil
    }
}
