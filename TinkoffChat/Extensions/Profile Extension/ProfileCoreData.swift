//
//  ProfileCoreData.swift
//  TinkoffChat
//
//  Created by Konstantin on 26/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation
import CoreData

//extension AppUser {
//    
//    class func fetchRequest(model: NSManagedObjectModel) -> NSFetchRequest<AppUser>? {
//        let templateName = "ProfileFetchRequest"
//        
//        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<AppUser> else {
//            assert(false, "No template with name \(templateName)!")
//            return nil
//        }
//        
//        return fetchRequest
//    }
//    
//    class func insert(in context: NSManagedObjectContext) -> AppUser? {
//        let defaultProfile = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: context) as? AppUser
//        defaultProfile?.name = "Alex Volkov"
//        defaultProfile?.info = "iOS Developer"
//       // defaultProfile?.image = UIImage()//UIImageJPEGRepresentation(UIImage(named: "placeholder-user")!, 1.0)
//        
//        return defaultProfile
//    }
//    
//    class func findOrInsert(in context: NSManagedObjectContext) -> AppUser? {
//        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
//            print("Model is not available in context!")
//            assert(false)
//            return nil
//        }
//        
//        var profile: AppUser?
//        guard let fetchRequest = fetchRequest(model: model) else {
//            return nil
//        }
//        
//        do {
//            let results = try context.fetch(fetchRequest)
//            assert(results.count < 2, "Multiple profiles found!")
//            if let foundProfile = results.first {
//                profile = foundProfile
//            }
//        }
//        catch {
//            print("Failed to fetch profile: \(error)")
//        }
//        
//        if profile == nil {
//            profile = insert(in: context)
//        }
//        
//        return profile
//    }
//}

