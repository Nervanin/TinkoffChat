//
//  ThemeViewControllerSwift.swift
//  TinkoffChat
//
//  Created by Konstantin on 05/03/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ThemesViewControllerSwift: UIViewController {

    
    private let model = Themes(firstTheme: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), secondTheme: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), thirdTheme: #colorLiteral(red: 1, green: 0.9572783113, blue: 0.3921568627, alpha: 1))
    
    var closure: ((ThemesViewControllerSwift, UIColor?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chengeTheme(_ sender: UIButton!) {
        if sender.currentTitle == "Light theme" {
             closure?(self, model?.lightColor)
        } else if sender.currentTitle == "Gray Theme" {
            closure?(self, model?.grayColor)
        } else if sender.currentTitle == "SHAMPANb!!!!" {
            closure?(self, model?.yellowColor)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let savedTheme = UserDefaults.standard.colorForKey(key: "themeColor") {
            view.backgroundColor = savedTheme
        }
    }
    

}
