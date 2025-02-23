//
//  AppDelegate.swift
//  Tamagotchi
//
//  Created by 김정호 on 2/22/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if UserDefaultsManager.tamagotchis == nil {
            let tamagotchis = [
                Tamagotchi(image: "1-1", nickname: "따끔따끔 다마고치", rice: 0, water: 0, isSelected: false),
                Tamagotchi(image: "2-1", nickname: "방실방실 다마고치", rice: 0, water: 0, isSelected: false),
                Tamagotchi(image: "3-1", nickname: "반짝반짝 다마고치", rice: 0, water: 0, isSelected: false)
            ]
            
            UserDefaultsManager.tamagotchis = tamagotchis
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

