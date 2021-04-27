//
//  AppDelegate.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.02.2021.
//

import UIKit
import Firebase
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var isAuthorized: Bool {
        get {
            return Auth.auth().currentUser != nil
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
        
        configureUIAppearance()
        
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
    
    // MARK: - Custom functions
    
    private func configureUIAppearance() {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.white, .font: CustomFonts.openSans(size: 38, style: .bold)]
        UINavigationBar.appearance().titleTextAttributes = [
            .font: CustomFonts.openSans(size: 21, style: .regular)
        ]
        UITabBar.appearance().barTintColor = CustomColors.creamWhiteColor
        UITabBar.appearance().unselectedItemTintColor = CustomColors.darkBlueColor
        UITabBar.appearance().tintColor = CustomColors.lightOrangeColor
    }
    
    
}

