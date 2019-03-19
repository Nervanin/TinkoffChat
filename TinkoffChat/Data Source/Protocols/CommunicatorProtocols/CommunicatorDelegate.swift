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
    func didLostUser(userID: String)
    
    //errors
    func failedToStartBrowsingForUsers(error: Error)
    func failedToStartAdvertising(error: Error)
    
    //message
    func didReceiveMessage(text: String, fromUser: String, toUser: String)
}
