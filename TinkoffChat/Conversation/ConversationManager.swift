//
//  ConversationManager.swift
//  TinkoffChat
//
//  Created by Konstantin on 19/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class ConversationManager: NSObject {
    func createConversationWith(userName: String, userID: String) -> ConversationModel {
        let conversation = ConversationModel(name: userName, messages: [], message: nil, date: Date(), online: true, userId: userID, hasUnreadMessages: true)
        return conversation
    }
    
    private func generateRandomDate() -> Date? {
        
        let todayDate = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: todayDate)
        let year = calendar.component(.year, from: todayDate)
        let month = calendar.component(.month, from: todayDate)
        let hours = calendar.component(.hour, from: todayDate)
        let minutes = calendar.component(.minute, from: todayDate)
        
        let dateString = "\(arc4random_uniform(UInt32(day)) + 1).\(month).\(year) \(arc4random_uniform(UInt32(hours))):\(arc4random_uniform(UInt32(minutes)))"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        let date = dateFormatter.date(from: dateString)
        return date
    }
}

