//
//  ProfileViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 15.05.2024.
//

import UIKit
import FirebaseAuth
protocol ProfileViewProtocol: AnyObject {
    func updateProfile(with name: String, email: String)
    func showLogoutConfirmation()
    func navigateToSignIn()
}

class ProfileViewController: UIViewController, ProfileViewProtocol {
    
    private var presenter:ProfilePresenter!
    private lazy var greenView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        return view
    }()
    private lazy var userImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.tintColor = .white
        return image
    }()
    private lazy var cameraButton : UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.tintColor = .white
        return button
    }()
    private lazy var nameLabel:UILabel = {
       let label = UILabel()
        label.text = "Random name"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    private lazy var emailLabel:UILabel = {
       let label = UILabel()
        label.text = "Random email"
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = .white
        return label
    }()
    private lazy var favoriteButton:UIButton = {
        let button = UIButton()
        button.setTitle("My Favorites", for: .normal)
        button.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        return button
    }()
    private lazy var faqButton:UIButton = {
        let button = UIButton()
        button.setTitle("FAQ", for: .normal)
        button.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(faqButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var userDetailsButton:UIButton = {
        let button = UIButton()
        button.setTitle("My profile", for: .normal)
        button.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var settingsButton:UIButton = {
        let button = UIButton()
        button.setTitle("Settings", for: .normal)
        button.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var logoutButton:UIButton = {
       let button = UIButton()
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.white , for: .normal)
        button.backgroundColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        navigationItem.hidesBackButton = true
        presenter = ProfilePresenter(view: self)
        setUI()
        presenter.loadProfile()
    }
    private func setUI(){
        view.addSubview(greenView)
        greenView.addSubview(userImage)
        greenView.addSubview(cameraButton)
        greenView.addSubview(nameLabel)
        greenView.addSubview(emailLabel)
        view.addSubview(favoriteButton)
        view.addSubview(faqButton)
        view.addSubview(userDetailsButton)
        view.addSubview(settingsButton)
        view.addSubview(logoutButton)
        
        //constraint
        greenView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(280)
        }
        cameraButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-5)
            make.size.equalTo(70)
        }
        userImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            
        }
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        faqButton.snp.makeConstraints { make in
            make.top.equalTo(favoriteButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        userDetailsButton.snp.makeConstraints { make in
            make.top.equalTo(faqButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(userDetailsButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(settingsButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
    }
    func updateProfile(with name:String, email:String){
        nameLabel.text = name
        emailLabel.text = email
    }
    @objc func logoutButtonTapped(){
        presenter.logoutRequested()
    }
     func showLogoutConfirmation() {
            let alert = UIAlertController(title: "Log out", message: "Are you sure you want to log out?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
                self?.presenter.confirmLogout()
            }
            let noAction = UIAlertAction(title: "No", style: .cancel)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            present(alert, animated: true)
        }

     func navigateToSignIn() {
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = UINavigationController(rootViewController: SignViewController())
                UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
        }
    
    @objc func faqButtonTapped(){
        navigationController?.pushViewController(FaqViewController(), animated: true)
    }
    @objc func favoriteButtonTapped(){
        navigationController?.pushViewController(BasketViewController(), animated: true)
    }
    @objc func profileButtonTapped(){
        navigationController?.pushViewController(UserViewController(), animated: true)
    }
    @objc func settingsButtonTapped(){
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }

   

}
