//
//  DateExtension.swift
//  TinkoffChat
//
//  Created by Konstantin on 24/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

extension Date {
    static func prepareDateToText(date: Date?) -> String {
        
        let todayDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        if let _date = date {
            
            let todayDateString = dateFormatter.string(from: todayDate)
            let messageDateString = dateFormatter.string(from: _date)
            
            if todayDateString != messageDateString {
                dateFormatter.dateFormat = "dd MMM"
            } else {
                dateFormatter.dateFormat = "HH:mm"
            }
            let dateString = dateFormatter.string(from: _date)
            
            return dateString
        }
        return "--:--"
    }
}
