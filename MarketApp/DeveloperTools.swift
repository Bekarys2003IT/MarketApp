//
//  DeveloperTools.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 04.06.2024.
//

import UIKit
class DeveloperTools {

    static let shared = DeveloperTools()

    func resetTestingFlag() {
        UserDefaults.standard.set(false, forKey: "hasCompletedTesting")
        UserDefaults.standard.synchronize()
    }
}
