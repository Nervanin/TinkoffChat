//
//  DataSourceType.swift
//  TinkoffChat
//
//  Created by Konstantin on 13/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

enum DataSourceType {
    case gcdDataManager
    case operationDataManager
    
    func dataSourceTypeManager() -> DataSourceProtocol {
        switch self {
        case .gcdDataManager:
            return GCDDataManager()
        case .operationDataManager:
            return OperationDataManager()
       
        }
    }
}
