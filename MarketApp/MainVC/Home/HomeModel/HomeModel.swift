//
//  HomeModel.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 15.05.2024.
//

import Foundation
 
struct HomeButtonModel {
    let title:String
}
struct FoodItem: Codable {
    let id: Int
    let title: String
    let image: String
    let price: String
//    let isLiked: Bool?
}
struct Root: Codable {
    let results: [FoodItem]
}
