//
//  SigninView.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 14.05.2024.
//

import UIKit

class SigninView: UIView {

    var onLoginTapped: ((_ phoneNumber: String, _ password: String) -> Void)?
     let emailTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Email"
           textField.borderStyle = .roundedRect
           textField.autocapitalizationType = .none
           return textField
       }()

        let passwordTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Password"
           textField.borderStyle = .roundedRect
           textField.isSecureTextEntry = true
           return textField
       }()

       private let loginButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Login", for: .normal)
           button.backgroundColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
           button.setTitleColor(.white, for: .normal)
           button.addTarget(self, action: #selector(handleLoginButtonTapped), for: .touchUpInside)
           button.layer.cornerRadius = 5
           return button
       }()

       override init(frame: CGRect) {
           super.init(frame: frame)
           setupViews()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       private func setupViews() {
           addSubview(emailTextField)
           addSubview(passwordTextField)
           addSubview(loginButton)

           emailTextField.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(20)
               make.left.right.equalToSuperview().inset(20)
               make.height.equalTo(44)
           }

           passwordTextField.snp.makeConstraints { make in
               make.top.equalTo(emailTextField.snp.bottom).offset(10)
               make.left.right.equalToSuperview().inset(20)
               make.height.equalTo(44)
           }

           loginButton.snp.makeConstraints { make in
               make.top.equalTo(passwordTextField.snp.bottom).offset(20)
               make.left.right.equalToSuperview().inset(20)
               make.height.equalTo(50)
           }
       }
    func prepareForSignIn() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    @objc private func handleLoginButtonTapped(){
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        onLoginTapped?(email, password)
    }

}

