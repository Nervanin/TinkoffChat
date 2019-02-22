//
//  ConversationTableViewCell.swift
//  TinkoffChat
//
//  Created by Konstantin on 21/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class ConversationTableViewCell: UITableViewCell, ConversationCellConfiguration {
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var lastUserMessage: UILabel!
    @IBOutlet var dateOfLatsMessage: UILabel!
    
    var name: String? 
    var message: String?
    var date: Date?
    var online: Bool?
    var hasUnreadMessge: Bool?
    var userImage: String?
    var status: String?
    var id: Int?
    
   
    init?(id: Int?, status: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        self.id = id
        self.status = status
    }

    init?(id: Int?, name: String?, message: String?, /* date: Date?,*/ online: Bool?, hasUnreadMessge: Bool?, userImage: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        self.id = id
        self.name = name
        self.message = message
       // self.date = date
        self.online = online
        self.hasUnreadMessge = hasUnreadMessge
        self.userImage = userImage
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
