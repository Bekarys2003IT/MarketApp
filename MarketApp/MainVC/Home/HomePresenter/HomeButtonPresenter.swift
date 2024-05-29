//
//  HomeButtonPresenter.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 15.05.2024.
//

import Foundation
import UIKit
protocol ButtonPresenterDelegate: AnyObject {
    func displayButtons(titles:[String])
    func buttonPressed(title: String)
}
class HomeButtonPresenter {
    private let buttons = [
    HomeButtonModel(title: "Recommended"),
    HomeButtonModel(title: "Popular"),
    HomeButtonModel(title: "Meat"),
    HomeButtonModel(title: "Veg"),
    HomeButtonModel(title: "Fish")
    ]
    weak var delegate: ButtonPresenterDelegate?
    
    func loadButtons() {
        let titles = buttons.map { $0.title}
        delegate?.displayButtons(titles: titles)
    }
    func handleButtonPress(title: String) {
           delegate?.buttonPressed(title: title)
    }
    
}
