//
//  OperationSave.swift
//  TinkoffChat
//
//  Created by Konstantin on 13/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

class OperationSave<Object: Codable>: AsyncOperation {
    
    var error: Error?
    let object: Object
    let url: URL
    
    init(object: Object, url: URL) {
        self.object = object
        self.url = url
    }
    
    override func main() {
        do {
            let data = try JSONEncoder().encode(object)
            try data.write(to: url, options: .atomic)
            error = nil
        } catch {
            self.error = error
        }
        self.state = .finished
    }
}
