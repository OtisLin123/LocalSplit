//
//  MemberTableViewController.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/9.
//

import UIKit

class MemberTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var data = ["陳偉殷","王建民","陳金鋒","林智勝"]
    
    let tableView = UITableView()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MemberCell
        cell.titleLabel.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func viewDidLoad() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MemberCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        add(tableView)
        
        /// layout table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    func addData(name value: String) {
        data.append(value)
        
        print(data)
    }
    
}
