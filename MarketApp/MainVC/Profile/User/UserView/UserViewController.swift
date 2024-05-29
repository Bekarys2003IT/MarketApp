//
//  UserViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 22.05.2024.
//

import UIKit

class UserViewController: UIViewController {


    private lazy var detailsLabel:UILabel = {
        let label = UILabel()
        label.text = "User Details"
        label.font = .systemFont(ofSize: 35,weight: .bold)
        label.textColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        return label
    }()
    private lazy var avatarButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "person.circle"), for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    private lazy var nameTextField:UITextField = {
        let field = UITextField()
        field.placeholder = "Type your name"
        field.textColor = .black
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 8
        return field
    }()
    private lazy var emailTextField:UITextField = {
        let field = UITextField()
        field.placeholder = "Type your email"
        field.keyboardType = .emailAddress
        field.textColor = .black
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 8
        return field
    }()
    private lazy var phoneTextField:UITextField = {
        let field = UITextField()
        field.placeholder = "Type your phone"
        field.keyboardType = .phonePad
        field.textColor = .black
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 8
        return field
    }()
    private lazy var passwordTextField:UITextField = {
        let field = UITextField()
        field.placeholder = "Type your password"
        field.keyboardType = .default
        field.textColor = .black
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 8
        field.isSecureTextEntry = true
        return field
    }()
    private lazy var eyeButton: UIButton = {
            let button = UIButton(type: .custom)
            let eyeClosedImage = UIImage(systemName: "eye.slash")
            let eyeOpenImage = UIImage(systemName: "eye")
            button.setImage(eyeClosedImage, for: .normal)
            button.setImage(eyeOpenImage, for: .selected)
            button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
            return button
        }()

    private lazy var saveButton:UIButton = {
       let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25,weight: .bold)
        button.backgroundColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    private func setUI(){
        view.addSubview(detailsLabel)
        view.addSubview(avatarButton)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(phoneTextField)
        view.addSubview(passwordTextField)
        view.addSubview(eyeButton)
        view.addSubview(saveButton)
        
        //constraint
        detailsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(20)
        }
        avatarButton.snp.makeConstraints { make in
            make.top.equalTo(detailsLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(avatarButton.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        eyeButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.right.equalTo(passwordTextField.snp.right).inset(10)
            make.width.height.equalTo(30)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.width.equalTo(200)
            make.height.equalTo(70)
            make.centerX.equalToSuperview()
        }
  
    }
    
    @objc private func togglePasswordVisibility() {
            passwordTextField.isSecureTextEntry.toggle()
            eyeButton.isSelected.toggle()
        }

}
