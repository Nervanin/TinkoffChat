//
//  CoreDataManager.swift
//  TinkoffChat
//
//  Created by Konstantin on 26/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//
import UIKit
import CoreData

import Foundation

class CoreDataManager {
    
    private static let stack = CoreDataStack()
    
    
    static func saveProfile(model: ProfileModel, callback: @escaping (_ success: Bool) -> ()) {
        guard let context = self.stack.saveContext else {
            callback(false)
            return
        }
        
        let appUser = AppUser.findOrInserAppUser(in: context)
        if let name = model.name {
            appUser?.name = name
        }
        if let information = model.information {
            appUser?.info = information
        }
        if let image = model.image {
            appUser?.image = image.fixOrientation().pngData()
        }
        self.stack.performSave(context: context, completionHandler: {
            DispatchQueue.main.async {
                callback(true)
            }
        })
    }
    
    static func loadProfile(callback: @escaping (ProfileModel?) -> ()) {
        guard let context = self.stack.saveContext, let user = AppUser.findOrInserAppUser(in: context) else {
            callback(nil)
            return
        }
        
        let model = ProfileModel()
        model.name = user.name
        model.information = user.info
        if let img = user.image {
            model.image = UIImage(data: img)
        }
        DispatchQueue.main.async {
            callback(model)
        }
    }
}
