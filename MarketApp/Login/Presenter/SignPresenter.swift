//
//  SignPresenter.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 14.05.2024.
//

import UIKit

class SignPresenter: SignPresenterProtocol {
   
    
    weak var view: SignViewProtocol?
    
    required init(view: any SignViewProtocol) {
        self.view = view
    }
    
    func segmentedControlChanged(selectedIndex: Int) {
            let isSignInVisible = selectedIndex == 0
            view?.updateSignInVisibility(isVisible: isSignInVisible)
        }
}
