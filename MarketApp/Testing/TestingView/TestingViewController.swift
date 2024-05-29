//
//  TestingViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 15.05.2024.
//

import UIKit

class TestingViewController: UIViewController {
    
   
    var presenter: TestingPresenter!
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
        progress.progress = 0.0
        progress.setProgress(0.0, animated: true)
        progress.trackTintColor = UIColor(red: 211/255, green: 255/255, blue: 140/255, alpha: 1.0)
        progress.progressTintColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        progress.layer.cornerRadius = 15
        progress.clipsToBounds = true
        return progress
    }()
    private lazy var askLabel:UILabel = {
       let label = UILabel()
        label.text = "How would you rate your cooking skills on a scale from 1 to 5, with 1 being beginner and 5 being expert?"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20,weight: .light)
        return label
    }()
    lazy var optionsStackView: UIStackView = {
      let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 10
        return view
    }()
    var optionButtons: [UIButton] = []
    private lazy var laterLabel:UILabel = {
        let label = UILabel()
        label.text = "Can be changed later on"
        label.font = .systemFont(ofSize: 16,weight: .light)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        setPresenter()
    }
   
    private func setUI(){
        view.addSubview(nutriLabel)
        view.addSubview(tasteLabel)
        view.addSubview(progressView)
        view.addSubview(optionsStackView)
        view.addSubview(askLabel)
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
            make.top.equalTo(tasteLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(350)
        }
        askLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
        optionsStackView.snp.makeConstraints { make in
            make.top.equalTo(askLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(350)
        }
        laterLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.centerX.equalToSuperview()
        }
    }
         func setPresenter(){
            let questions = [
            TestingModel(questionText: "How would you rate your cooking skills?", options: ["Beginner", "Getting there", "Doing well", "Quite good", "Expert"]),
            TestingModel(questionText: "How often do you plan your meals?", options: ["Everyday", "Few times a week", "Decide in the moment", "I plan on the weekends", "Never"]),
            TestingModel(questionText: "Do you have any dietary requirements?", options: ["Vegetarian","Gluten Free","Dairy Free","Other","None"]),
            TestingModel(questionText: "What types of meals do you like?", options: ["Meat lover","Veggie","Quick and easy","Pescatarian","Calorie focused"])
                    ]
            presenter = TestingPresenter(questions: questions, viewController: self)
            presenter.start()
        }
        
    func configureQuestion(_ question: TestingModel, progress: Float) {
            askLabel.text = question.questionText
            progressView.setProgress(progress, animated: true)

            optionButtons.forEach { $0.removeFromSuperview() }
            optionButtons = question.options.map { title in
                let button = UIButton(type: .system)
                button.setTitle(title, for: .normal)
                button.addTarget(self, action: #selector(optionSelected(sender:)), for: .touchUpInside)
                button.layer.cornerRadius = 8
                button.layer.borderColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0).cgColor
                button.layer.borderWidth = 1
                button.setTitleColor(.black, for: .normal)
                optionsStackView.addArrangedSubview(button)
                return button
            }
        print("Added \(optionButtons.count) buttons")
        }

        @objc func optionSelected(sender: UIButton) {
            guard let index = optionButtons.firstIndex(of: sender) else { return }
            presenter.optionSelected(index: index)
        }

}

