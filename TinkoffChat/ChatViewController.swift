//
//  ChatViewController.swift
//  TinkoffChat
//
//  Created by Konstantin on 20/02/2019.
//  Copyright © 2019 Konstantin Meleshko. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView: UITableView = {
            var tableView = UITableView()
            return tableView
        }()
        
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MyCell.self, forCellReuseIdentifier: cellId)
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.frame = view.frame
        view.addSubview(tableView)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MyCell
        cell.configure(titleLabel: "Ален", subtitleLabel: "\(indexPath)")
        return cell
    }
}



class MyCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
    
    func configure(titleLabel: String, subtitleLabel: String) {
        self.textLabel?.text = titleLabel
        self.subtitleLabel.text = subtitleLabel
    }
}
