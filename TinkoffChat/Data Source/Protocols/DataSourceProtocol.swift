//
//  DataSource.swift
//  TinkoffChat
//
//  Created by Konstantin on 13/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation
// i used Generic type because i dont want create function for String types and Data types
protocol DataSourceProtocol {
    
    func saveData<Object: Codable>(object: Object, file: String, completion: @escaping  (Error?) -> Void)
    
    func loadData<Object: Codable>(type: Object.Type, file: String, completion: @escaping  (Object?, Error?) -> Void)
}

extension DataSourceProtocol {
    func createURL(file: String) -> URL {
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return url.appendingPathComponent(file).appendingPathExtension("json")
    }
}
