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

class SwiftThemesViewController: UIViewController {
    
    var lightThemeButton = UIButton(type: .custom)
    var grayThemeButton = UIButton(type: .custom)
    var yelowThemeButton = UIButton(type: .custom)
    var cancelButton = UIButton(type: .custom)
    private let model = Themes(firstTheme: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), secondTheme: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), thirdTheme: #colorLiteral(red: 1, green: 0.9572783113, blue: 0.3921568627, alpha: 1))
    
    var closure: ((SwiftThemesViewController, UIColor?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lightThemeButton.setTitle("Light theme", for: .normal)
        grayThemeButton.setTitle("Gray theme", for: .normal)
        yelowThemeButton.setTitle("SHAMPAN!!!!", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(lightThemeButton)
        view.addSubview(grayThemeButton)
        view.addSubview(yelowThemeButton)
        
        lightThemeButton.addTarget(nil, action: #selector(setTheme(sender:)), for: .touchUpInside)
        grayThemeButton.addTarget(nil, action: #selector(setTheme(sender:)), for: .touchUpInside)
        yelowThemeButton.addTarget(nil, action: #selector(setTheme(sender:)), for: .touchUpInside)
        
        grayThemeButton.snp.makeConstraints { (make) in
            
            make.centerX.centerY.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        lightThemeButton.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(view)
            make.bottom.equalTo(grayThemeButton).offset(-90)
            make.height.equalTo(grayThemeButton.snp.height)
            make.width.equalTo(grayThemeButton.snp.width)
        }
        
        yelowThemeButton.snp.makeConstraints { (make) in
            
            make.top.equalTo(grayThemeButton).offset(90)
            make.centerX.equalTo(view)
            make.height.equalTo(grayThemeButton.snp.height)
            make.width.equalTo(grayThemeButton.snp.width)

        }
        
        if let savedTheme = UserDefaults.standard.colorForKey(key: "themeColor") {
            view.backgroundColor = savedTheme
        }
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
//    @IBAction private func cancelButtonPressed() {
//        dismiss(animated: true)
//    }
//
    @objc func setTheme(sender: UIButton) {
        if sender == lightThemeButton {
            closure?(self, model?.lightColor)
        } else if sender == grayThemeButton {
            closure?(self, model?.blueColor)
        } else if sender == yelowThemeButton {
            closure?(self, model?.blackColor)
        }
    }
    
//    @IBAction private func chengeThemeButtonPressed(sender: UIButton) {
//        if sender.currentTitle == "Light theme" {
//            closure?(self, model?.lightColor)
//        } else if sender.currentTitle == "Blue theme" {
//            closure?(self, model?.blueColor)
//        } else if sender.currentTitle == "Dark theme" {
//            closure?(self, model?.blackColor)
//        }
//    }
    
}
