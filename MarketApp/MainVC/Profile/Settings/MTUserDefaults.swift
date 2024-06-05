//
//  MTUserDefaults.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 29.05.2024.
//

import Foundation

struct MTUserDefaults {
    static var shared = MTUserDefaults()
    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.integer(forKey: "selectedTheme")) ?? .device
        }
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedTheme")
        }
    }
}
