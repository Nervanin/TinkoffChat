//
//  ParseDataSource.swift
//  TinkoffChat
//
//  Created by Konstantin on 21/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

class DataSource {
    
    class func parseDataSource() -> [ChatItemsForSection] {
        let path = Bundle.main.path(forResource: "ConversationCellData", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        guard
            let data = try? Data(contentsOf: url),
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                return []
        }
        var conversationCellItemsDictionarry = [Int: ChatItemsForSection]()
        
        let sections = json?["sections"] as? [[String: Any]]
        for item in sections! {
            if let id = item["id"] as? Int,
                let status = item["status"] as? String {
                let instaceStatusSection = ChatItemsForSection(id: id, status: status)
                conversationCellItemsDictionarry[instaceStatusSection.id] = instaceStatusSection
            }
        }
        let items = json?["items"] as? [[String: Any]]
        for item in items! {
            if let identity = item["id"] as? Int,
                let name = item["name"] as? String,
                let message = item["message"] as? String,
                let online = item["online"] as? Bool,
                let hasUnreadMessage = item["hasUnreadMessage"] as? Bool,
                let userImage = item["userImage"] as? String {
                let instanceItems = ConversationTableViewCell(id: identity, name: name, message: message,/* date: date,*/ online: online, hasUnreadMessge: hasUnreadMessage, userImage: userImage)
                conversationCellItemsDictionarry[identity]?.items.append(instanceItems!)
            }
        }
        return conversationCellItemsDictionarry.values.sorted{($0.id < $1.id)}
    }
    
    
    
    
}

