//
//  OperationLoad.swift
//  TinkoffChat
//
//  Created by Konstantin on 13/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

class OperationLoad<Object: Codable>: AsyncOperation {
    var result: Object?
    var error: Error?
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    override func main() {
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode(Object.self, from: data)
            result = decodedData
        } catch {
            self.error = error
        }
        self.state = .finished
    }
}
