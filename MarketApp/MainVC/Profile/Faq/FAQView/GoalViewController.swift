//
//  GoalViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 19.05.2024.
//

import UIKit

class GoalViewController: UIViewController {
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
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.layer.cornerRadius = 8
        return view
    }()
    private lazy var aboutLabel:UILabel = {
        let label = UILabel()
        label.text = "Goal of this app"
        label.font = .systemFont(ofSize: 25,weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private lazy var descLabel:UILabel = {
        let label = UILabel()
        label.text = "The primary goal of the NutriDash app is to empower individuals to lead healthier and more balanced lives by simplifying the process of meal planning and preparation. NutriDash aims to achieve this by providing a comprehensive platform that offers a diverse collection of recipes, personalized meal plans, and detailed nutritional information. The app is designed to cater to various dietary preferences and restrictions, making healthy eating accessible and enjoyable for everyone."
        label.font = .systemFont(ofSize: 18,weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 243/255, green: 244/255, blue: 249/255, alpha: 1.0)
        setUI()
    }
    private func setUI(){
        view.addSubview(greenView)
        greenView.addSubview(titleLabel)
        view.addSubview(whiteView)
        whiteView.addSubview(aboutLabel)
        whiteView.addSubview(descLabel)
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
            make.height.equalTo(360)
        }
        aboutLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(aboutLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
    }
}
