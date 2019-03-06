//
//  ThemeViewControllerSwift.swift
//  TinkoffChat
//
//  Created by Konstantin on 05/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation
import UIKit

class SwiftThemesViewController: UIViewController {
    
    private let model = Themes(firstTheme: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), secondTheme: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), thirdTheme: #colorLiteral(red: 1, green: 0.9572783113, blue: 0.3921568627, alpha: 1))
    
    var closure: ((SwiftThemesViewController, UIColor?) -> ())?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let savedTheme = UserDefaults.standard.colorForKey(key: "themeColor") {
            view.backgroundColor = savedTheme
        }
    }
    
    @IBAction private func didCloseBarButtonItemTap() {
        dismiss(animated: true)
    }
    
    @IBAction private func didThemeButtonTap(sender: UIButton) {
        if sender.currentTitle == "Light theme" {
            closure?(self, model?.lightColor)
        } else if sender.currentTitle == "Blue theme" {
            closure?(self, model?.blueColor)
        } else if sender.currentTitle == "Dark theme" {
            closure?(self, model?.blackColor)
        }
    }
    
}
