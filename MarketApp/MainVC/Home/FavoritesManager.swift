//
//  FavoritesManager.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 05.06.2024.
//

import Foundation
class FavoritesManager {
    static let shared = FavoritesManager()
    private init() {}

    private var favorites: [FoodItem] = []

    func addFavorite(_ item: FoodItem) {
        favorites.append(item)
    }

    func removeFavorite(_ item: FoodItem) {
        favorites.removeAll { $0.id == item.id }
    }

    func isFavorite(_ item: FoodItem) -> Bool {
        return favorites.contains { $0.id == item.id }
    }

    func getFavorites() -> [FoodItem] {
        return favorites
    }

    func clearFavorites() {
        favorites.removeAll()
    }
    private func notifyChange() {
            NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
        }
}
extension Notification.Name {
    static let favoritesUpdated = Notification.Name("favoritesUpdated")
}
