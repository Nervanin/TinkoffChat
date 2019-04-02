//
//  FetchRequest.swift
//  TinkoffChat
//
//  Created by Konstantin on 02/04/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation
import CoreData

class FetchRequestManager {
    
    // Connector let:
    static let shared = FetchRequestManager()
    
    // User's messages:
    func fetchMessagesFrom(conversationID: String) -> NSFetchRequest<Message> {
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        request.predicate = NSPredicate(format: "conversationId == %@", conversationID)
        let sort = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sort]
        return request
    }
    
    // User with ID:
    func fetchUserWithID(id: String) -> NSFetchRequest<User> {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "userId == %@", id)
        return request
    }
    
    // Online users:
    func fetchOnlineUsers() -> NSFetchRequest<User> {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "isOnline == YES")
        return request
    }
    
    // Conversations:
    func fetchConversations() -> NSFetchRequest<Conversation> {
        let request: NSFetchRequest<Conversation> = Conversation.fetchRequest()
        let onlineSortDescriptor = NSSortDescriptor(key: "isOnline", ascending: false)
        let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [onlineSortDescriptor, dateSortDescriptor]
        return request
    }
    
    // Online conversations:
    func fetchOnlineConversations() -> NSFetchRequest<Conversation> {
        let request: NSFetchRequest<Conversation> = Conversation.fetchRequest()
        request.predicate = NSPredicate(format: "isOnline == YES")
        return request
    }
    
    // Exact conversation:
    func fetchConversationWith(id: String) -> NSFetchRequest<Conversation> {
        let request: NSFetchRequest<Conversation> = Conversation.fetchRequest()
        request.predicate = NSPredicate(format: "conversationId == %@", id)
        return request
    }
    
}
