//
//  ViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 13.05.2024.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
//    private lazy var mainLabel:UILabel = {
//       let label = UILabel()
//        label.text = "NutriDash"
//        label.font = UIFont(name: "Lalezar-Regular", size: 50)
//        label.textAlignment = .center
//        label.textColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
//        return label
//    }()
//    private lazy var subLabel:UILabel = {
//        let label = UILabel()
//        label.text = "click, receive, smile."
//        label.font = UIFont(name: "InriaSans-Regular", size: 50)
//        label.textColor = .black
//        label.textAlignment = .center
//        return label
//    }()
    private lazy var nutriImageView:UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named:"NutriDash")
        return image
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    
    private func setUI(){
        view.addSubview(nutriImageView)
        
        nutriImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(350)
        }
    }


}

