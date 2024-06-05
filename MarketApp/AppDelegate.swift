//
//  AppDelegate.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 13.05.2024.
//

import UIKit
import Firebase
import FirebaseAuth
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow()
        resetTestingFlagIfNeeded()
        let testCompleted = UserDefaults.standard.bool(forKey: "hasCompletedTesting")
            print("At app launch, test completed flag is: \(testCompleted)")
        if isDevelopmentEnvironment() {
                   UserDefaults.standard.set(false, forKey: "hasCompletedTesting")
                   UserDefaults.standard.synchronize()
               }
        let previewVC = PreviewViewController()
        window?.rootViewController = UINavigationController(rootViewController: PreviewViewController())
        AudioManager.shared.playAudio()
        window?.overrideUserInterfaceStyle = MTUserDefaults.shared.theme.getUserInterfaceStyle()
        window?.makeKeyAndVisible()
        #if DEBUG
        resetTestingFlag()
        #endif
        return true
    }
#if DEBUG
func resetTestingFlagIfNeeded() {
    if isDevelopmentEnvironment() {
        UserDefaults.standard.set(false, forKey: "hasCompletedTesting")
        UserDefaults.standard.synchronize()
        print("Testing flag has been reset for development.")
    }
}
#endif
    func isDevelopmentEnvironment() -> Bool {
            #if DEBUG
            return true
            #else
            return false
            #endif
        }
    #if DEBUG
    func resetTestingFlag() {
        UserDefaults.standard.set(false, forKey: "hasCompletedTesting")
        UserDefaults.standard.synchronize()
        print("Testing flag has been reset.")
    }
    #endif

}

