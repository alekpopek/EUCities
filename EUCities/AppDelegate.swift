//
//  AppDelegate.swift
//  EUCities
//
//  Created by Aleksander Popek on 10/11/2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appCoordinator = AppCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
        setupAppearance()
        appCoordinator.start()

        return true
    }
    
    private func setupAppearance() {
        /// Set global navigationbar color
        UINavigationBar.appearance().barTintColor = Style.colorWhite
        UINavigationBar.appearance().tintColor = Style.colorPrimary
        UINavigationBar.appearance().isTranslucent = false

        /// Set global navigationbar title style
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Style.color40,
            NSAttributedString.Key.font: Style.fontRegular(size: 18)
        ]
    }
}

