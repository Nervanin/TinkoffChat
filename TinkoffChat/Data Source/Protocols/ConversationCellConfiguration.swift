//
//  ConversationCellConfiguration.swift
//  TinkoffChat
//
//  Created by Konstantin on 21/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

protocol ConversationCellConfiguration: class {
    var name: String? { get set }
    var message: String? { get set }
    var date: Date? { get set }
    var online: Bool? { get set }
    var hasUnreadMessge: Bool? { get set }
    var userImage: String? { get set }
}

