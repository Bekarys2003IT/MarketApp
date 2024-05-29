//
//  ViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 13.05.2024.
//

import UIKit
import SnapKit
class PreviewViewController: UIViewController {

    private lazy var nutriImageView:UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named:"NutriDash")
        return image
    }()
    private lazy var nutriLabel:UILabel = {
       let label = UILabel()
        label.text = "Delicious foods"
        label.font = .italicSystemFont(ofSize: 25)
        label.textColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        animationLabelText("Delicious foods")
    }
    private func animationLabelText(_ text: String){
        nutriLabel.text = ""
        let characters = Array(text)
        var index = 0
        let delay = 0.12
        
        Timer.scheduledTimer(withTimeInterval: delay, repeats: true) {  [weak self] timer in
            if index < characters.count {
                let char = characters[index]
                self?.nutriLabel.text?.append(char)
                index += 1
            } else {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self?.showNextViewController()
                }
            }
        }
    }

    func showNextViewController() {
    let mainViewController = TestingViewController()
        if let window = UIApplication.shared.delegate?.window {
          window?.rootViewController = UINavigationController(rootViewController: mainViewController)
            UIView.transition(with: window!, duration: 1.0, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
        }
    
    
    private func setUI(){
        view.addSubview(nutriImageView)
        view.addSubview(nutriLabel)
        nutriImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
            
            make.height.equalTo(150)
            make.width.equalTo(350)
        }
        nutriLabel.snp.makeConstraints { make in
            make.top.equalTo(nutriImageView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
    }


}

