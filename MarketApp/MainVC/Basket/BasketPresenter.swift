//
//  BasketPresenter.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 30.05.2024.
//

import UIKit
class BasketPresenter {
    weak var view: BasketViewProtocol?
        var items: [FoodItem] = [] {
            didSet {
                view?.updateItems(items)
            }
        }
        private let foodDB = FoodDB()

        init(view: BasketViewProtocol, initialItems: [FoodItem]) {
            self.view = view
            self.items = initialItems
        }

    func deleteItemAt(indexPath: IndexPath) {
        guard indexPath.row < items.count else {
            print("Index out of range attempt")
            return
        }
        let item = items[indexPath.row]

        foodDB.removeFavorite(item: item) { [weak self] error in
            guard let self = self else { return }

            if let error = error {
                print("Failed to remove item: \(error)")
            } else {
                self.items.remove(at: indexPath.row)
                self.view?.reloadData()
                print("Item successfully removed from Firestore")
            }
        }
    }
}

