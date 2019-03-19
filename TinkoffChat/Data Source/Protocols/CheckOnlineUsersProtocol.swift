//
//  checkOnlineUsersProtocol.swift
//  TinkoffChat
//
//  Created by Konstantin on 19/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

protocol ConversationDelegate {
    func getMessage(messages: [MessageModel])
    func didUserIsOnline(online: Bool)
}
