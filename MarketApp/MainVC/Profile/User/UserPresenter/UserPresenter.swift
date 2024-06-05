//
//  UserPresenter.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 03.06.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
protocol UserPresenterProtocol: AnyObject {
    init(view: UserViewController, authService: AuthenticationService)
    func viewWillAppear()
}

class UserPresenter: UserPresenterProtocol {
    required init(view: UserViewController, authService: AuthenticationService) {
        self.view = view
        self.authService = authService
    }
    
    weak var view: UserViewController?
    private let authService: AuthenticationService
    
    func viewWillAppear() {
        fetchUserData()
    }
    
    func fetchUserData() {
        guard let user = Auth.auth().currentUser else {
            print("No current user found.")
            return
        }
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching user data: \(error)")
                return
            }
            guard let document = document, document.exists, let data = document.data() else {
                print("Document does not exist")
                return
            }
            let userModel = UserModel(
                name: data["fullName"] as? String ?? "No Name",
                email: user.email ?? "No Email",
                number: data["phoneNumber"] as? String ?? "No Phone",
                password: data["password"] as? String ?? ""
            )
            DispatchQueue.main.async {
                self?.view?.displayUserData(userModel)
            }
        }
    }
}
