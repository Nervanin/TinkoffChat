//
//  DateExtension.swift
//  TinkoffChat
//
//  Created by Konstantin on 24/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

extension Date {
    
    init?(from: String) {
        
        guard !from.isEmpty else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        guard let date = dateFormatter.date(from: from) else { return nil }
        
        self.init(timeInterval: 0, since: date)
    }
}
