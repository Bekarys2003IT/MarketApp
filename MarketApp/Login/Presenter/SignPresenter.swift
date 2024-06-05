//
//  SignPresenter.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 14.05.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
protocol SigninViewProtocol: AnyObject {
    func showLoginError(_ error: Error)
    func showLoginSuccess()
    func prepareForSignIn()
}

protocol SignupViewProtocol: AnyObject {
    func showSuccess()
    func showError(_ error: Error)
}

protocol SignPresenterProtocol {
    func loginUser(email: String, password: String)
    func registerUser(user: User, completion: @escaping (Bool, Error?) -> Void)
    func segmentedControlChanged(selectedIndex: Int)
}

class SignPresenter: SignPresenterProtocol {
    weak var signinView: SigninViewProtocol?
    weak var signupView: SignupViewProtocol?
    
    init(signinView: SigninViewProtocol?, signupView: SignupViewProtocol?) {
        self.signinView = signinView
        self.signupView = signupView
    }
    
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.signinView?.showLoginError(error)
            } else {
                self?.signinView?.showLoginSuccess()
            }
        }
    }
    
    func registerUser(user: User, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
            if let error = error {
                completion(false, error)
                self.signupView?.showError(error)
            } else if let authResult = authResult {
                let db = Firestore.firestore()
                db.collection("users").document(authResult.user.uid).setData([
                    "fullName": user.fullName,
                    "phoneNumber": user.phoneNumber,
                    "password": user.password
                ]) { err in
                    if let err = err {
                        completion(false, err)
                    } else {
                        completion(true, nil)
                        self.signupView?.showSuccess()
                    }
                }
            }
        }
    }
    
    func segmentedControlChanged(selectedIndex: Int) {
        if selectedIndex == 0 {
            signinView?.prepareForSignIn()
        }
    }
}
