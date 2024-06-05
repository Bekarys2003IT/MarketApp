//
//  ViewController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 13.05.2024.
//

import UIKit
import SnapKit
import FirebaseAuth
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
        performInitialSetup()
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
                    self?.decideNavigationPath()
                }
            }
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
    private func performInitialSetup() {
           DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
               self.decideNavigationPath()
           }
       }
    private func decideNavigationPath() {
        let isUserLoggedIn = Auth.auth().currentUser != nil
            let hasCompletedTesting = UserDefaults.standard.bool(forKey: "hasCompletedTesting")
            print("User is logged in: \(isUserLoggedIn)")
            print("Has completed testing: \(hasCompletedTesting)")

            if isUserLoggedIn {
                if hasCompletedTesting {
                    print("Navigating to Main App")
                    navigateToMainApp()
                } else {
                    print("Navigating to Testing")
                    navigateToTesting()
                }
            } else {
                print("Navigating to Sign In")
                navigateToSignIn()
            }
    }
    private func navigateToMainApp() {
           let tabBarVC = TabBarController()
           navigationController?.setViewControllers([tabBarVC], animated: true)
       }

       private func navigateToSignIn() {
           let signVC = SignViewController()
           navigationController?.setViewControllers([signVC], animated: true)
       }

       private func navigateToTesting() {
           let testingVC = TestingViewController()
           navigationController?.setViewControllers([testingVC], animated: true)
       }
//    func showNextViewController() {
//           let mainViewController = determineMainViewController()
//           if let window = UIApplication.shared.delegate?.window {
//               UIView.transition(with: window!, duration: 1.0, options: .transitionCrossDissolve, animations: {
//                   window?.rootViewController = UINavigationController(rootViewController: mainViewController)
//               }, completion: nil)
//           }
//       }
//    private func determineMainViewController() -> UIViewController {
//            if Auth.auth().currentUser != nil {
//                return TabBarController()
//            } else {
//                return SignViewController()
//            }
//        }
//    


}

