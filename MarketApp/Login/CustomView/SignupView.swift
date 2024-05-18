//
//  SignupView.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 14.05.2024.
//

import UIKit

class SignupView: UIView {

    
    private let fullNameTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Full Name"
           textField.borderStyle = .roundedRect
           return textField
       }()

       private let emailTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Email Address"
           textField.borderStyle = .roundedRect
           textField.autocapitalizationType = .none
           return textField
       }()

       private let passwordTextField: UITextField = {
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
           
           addSubview(fullNameTextField)
           addSubview(emailTextField)
           addSubview(passwordTextField)
           addSubview(registerButton)

          
           fullNameTextField.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(20)
               make.left.right.equalToSuperview().inset(20)
               make.height.equalTo(44)
           }

           emailTextField.snp.makeConstraints { make in
               make.top.equalTo(fullNameTextField.snp.bottom).offset(10)
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
       }

}
