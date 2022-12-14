//
//  AppDelegate.swift
//  iOS-AppArchitecture
//
//  Created by Vasanthakumar Annadurai on 30/10/22.
//

import UIKit
import Swinject
import HttpClient

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // AppAssembler - Provides Application level dependencies.
    lazy var appAssembler: Assembler = {
        return self.initializeDI()
    }()
    
    // MARK: - UIApplicationDelegate Methods.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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
    
    // MARK: - Private Methods.
    fileprivate func initializeDI()-> Assembler{
        // Libraries
        let networkAssembly = HttpClientAssembly()
        
        // App
        let appAssembly = AppAssembly()
        
        let assembler = Assembler([networkAssembly, appAssembly])
        return assembler
    }
    
}

