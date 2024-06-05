//
//  BrowsePresenter.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 29.05.2024.
//

import UIKit

class BrowsePresenter {
    private weak var view: BrowseViewController?
    private var services: [BrowseService] = []
    
    init(view: BrowseViewController) {
            self.view = view
        }
    var numberOfItems: Int {
            return services.count
        }
    func onViewDidLoad() {
            // Fetch services from your data source
            loadServices()
        }
    func service(at index: Int) -> BrowseService {
            return services[index]
        }
    private func loadServices() {
        services = [
            BrowseService(name: "Popular", imageName: "popular"),
            BrowseService(name: "Meat", imageName: "meat"),
            BrowseService(name: "Veg", imageName: "veg"),
            BrowseService(name: "Fish", imageName: "fish"),
            BrowseService(name: "Low Calories", imageName: "lowCalories"),
            BrowseService(name: "Gulten Free", imageName: "gultenFree")
            ]
            view?.refreshCollectionView()
        }
}
