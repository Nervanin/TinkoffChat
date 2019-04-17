//
//  CoreDataStack.swift
//  TinkoffChat
//
//  Created by Konstantin on 26/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    
    override init() {}
    // MARK: - NSPersistentStore
    var storeURL: URL {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        return (documentsUrl?.appendingPathComponent("TinkoffChatStore.sqlite"))!
    }
    
    
    // MARK: - NSManagedObjectModel
    private let dataModelName = "TinkoffChat"
    private let dataModelExtension = "momd"
    
    lazy var managedObjectModel: NSManagedObjectModel? = {
        let modelURL = Bundle.main.url(forResource: dataModelName, withExtension: dataModelExtension)
        return NSManagedObjectModel(contentsOf: modelURL!)!
    }()
    
    // MARK: - Coordinator
    private var _persistentStoreCoordinator: NSPersistentStoreCoordinator?
    private var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        get {
            if _persistentStoreCoordinator == nil {
                guard let model = self.managedObjectModel else {
                    print("Empty managed object model!")
                    return nil
                }
                _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
                do {
                    try _persistentStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType,
                                                                        configurationName: nil,
                                                                        at: self.storeURL,
                                                                        options: nil)
                } catch {
                 //   assert(false, "Error adding persistent store to coordinator: \(error)")
                }
            }
            
            return _persistentStoreCoordinator
        }
    }
    
    // MARK: - NSManagedObjectContext
    // Master context
    private var _masterContext: NSManagedObjectContext?
    private var masterContext: NSManagedObjectContext? {
        get {
            if _masterContext == nil {
                let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
                guard let persistentStoreCoordinator = self.persistentStoreCoordinator else {
                    print("Empty persistent store coordinator!")
                    return nil
                }
                context.persistentStoreCoordinator = persistentStoreCoordinator
                context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                context.undoManager = nil
                _masterContext = context
            }
            return _masterContext
        }
    }
    
    // Main context
    private var _mainContext: NSManagedObjectContext?
    public var mainContext: NSManagedObjectContext? {
        get {
            if _mainContext == nil {
                let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
                guard let parentContext = masterContext else {
                    print("No master context!")
                    return nil
                }
                
                context.parent = parentContext
                context.mergePolicy = NSOverwriteMergePolicy
                context.undoManager = nil
                _mainContext = context
            }
            
            return _mainContext
        }
    }
    
    // Save
    private var _saveContext: NSManagedObjectContext?
    public var saveContext: NSManagedObjectContext? {
        get {
            if _saveContext == nil {
                let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
                guard let parentContext = mainContext else {
                    print("No main context!")
                    return nil
                }
                
                context.parent = parentContext
                context.mergePolicy = NSOverwriteMergePolicy
                context.undoManager = nil
                _saveContext = context
            }
            return _saveContext
        }
    }
    
    
    public func performSave(context: NSManagedObjectContext, completionHandler: (() -> Void)? ) {
        if context.hasChanges {
            context.perform { [weak self] in
                do {
                    try context.save()
                } catch {
                    print("Context save error: \(error)")
                }
                
                if let parent = context.parent {
                    self?.performSave(context: parent,
                                      completionHandler: completionHandler)
                } else {
                    completionHandler?()
                }
            }
        } else {
            completionHandler?()
        }
    }
    
}


extension AppUser {
    
    static func insertAppUser(in context: NSManagedObjectContext) -> AppUser? {
        return NSEntityDescription.insertNewObject(forEntityName: "AppUser",
                                                   into: context) as? AppUser
    }
    
    static func findOrInserAppUser(in context: NSManagedObjectContext) -> AppUser? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Model is not availablein context!")
            assert(false)
            return nil
        }
        var appUser: AppUser?
        guard let fetchRequest = AppUser.fetchRequestAppUser(model: model) else {
            return nil
        }
        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2, "Multiple AppUsers found!")
            if let foundUser = results.first {
                appUser = foundUser
            }
        } catch {
            print("Failed to fetch AppUser: \(error)")
        }
        
        if appUser == nil {
            appUser = AppUser.insertAppUser(in: context)
        }
        
        return appUser
    }
    
    static func fetchRequestAppUser(model: NSManagedObjectModel) -> NSFetchRequest<AppUser>? {
        let templateName = "AppUser"
        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<AppUser> else {
            assert(false, "No tamplate with name \(templateName)!")
            return nil
        }
        //NSFetchRequest(entityName: "AppUser")
        return fetchRequest
    }
}



