//
//  UIImage.swift
//  TinkoffChat
//
//  Created by Konstantin on 26/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

extension UIImage {
    
    func fixOrientation() -> UIImage {
        if imageOrientation == .up {
            return self
        } else {
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            defer { UIGraphicsEndImageContext() }
            draw(in: CGRect(origin: .zero, size: size))
            return UIGraphicsGetImageFromCurrentImageContext() ?? self
        }
    }
}
