//
//  ConversationTableViewCell.swift
//  TinkoffChat
//
//  Created by Konstantin on 21/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class ConversationTableViewCell: UITableViewCell, ConversationCellConfiguration {
    
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool?
    var hasUnreadMessge: Bool?
    var userImage: String?
    var status: String?
    var id: Int?
    
    
    //var conversationCellConfiguration = [ConversationCellConfiguration]()
    
//    init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    init?(id: Int?, status: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        self.id = id
        self.status = status
    }
//
    init?(id: Int?, name: String?, message: String?, /* date: Date?,*/ online: Bool?, hasUnreadMessge: Bool?, userImage: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        self.id = id 
        //(style: .default, reuseIdentifier: )
        self.name = name
        self.message = message
       // self.date = date
        self.online = online
        self.hasUnreadMessge = hasUnreadMessge
        self.userImage = userImage
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       // fatalError("init(coder:) has not been implemented")
    }
    //
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var laseUserMessage: UILabel!
    @IBOutlet var dateOfLatsMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       // name = "Костик"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }

}
