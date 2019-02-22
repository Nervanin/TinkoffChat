//
//  Models.swift
//  TinkoffChat
//
//  Created by Konstantin on 17/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class UserProfileModel {
    var image = UIImage(named: "placeholder-user")
    var name = "Мелешко Константин"
    var discription = "👨‍💻 Пытаюсь кодить под ios                                                                     👨‍🎓 Учусь в Тинькофф ФинТех                                                                                          👨‍🏫 Помогаю развиваться другим"
}

class ConversationItems: ConversationCellConfiguration {
    var name: String?
    
    var message: String?
    
    var date: Date?
    
    var online: Bool?
    
    var hasUnreadMessge: Bool?
    
    var userImage: String?
    
    init(name: String, message: String?, online: Bool?, hasUnreadMessge: Bool?, userImage: String?) {
        self.name = name
        self.message = message
        self.online = online
        self.hasUnreadMessge = hasUnreadMessge
        self.userImage = userImage
        
    }
}

class ConversationItemsForSection {
    var items = [ConversationTableViewCell]()
    var id = Int()
    var status = String()
    
    init(id: Int, status: String) {
        self.id = id
        self.status = status
    }
}
