//
//  ViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 06/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printSelectorFunction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        printSelectorFunction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        printSelectorFunction()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        printSelectorFunction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        printSelectorFunction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        printSelectorFunction()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(true)
        printSelectorFunction()
    }
    
    func printSelectorFunction(selectorFunction: String = #function) {
        if logOn {
            print(selectorFunction)
        }
    }
    
    
    

}

