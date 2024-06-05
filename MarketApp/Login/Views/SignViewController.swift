//
//  SignViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 13.05.2024.
//

import UIKit

class SignViewController: UIViewController, SigninViewProtocol, SignupViewProtocol {
    
    private var presenter: SignPresenter!
    
    private lazy var bowlImage:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Saladbowl")
        return image
    }()
    private lazy var segmentControl :UISegmentedControl = {
        var segment = UISegmentedControl()
        segment = UISegmentedControl(items: ["Sign in","Sign up"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        segment.backgroundColor = .clear
        segment.tintColor = .clear
        let normalFont = UIFont.systemFont(ofSize: 16)
        let selectedFont = UIFont.boldSystemFont(ofSize: 16)
        segment.setTitleTextAttributes([.font: normalFont, .foregroundColor: UIColor.lightGray], for: .normal)
        segment.setTitleTextAttributes([.font: selectedFont, .foregroundColor: UIColor.black], for: .selected)
        return segment
    }()
    private var underlineLeftConstraint: NSLayoutConstraint?
    private lazy var whiteView:UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private lazy var underlineView: UIView = {
           let view = UIView()
           view.backgroundColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
           return view
       }()
    private let signInView = SigninView()
    private let signUpView = SignupView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter = SignPresenter(signinView: self, signupView: self)
        setUI()
        segmentedControlChanged()
        configureSignUpView()
        configureSignInView()
    }
    private func setUI(){
        view.addSubview(bowlImage)
        view.addSubview(whiteView)
        whiteView.addSubview(segmentControl)
        whiteView.addSubview(underlineView)
        view.addSubview(signInView)
        view.addSubview(signUpView)
        
        //constraint
        bowlImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalTo(320)
            make.width.equalToSuperview()
        }
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(bowlImage.snp.top).offset(290)
            make.height.equalTo(50)
            make.width.equalToSuperview()
        }
        segmentControl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        underlineView.snp.makeConstraints { make in
            make.bottom.equalTo(segmentControl.snp.bottom)
            make.height.equalTo(2)
            make.width.equalTo(segmentControl.snp.width).dividedBy(segmentControl.numberOfSegments)
            make.left.equalTo(segmentControl.snp.left) // Initially align to the first segment
        }
        signInView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
        
        signUpView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }

    }
    func showSuccess() {
        let alert = UIAlertController(title: "Registration Successful", message: "You have successfully registered.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Registration Failed", message: "Error: \(error.localizedDescription)\nWould you like to retry?", preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.attemptRegistration() // Retry registration
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(retryAction)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    private func attemptRegistration() {
        guard let fullName = signUpView.registerFullNameTextField.text, !fullName.isEmpty,
              let phone = signUpView.registerPhoneTextField.text, !phone.isEmpty,
              let email = signUpView.emailTextField.text, !email.isEmpty,
              let password = signUpView.passwordTextField.text, !password.isEmpty else {
            signUpView.highlightEmptyFields()
            return
        }
        signUpView.onRegisterTapped?(fullName, phone,email, password) { [weak self] success, error in
            if success {
                self?.showSuccess()
            } else if let error = error {
                self?.showError(error)
            }
        }
    }
    
    @objc private func segmentedControlChanged() {
        let selectedIndex = segmentControl.selectedSegmentIndex
        presenter.segmentedControlChanged(selectedIndex: selectedIndex)
        updateSignInVisibility(isVisible: selectedIndex == 0)
    }
    func updateSignInVisibility(isVisible: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.signInView.alpha = isVisible ? 1 : 0
            self.signUpView.alpha = isVisible ? 0 : 1
            
            self.underlineView.snp.updateConstraints { make in
                make.left.equalTo(self.segmentControl.snp.left).offset(self.segmentControl.selectedSegmentIndex * Int(self.segmentControl.frame.width / CGFloat(self.segmentControl.numberOfSegments)))
            }
            self.view.layoutIfNeeded()
        }
    }
   

}
extension SignViewController {
    private func configureSignUpView() {
        signUpView.onRegisterTapped = { [weak self] (fullName: String, phone: String, email: String, password: String, completion: @escaping (Bool, Error?) -> Void) in
                 let user = User(fullName: fullName, phoneNumber: phone, email: email, password: password)
                 self?.presenter.registerUser(user: user, completion: completion)
             }
        }
    private func configureSignInView() {
        signInView.onLoginTapped = { [weak self] email, password in
                    self?.presenter.loginUser(email: email, password: password)
            }
        }
    func prepareForSignIn() {
        let vc = SigninView()
        vc.emailTextField.text = ""
        vc.passwordTextField.text = ""
    }
    func showLoginSuccess() {
            let testingVC = TestingViewController()
            self.navigationController?.pushViewController(testingVC, animated: true)
    }

        func showLoginError(_ error: Error) {
            let alert = UIAlertController(title: "Login Failed", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    
}
