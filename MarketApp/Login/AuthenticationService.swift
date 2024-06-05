//
//  AuthenticationService.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 01.06.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class AuthenticationService {
    func signIn(phoneNumber: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: phoneNumber, password: password) { result, error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }

    func register(user: User, completion: @escaping (Bool, Error?) -> Void) {
            Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
                if let error = error {
                    completion(false, error)
                } else if let authResult = result {
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
                        }
                    }
                }
            }
        }
    func sendVerificationCode(to phoneNumber: String, completion: @escaping (String?, Error?) -> Void) {
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    completion(nil, error)
                } else if let verificationID = verificationID {
                    completion(verificationID, nil)
                }
            }
        }

        func verifyCode(_ verificationCode: String, verificationID: String, completion: @escaping (Bool, Error?) -> Void) {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID,
                                                                     verificationCode: verificationCode)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(false, error)
                } else {
                    completion(true, nil)
                }
            }
        }
}
