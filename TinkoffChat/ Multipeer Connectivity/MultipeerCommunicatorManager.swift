//
//  MultipeerCommunicatorManager.swift
//  TinkoffChat
//
//  Created by Konstantin on 19/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

class CommunicatorManager: NSObject, CommunicatorDelegate {
    
    var conversations: [ConversationModel] = [ConversationModel]()
    var communicateManagersDelegate: CommunicatorManagerProtocol?
    var conversationDelegate: ConversationDelegate?
    var multipeerCommunicator: MultipeerCommunicator?
    
    override init() {
        super.init()
        multipeerCommunicator = MultipeerCommunicator(delegate: self)
    }
    
    func didFoundUser(userID: String, userName: String?) {
        if let conversation = conversations.first(where: {$0.id == userID}) {
            conversation.online = true
        } else {
            let conversation = ConversationManager().createConversationWith(userName: userName!, userID: userID)
            conversations.append(conversation)
        }
        communicateManagersDelegate?.updateConversation(conversations: conversations)
        conversationDelegate?.didUserIsOnline(online: true)
    }
    
    func didLostUser(userID: String) {
        if let conversation = conversations.first(where: {$0.id == userID}) {
            conversation.online = false
        }
        
        communicateManagersDelegate?.updateConversation(conversations: conversations)
        conversationDelegate?.didUserIsOnline(online: false)
    }
    
    func failedToStartBrowsingForUsers(error: Error) {
        print(error)
    }
    
    func failedToStartAdvertising(error: Error) {
        print(error)
    }
    
    func didReceiveMessage(text: String, fromUser: String, toUser: String) {
        for item in conversations {
            if item.id == fromUser {
                item.messages?.append(MessageModel(text: text, incomingMessage: true, messageID: nil, date: Date()))
                conversationDelegate?.getMessage(messages: item.messages!)
            }
        }
        communicateManagersDelegate?.updateConversation(conversations: conversations)
    }
    
    
    
}
