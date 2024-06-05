//
//  FaqViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 18.05.2024.
//

import UIKit

class FaqViewController: UIViewController {

    private lazy var greenView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        return view
    }()
    private lazy  var titleLabel:UILabel = {
       let label = UILabel()
        label.text = "FAQ"
        label.textColor = .white
        label.font = .systemFont(ofSize: 26,weight: .bold)
        return label
    }()
    private lazy var aboutButton:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .darkGray
        button.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 230)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 200, bottom: 0, right: -420)
        button.addTarget(self, action: #selector(aboutTapped), for: .touchUpInside)
        button.setTitle("About app", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    private lazy var whiteView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        view.layer.cornerRadius = 8
        return view
    }()
    private lazy var faqLabel:UILabel = {
        let label = UILabel()
        label.text = "Frequently asked questions"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25,weight: .bold)
        return label
    }()
    private lazy var dividerView1:UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private lazy var dividerView2:UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private lazy var dividerView3:UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private lazy var goalButton:UIButton = {
        let button = UIButton()
         button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
         button.setTitle("Goal of this app", for: .normal)
         button.setTitleColor(.black, for: .normal)
         button.tintColor = .darkGray
         button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 180)
         button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 200, bottom: 0, right: -420)
         button.addTarget(self, action: #selector(goalTapped), for: .touchUpInside)
         button.titleLabel?.numberOfLines = 0
         button.titleLabel?.font = .systemFont(ofSize: 20)
         return button
    }()
    private lazy var advantageButton: UIButton = {
        let button = UIButton()
         button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
         button.setTitle("What is the advantage of using \n NutriDash?", for: .normal)
         button.setTitleColor(.black, for: .normal)
         button.tintColor = .darkGray
         button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 160)
         button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 200, bottom: 0, right: -420)
         button.addTarget(self, action: #selector(advantageTapped), for: .touchUpInside)
         button.titleLabel?.numberOfLines = 0
         button.titleLabel?.font = .systemFont(ofSize: 20)
         button.setTitleColor(.black, for: .normal)
         return button
    }()
    private lazy var helpButton: UIButton = {
        let button = UIButton()
         button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
         button.setTitle("Help&Support", for: .normal)
         button.setTitleColor(.black, for: .normal)
         button.tintColor = .darkGray
         button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 200)
         button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 200, bottom: 0, right: -410)
         button.addTarget(self, action: #selector(helpTapped), for: .touchUpInside)
         button.titleLabel?.numberOfLines = 0
         button.titleLabel?.font = .systemFont(ofSize: 20)
         button.setTitleColor(.black, for: .normal)
         return button
    }()
    private lazy var createButton: UIButton = {
        let button = UIButton()
         button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
         button.setTitle("How do I create an account?", for: .normal)
         button.setTitleColor(.black, for: .normal)
         button.tintColor = .darkGray
         button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 190)
         button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 200, bottom: 0, right: -420)
         button.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
         button.setTitleColor(.black, for: .normal)
         button.titleLabel?.numberOfLines = 0
         button.titleLabel?.font = .systemFont(ofSize: 20)
         return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        setUI()
    }
    private func setUI(){
        view.addSubview(greenView)
        greenView.addSubview(titleLabel)
        view.addSubview(aboutButton)
        view.addSubview(whiteView)
        whiteView.addSubview(faqLabel)
        whiteView.addSubview(goalButton)
        whiteView.addSubview(dividerView1)
        whiteView.addSubview(advantageButton)
        whiteView.addSubview(dividerView2)
        whiteView.addSubview(helpButton)
        whiteView.addSubview(dividerView3)
        whiteView.addSubview(createButton)
        
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
        aboutButton.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(70)
        }
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(aboutButton.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(500)
        }
        faqLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        goalButton.snp.makeConstraints { make in
            make.top.equalTo(faqLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        dividerView1.snp.makeConstraints { make in
            make.top.equalTo(goalButton.snp.bottom).offset(20)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        advantageButton.snp.makeConstraints { make in
            make.top.equalTo(dividerView1.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        dividerView2.snp.makeConstraints { make in
            make.top.equalTo(advantageButton.snp.bottom).offset(20)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        helpButton.snp.makeConstraints { make in
            make.top.equalTo(dividerView2.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        dividerView3.snp.makeConstraints { make in
            make.top.equalTo(helpButton.snp.bottom).offset(20)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        createButton.snp.makeConstraints { make in
            make.top.equalTo(dividerView3.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        
    }
    @objc func aboutTapped(){
        print("About tapped")
        navigationController?.pushViewController(AboutViewController(), animated: true)
    }
    @objc func goalTapped(){
        print("Goal tapped")
        navigationController?.pushViewController(GoalViewController(), animated: true)
    }
    @objc func advantageTapped(){
        print("Advantage tapped")
        navigationController?.pushViewController(AdvantageViewController(), animated: true)
    }
    @objc func helpTapped(){
        print("Help tapped")
        navigationController?.pushViewController(HelpViewController(), animated: true)
    }
    @objc func createTapped(){
        print("Create tapped")
        navigationController?.pushViewController(CreateViewController(), animated: true)
    }
}
