//
//  AdvantageViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 19.05.2024.
//

import UIKit

class AdvantageViewController: UIViewController {
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
        label.text = "What is the advantage of using NutriDash?"
        label.font = .systemFont(ofSize: 25,weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private lazy var descLabel:UILabel = {
        let label = UILabel()
        label.text = "Using NutriDash offers a multitude of benefits that enhance the meal planning and cooking experience, making it easier, more enjoyable, and more health-conscious. Here are the key advantages of using NutriDash:\n \n- Access a wide variety of recipes for all meals, snacks, and dietary preferences.\n- Discover new and exciting dishes to diversify your meal options.\n- Find recipes that cater to specific dietary requirements, such as vegan, gluten-free, keto, and more.\n- Easily substitute ingredients to fit your dietary restrictions or preferences.\n- Utilize ingredient substitution suggestions to keep your cooking on track even if you’re missing an ingredient.\n- Reduce food waste by making use of available ingredients in your kitchen.\n- Encourage healthier eating habits by providing nutritious and balanced recipes.\n- Utilize ingredient substitution suggestions to keep your cooking on track even if you’re missing an ingredient."
        label.font = .systemFont(ofSize: 18,weight: .regular)
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
            make.height.equalTo(670)
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
