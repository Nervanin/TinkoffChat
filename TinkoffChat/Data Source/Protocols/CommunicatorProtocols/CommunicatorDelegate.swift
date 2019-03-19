//
//  CommunicatorDelegate.swift
//  TinkoffChat
//
//  Created by Konstantin on 18/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

protocol CommunicatorDelegate: class {
    //discovering
    func didFoundUser(userID: String, userName: String?)
    func didLostuser(userID: String)
    
    //errors
    func failedToStartBrowsingForUsers(error: Error)
    func failedToStartAdvertising(error: Error)
    
    //message
    func dideceiveMessage(text: String, fromUser: String, toUser: String)
}
