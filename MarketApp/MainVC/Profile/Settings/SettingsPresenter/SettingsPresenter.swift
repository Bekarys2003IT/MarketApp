//
//  SettingsPresenter.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 29.05.2024.
//

import UIKit
protocol SettingsViewProtocol: AnyObject {
    func playAudio()
    func stopAudio()
}
class SettingsPresenter{
    weak var view: SettingsViewProtocol?
    
    func toggleMusic(shouldPlay: Bool) {
        if shouldPlay {
            view?.playAudio()
        } else {
            view?.stopAudio()
        }
    }
}
