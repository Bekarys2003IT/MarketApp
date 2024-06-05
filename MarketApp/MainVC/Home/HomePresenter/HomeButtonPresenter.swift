//
//  HomeButtonPresenter.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 15.05.2024.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
protocol ButtonPresenterDelegate: AnyObject {
    func displayButtons(titles:[String])
    func buttonPressed(title: String)
    func loadProfile()
}
class HomeButtonPresenter {
    private let buttons = [
    HomeButtonModel(title: "Recommended"),
    HomeButtonModel(title: "Popular"),
    HomeButtonModel(title: "Meat"),
    HomeButtonModel(title: "Veg"),
    HomeButtonModel(title: "Fish")
    ]
    weak var view:HomeViewProtocol?
    init(view: HomeViewProtocol? = nil) {
        self.view = view
    }
    weak var delegate: ButtonPresenterDelegate?
    
    func loadButtons() {
        let titles = buttons.map { $0.title}
        delegate?.displayButtons(titles: titles)
    }
    func handleButtonPress(title: String) {
           delegate?.buttonPressed(title: title)
    }
    func loadProfile() {
        guard let user = Auth.auth().currentUser else {
            print("No current user found.")
            return
        }
        print("User found: \(user.uid)")

        let db = Firestore.firestore()
        db.collection("users").document(user.uid).getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching user data: \(error)")
                return
            }
            if let document = document, document.exists, let data = document.data() {
                let name = data["fullName"] as? String ?? "No Name"
                print("Fetched name: \(name)")
                DispatchQueue.main.async {
                    self?.view?.updateProfile(with: name)
                }
            } else {
                print("Document does not exist")
            }
        }
    }

    
}
