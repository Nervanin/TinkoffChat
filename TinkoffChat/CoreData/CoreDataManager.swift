//
//  CoreDataManager.swift
//  TinkoffChat
//
//  Created by Konstantin on 26/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//
import UIKit
import CoreData

class CoreDataManager: NSObject {
    private static var _coreDataStack: CoreDataStack?
    public static var coreDataStack: CoreDataStack? {
        get {
            if _coreDataStack == nil {
                _coreDataStack = CoreDataStack()
            }
            return _coreDataStack
        }
    }
    
    static func loadProfile(_ completion: @escaping (AppUser?) -> ()){
        if let mainContext = self.coreDataStack?.mainContext {
            completion(AppUser.findOrInserAppUser(in: mainContext))
        }
        
        completion(nil)
    }
    
    static func saveProfile(_ user: User, completion: @escaping (Bool) -> ()) {
        
        if let saveContext = self.coreDataStack?.saveContext {
            saveContext.perform {
                if let profile = AppUser.findOrInserAppUser(in: saveContext) {
                    
                    if user.nameIsChanged, let profileName = user.name {
                        profile.name = profileName
                    }
                    
                    if user.infoIsChanged, let profileDescription = user.info {
                        profile.info = profileDescription
                    }
                    
//                    if user.imageIsChanged, let profileImage = user.image {
//                        let imageData = UIImage()//UIImageJPEGRepresentation(profileImage, 1.0)
//                        profile.image = imageData
//                    }
                    
                    coreDataStack?.performSave(context: saveContext, completionHandler: {
                        DispatchQueue.main.async {
                            completion(true)
                        }
                    })
                }
            }
        }
    }
}
