//
//  GCDWay.swift
//  TinkoffChat
//
//  Created by Konstantin on 13/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

class GCDDataManager: DataSourceProtocol {
   
    func saveData<Object>(object: Object, file: String, completion: @escaping (Error?) -> Void) where Object : Decodable, Object : Encodable {
        DispatchQueue.global().async {
            do {
                let url = self.createURL(file: file)
                let data = try JSONEncoder().encode(object)
                try data.write(to: url, options: .atomic)
            } catch {
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        }
    }
    
    func loadData<Object>(type: Object.Type, file: String, completion: @escaping (Object?, Error?) -> Void) where Object : Decodable, Object : Encodable {
        DispatchQueue.global().async {
            do {
                let url = self.createURL(file: file)
                let data = try Data(contentsOf: url)
                let decodable = try JSONDecoder().decode(Object.self, from: data)
                DispatchQueue.main.async {
                    completion(decodable, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
    
    
    
}
