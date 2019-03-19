//
//  Communicator.swift
//  TinkoffChat
//
//  Created by Konstantin on 18/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

protocol Communicator {
    func sendMessage(string: String, to userId: String, competionandler: ((_ success: Bool, _ error: Error?) ->())?)
    var delegate: CommunicatorDelegate? { get set }
    var online: Bool { get set }
}
