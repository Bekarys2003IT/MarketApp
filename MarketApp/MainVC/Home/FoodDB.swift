//
//  FoodDB.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 05.06.2024.
//

import Foundation
import FirebaseFirestore
class FoodDB {
    private let db = Firestore.firestore()
        
        func fetchFoodItems(completion: @escaping (Result<[FoodItem], Error>) -> Void) {
            db.collection("foodItems").getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                let items: [FoodItem] = snapshot?.documents.compactMap {
                    try? $0.data(as: FoodItem.self)
                } ?? []
                completion(.success(items))
            }
        }
        
        func updateFavoriteStatus(for item: FoodItem, completion: @escaping (Result<Void, Error>) -> Void) {
            db.collection("foodItems").document("\(item.id)").setData([
                "id": item.id,
                "title": item.title,
                "image": item.image,
                "price": item.price,
                "isLiked": item.isLiked ?? false
            ]) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
                    completion(.success(()))
                }
            }
        }
        
        func fetchFavoriteItems(completion: @escaping (Result<[FoodItem], Error>) -> Void) {
            db.collection("foodItems").whereField("isLiked", isEqualTo: true).getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                let items: [FoodItem] = snapshot?.documents.compactMap {
                    try? $0.data(as: FoodItem.self)
                } ?? []
                completion(.success(items))
            }
        }
    func removeFavorite(item: FoodItem, completion: @escaping (Error?) -> Void) {
        db.collection("foodItems").document("\(item.id)").delete { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}
