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
        self.saveContext()
    }
    
    func applicationMoved(from: String, to: String, selectorFunction: String = #function) {
        if logOn {
        print("Application moved from <\(from)> to <\(to)>:", selectorFunction)
        }
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TinkoffChat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print(#function)
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

