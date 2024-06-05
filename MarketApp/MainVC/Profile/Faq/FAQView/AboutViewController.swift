//
//  AboutViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 19.05.2024.
//

import UIKit

class AboutViewController: UIViewController {
    private lazy var greenView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        return view
    }()
    private lazy  var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "About app"
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
        label.text = "Welcome to the NutriDash!"
        label.font = .systemFont(ofSize: 25,weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private lazy var descLabel:UILabel = {
        let label = UILabel()
        label.text = "The app designed to make healthy eating easy, enjoyable, and accessible for everyone. NutriDash is your personal meal planning assistant, providing a wide array of meal recipes that cater to diverse dietary preferences and nutritional needs. Whether you're a seasoned chef or a kitchen novice, NutriDash offers something for everyone.\nNutriDash is more than just a recipe app—it's your companion in the journey towards a healthier, more delicious lifestyle. With NutriDash, meal planning, cooking, and enjoying nutritious meals has never been easier. Download NutriDash today and transform your kitchen into a hub of culinary excellence!"
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
            make.height.equalTo(400)
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
