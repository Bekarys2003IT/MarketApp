//
//  SettingsViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 22.05.2024.
//

import UIKit
import AVFoundation
class SettingsViewController: UIViewController, SettingsViewProtocol {
    var presenter : SettingsPresenter!
    var audioPlayer: AVAudioPlayer?
    private lazy var settingsLabel:UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = .systemFont(ofSize: 35,weight: .bold)
        label.textColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        return label
    }()
    private lazy var notificationLabel:UILabel = {
        let label = UILabel()
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "bell")
        attachment.bounds = CGRect(x: 0, y: -5, width: 24, height: 24)
        let attributedString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: " Notification")
        attributedString.append(textString)
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttributes([.font: UIFont.systemFont(ofSize: 20, weight: .semibold)], range: range)
        label.attributedText = attributedString
        return label
    }()
    private lazy var notificationToggle: UISwitch = {
       let toggle = UISwitch()
        return toggle
    }()
    private lazy var darkModeLabel:UILabel = {
        let label = UILabel()
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "moon.circle")
        attachment.bounds = CGRect(x: 0, y: -5, width: 24, height: 24)
        let attributedString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: " App theme")
        attributedString.append(textString)
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttributes([.font: UIFont.systemFont(ofSize: 20, weight: .semibold)], range: range)
        label.attributedText = attributedString
        return label
    }()
    private lazy var darkModeToggle: UISwitch = {
       let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(toggleTheme(_:)), for: .valueChanged)
        return toggle
    }()
    private lazy var musicLabel:UILabel = {
       let label = UILabel()
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "music.note")
        attachment.bounds = CGRect(x: 0, y: -5, width: 24, height: 24)
        let attributedString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: " Background music")
        attributedString.append(textString)
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttributes([.font: UIFont.systemFont(ofSize: 20, weight: .semibold)], range: range)
        label.attributedText = attributedString
        return label
    }()
    private lazy var musicToggle: UISwitch = {
       let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(toggleMusic(_:)), for: .touchUpInside)
        toggle.isOn = true
        return toggle
    }()
    private lazy var contactUsLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let headerAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.boldSystemFont(ofSize: 25)
                ]
        let attributedString = NSMutableAttributedString(string: "Report a bug: \n", attributes: headerAttributes)
        let email = "Contact us \nbekaris070603@gmail.com"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold)
                ]
        let boldAttributedString = NSAttributedString(string: email, attributes: attributes)
                attributedString.append(boldAttributedString)
        label.attributedText = attributedString
     return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        presenter = SettingsPresenter()
        presenter.view = self
        setupResetButton()
        setUI()

    }
    
    private func setUI(){
        view.addSubview(settingsLabel)
        view.addSubview(notificationLabel)
        view.addSubview(notificationToggle)
        view.addSubview(darkModeLabel)
        view.addSubview(darkModeToggle)
        view.addSubview(musicLabel)
        view.addSubview(musicToggle)
        view.addSubview(contactUsLabel)
        
        //constraint
        settingsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(20)
        }
        notificationLabel.snp.makeConstraints { make in
            make.top.equalTo(settingsLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        notificationToggle.snp.makeConstraints { make in
            make.centerY.equalTo(notificationLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        darkModeLabel.snp.makeConstraints { make in
            make.top.equalTo(notificationLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        darkModeToggle.snp.makeConstraints { make in
            make.centerY.equalTo(darkModeLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        musicLabel.snp.makeConstraints { make in
            make.top.equalTo(darkModeLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        musicToggle.snp.makeConstraints { make in
            make.centerY.equalTo(musicLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        contactUsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalToSuperview().offset(20)
        }
    }
    @objc func toggleMusic(_ sender: UISwitch) {
        presenter.toggleMusic(shouldPlay: sender.isOn)
    }
    @objc func toggleTheme(_ sender: UISwitch) {
        MTUserDefaults.shared.theme = sender.isOn ? .dark : .light
        view.window?.overrideUserInterfaceStyle = MTUserDefaults.shared.theme.getUserInterfaceStyle()
    }

}
extension SettingsViewController {
    func playAudio() {
        AudioManager.shared.playAudio()
    }
    func stopAudio() {
        AudioManager.shared.stopAudio()
    }
    @objc func resetTestingData() {
           UserDefaults.standard.set(false, forKey: "hasCompletedTesting")
           UserDefaults.standard.synchronize()
           showAlert(title: "Reset Done", message: "The testing flag has been reset.")
       }

       func showAlert(title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
    private func setupResetButton() {
            let resetButton = UIButton()
            resetButton.setTitle("Reset Testing", for: .normal)
            resetButton.addTarget(self, action: #selector(resetTesting), for: .touchUpInside)
            view.addSubview(resetButton)
        }

        @objc private func resetTesting() {
            UserDefaults.standard.set(false, forKey: "hasCompletedTesting")
            UserDefaults.standard.synchronize()
            showAlert("Testing has been reset. You can retest now.")
        }

        private func showAlert(_ message: String) {
            let alert = UIAlertController(title: "Reset Done", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
}
