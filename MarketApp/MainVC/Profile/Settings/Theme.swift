//
//  Theme.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 29.05.2024.
//

import Foundation
import UIKit

enum Theme: Int {
    case dark
    case light
    case device
    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case .device:
            return .unspecified
        case .dark:
            return .dark
        case .light:
            return .light
        }
    }
}
