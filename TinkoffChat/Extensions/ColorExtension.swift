//
//  ColorExtension.swift
//  TinkoffChat
//
//  Created by Konstantin on 06/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

extension UIColor {
    var lightTheme: Bool {
        var white: CGFloat = 0
        getWhite(&white, alpha: nil)
        return white > 0.5
    }
    func redGreenBlue255() -> (red: Int, green: Int, blue: Int, alpha: Int)? {
        var fRed: CGFloat = 0
        var fGreen: CGFloat = 0
        var fBlue: CGFloat = 0
        var fAlpha: CGFloat = 0
        
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)
            
            return (red: iRed, green: iGreen, blue: iBlue, alpha: iAlpha)
        } else {
            return nil
        }
    }
}

