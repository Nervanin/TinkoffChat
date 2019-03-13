//
//  OperationDataManager.swift
//  TinkoffChat
//
//  Created by Konstantin on 13/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

class OperationDataManager: DataSourceProtocol {
    
    let backgroundQueue = OperationQueue()
    
    init() {
        backgroundQueue.underlyingQueue = DispatchQueue.global()
    }
    
    func saveData<Object>(object: Object, file: String, completion: @escaping (Error?) -> Void) where Object : Decodable, Object : Encodable {
        let url = createURL(file: file)
        let operationSave = OperationSave<Object>(object: object, url: url)
        operationSave.completionBlock = {
            OperationQueue.main.addOperation {
                completion(operationSave.error)
            }
        }
        backgroundQueue.addOperation(operationSave)
    }
    
    func loadData<Object>(type: Object.Type, file: String, completion: @escaping (Object?, Error?) -> Void) where Object : Decodable, Object : Encodable {
        let url = createURL(file: file)
        let operationLoad = OperationLoad<Object>(url: url)
        OperationQueue.main.addOperation {
            completion(operationLoad.result, operationLoad.error)
        }
        
    }
    
    
}
