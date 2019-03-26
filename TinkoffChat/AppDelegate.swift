//
//  AppDelegate.swift
//  TinkoffChat
//
//  Created by Konstantin on 06/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit
import CoreData

var logOn: Bool = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
   
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        applicationMoved(from: "Not running", to: "Not running")
        
        if let saveTheme = UserDefaults.standard.colorForKey(key: "themeColor") {
            ThemesManager.sharedInstance.applyTheme(saveTheme)
        }
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        applicationMoved(from: "Not running", to: "Inactive")
       
        return true

    }

    func applicationWillResignActive(_ application: UIApplication) {
        applicationMoved(from: "Active", to: "Inactive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        applicationMoved(from: "Inactive", to: "Background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        applicationMoved(from: "Background", to: "Inactive")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        applicationMoved(from: "Inactive", to: "Active")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        applicationMoved(from: "Background", to: "Suspended")
    }
    
    func applicationMoved(from: String, to: String, selectorFunction: String = #function) {
        if logOn {
        print("Application moved from <\(from)> to <\(to)>:", selectorFunction)
        }
    }

   
}

