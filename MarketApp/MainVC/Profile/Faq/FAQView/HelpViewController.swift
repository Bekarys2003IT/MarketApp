//
//  HelpViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 19.05.2024.
//

import UIKit

class HelpViewController: UIViewController {
    private lazy var greenView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        return view
    }()
    private lazy  var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Answer"
        label.textColor = .white
        label.font = .systemFont(ofSize: 26,weight: .bold)
        return label
    }()
    private lazy var whiteView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    private lazy var aboutLabel:UILabel = {
        let label = UILabel()
        label.text = "Help&Support"
        label.font = .systemFont(ofSize: 25,weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private lazy var descLabel:UILabel = {
        let label = UILabel()
        label.text = "Welcome to the NutriDash Help Center! We're here to assist you with any questions or issues you may have while using the NutriDash app. Our goal is to provide you with the best possible experience as you explore our extensive collection of recipes, personalize your meal plans, and enjoy delicious, nutritious meals."
        label.font = .systemFont(ofSize: 18,weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    private lazy var emailLabel:UILabel = {
        let label = UILabel()
        label.text = "Email:bekaris070603@gmail.com"
        label.font = .systemFont(ofSize: 18,weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        setUI()
    }
    private func setUI(){
        view.addSubview(greenView)
        greenView.addSubview(titleLabel)
        view.addSubview(whiteView)
        whiteView.addSubview(aboutLabel)
        whiteView.addSubview(descLabel)
        whiteView.addSubview(emailLabel)
        //constraint
        greenView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(300)
        }
        aboutLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(aboutLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
    }
}
