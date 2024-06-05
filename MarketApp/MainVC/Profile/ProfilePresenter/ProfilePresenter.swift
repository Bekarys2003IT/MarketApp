//
//  ProfilePresenter.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 18.05.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
protocol ProfilePresenterProtocol {
    func loadProfile()
    func logoutRequested()
    func confirmLogout()
}
class ProfilePresenter {
    private weak var view: ProfileViewProtocol?
    
    init(view: ProfileViewProtocol? = nil) {
        self.view = view
    }
    func loadProfile() {
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

                let name = data["fullName"] as? String ?? "No Name"
                let email = user.email ?? "No Email"

                DispatchQueue.main.async {
                    self?.view?.updateProfile(with: name, email: email)
                }
            }
        }
    func logoutRequested() {
            view?.showLogoutConfirmation()
        }

        func confirmLogout() {
            do {
                try Auth.auth().signOut()
                view?.navigateToSignIn()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
}
