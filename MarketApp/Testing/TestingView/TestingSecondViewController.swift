//
//  TestingSecondViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 15.05.2024.
//

import UIKit

class TestingSecondViewController: UIViewController {

    
    private lazy var nutriLabel :UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        label.text = "NutriDash"
        return label
    }()
    private lazy var tasteLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        label.text = "Taste Profile"
        return label
    }()
    private lazy var progressView: UIProgressView = {
       let progress = UIProgressView()
        progress.progress = .greatestFiniteMagnitude
        progress.setProgress(0.8, animated: true)
        progress.trackTintColor = UIColor(red: 211/255, green: 255/255, blue: 140/255, alpha: 1.0)
        progress.progressTintColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        progress.layer.cornerRadius = 15
        progress.clipsToBounds = true
        return progress
    }()
    private lazy var askLabel:UILabel = {
       let label = UILabel()
        label.text = "How many people will you be cooking for?"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20,weight: .light)
        return label
    }()
    private lazy var laterLabel:UILabel = {
        let label = UILabel()
        label.text = "Can be changed later on"
        label.font = .systemFont(ofSize: 16,weight: .light)
        return label
    }()
    private lazy var optionStackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        (1...5).forEach { num in
            let button = UIButton(type: .system)
            button.setTitle(String(num), for: .normal)
            button.addTarget(self, action: #selector(optionSelected(sender:)), for: .touchUpInside)
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 8
            button.layer.borderColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0).cgColor
            button.layer.borderWidth = 1
            stack.addArrangedSubview(button)
        }
        
        return stack
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    private func setUI(){
        view.addSubview(nutriLabel)
        view.addSubview(tasteLabel)
        view.addSubview(progressView)
        view.addSubview(askLabel)
        view.addSubview(optionStackView)
        view.addSubview(laterLabel)
        
        //constraint
        nutriLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        tasteLabel.snp.makeConstraints { make in
            make.top.equalTo(nutriLabel.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(tasteLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(350)
        }
        askLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        optionStackView.snp.makeConstraints { make in
            make.top.equalTo(askLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        laterLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.centerX.equalToSuperview()
        }
        
    }
    @objc func optionSelected(sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            guard let number = sender.titleLabel?.text else { return }
            print("Number of people: \(number)")
            sender.backgroundColor = UIColor(red: 211/255, green: 255/255, blue: 140/255, alpha: 1.0)
            self.progressView.setProgress(1.0, animated: true)
            let homeVC = TabBarController()
            self.navigationController?.pushViewController(TabBarController(), animated: true)
        }
    }
   
}
