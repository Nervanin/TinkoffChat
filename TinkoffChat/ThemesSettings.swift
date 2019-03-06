//
//  ThemesSettings.swift
//  TinkoffChat
//
//  Created by Konstantin on 05/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation

final class ThemesManager {
    
    static let sharedInstance = ThemesManager()
    
    private init() {}
    
    func applyTheme(_ color: UIColor) {
        UINavigationBar.appearance().backgroundColor = color
        UINavigationBar.appearance().barTintColor = color
        
        if color.lightTheme {
            UINavigationBar.appearance().tintColor = UIColor.darkText
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        } else {
            UINavigationBar.appearance().tintColor = UIColor.lightText
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightText]
        }
        
        UserDefaults.standard.setColor(color: color, forKey: "themeColor")
        
        let windows = UIApplication.shared.windows as [UIWindow]
        for window in windows {
            let subviews = window.subviews as [UIView]
            for item in subviews {
                item.removeFromSuperview()
                window.addSubview(item)
            }
        }
    }
    
}
