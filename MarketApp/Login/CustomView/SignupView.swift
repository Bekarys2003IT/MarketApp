//
//  SignupView.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 14.05.2024.
//

import UIKit

class SignupView: UIView {
    
    var onRegisterTapped: ((_ fullName: String, _ phone: String, _ email: String, _ password: String, _ completion: @escaping (Bool, Error?) -> Void) -> Void)?

    
    let registerFullNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Full Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let registerPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone number"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()
     let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Create Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        addSubview(registerFullNameTextField)
        addSubview(registerPhoneTextField)
        addSubview(emailTextField)
        addSubview(registerButton)
        addSubview(messageLabel)
        addSubview(passwordTextField)
        
        registerFullNameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        registerPhoneTextField.snp.makeConstraints { make in
            make.top.equalTo(registerFullNameTextField.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(registerPhoneTextField.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
                       make.top.equalTo(emailTextField.snp.bottom).offset(10)
                       make.left.right.equalToSuperview().inset(20)
                       make.height.equalTo(44)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    func configureButtonAction(using action: @escaping () -> Void) {
        registerButton.addTarget(nil, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func registerButtonTapped() {
        guard let firstName = registerFullNameTextField.text, !firstName.isEmpty,
              let phone = registerPhoneTextField.text, !phone.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            highlightEmptyFields()
            return
        }
        onRegisterTapped?(firstName, phone, email, password, { (success: Bool, error: Error?) in
               if success {
                   self.registrationSuccess()
               } else if let error = error {
                self.showError(error)
            }
        })
    }
    func showError(_ error: Error) {
        showMessage("Error: \(error.localizedDescription)", isError: true)
    }
    func highlightEmptyFields() {
        if registerFullNameTextField.text?.isEmpty ?? true {
            registerFullNameTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            registerFullNameTextField.layer.borderColor = UIColor.green.cgColor
        }
        
        if registerPhoneTextField.text?.isEmpty ?? true {
            registerPhoneTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            registerPhoneTextField.layer.borderColor = UIColor.green.cgColor
        }
        showMessage("Please fill in all required fields.", isError: true)
    }
    
    private func showMessage(_ text: String, isError: Bool) {
        messageLabel.text = text
        messageLabel.textColor = isError ? .red : .green
        UIView.animate(withDuration: 0.5) {
            self.messageLabel.alpha = 1
        }
    }
    func showRegistrationFailed() {
        showMessage("Registration failed. Please try again.", isError: true)
    }
    
    func registrationSuccess() {
        showMessage("Successfully registered", isError: false)
    }

}
