//
//  DataManagerProtocol.swift
//  TinkoffChat
//
//  Created by Konstantin on 26/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation
protocol UserManagerProtocol {
    func saveUser(user: User, completion: @escaping (_ success: Bool) -> Void)
    func getUser(completion: @escaping (_ user: User?) -> Void)
}

class UserManager: UserManagerProtocol {
    
    func saveUser(user: User, completion: @escaping (Bool) -> Void) {
        
        CoreDataManager.saveProfile(user) {(success) in
            completion(success)
        }
    }
    
    func getUser(completion: @escaping (User?) -> Void) {
        
        CoreDataManager.loadProfile { (profile) in
            if let _profile = profile {
                let user = User()
                user.name = _profile.name
                user.info = _profile.info
                
                if let image = _profile.image {
                    user.image = UIImage(data: image as Data)
                }
                completion(user)
            } else {
                completion(nil)
            }
        }
    }
}


