//
//  TableController.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/16.
//

import UIKit

protocol TableControllerDelegate {
    func registerCell() -> [String : AnyClass]
}

struct TableControllerSettings {
    var allowsSelection: Bool
    var allowsMultipleSelection: Bool
}

//struct

class TableController: UIViewController {
    var delegate: TableControllerDelegate!
    var tableViewDelegate: UITableViewDelegate!
    var settings: TableControllerSettings!

    convenience init(delegate: TableControllerDelegate, tableViewDelegate: UITableViewDelegate, settings: TableControllerSettings) {
        self.init()
        self.delegate = delegate
        self.tableViewDelegate = tableViewDelegate
        self.settings = settings
    }
    
    override func viewDidLoad() {
        
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        let cells = delegate.registerCell()
        cells.forEach { (key: String, value: AnyClass) in
            tableView.register(value, forCellReuseIdentifier: key)
        }
        tableView.delegate = tableViewDelegate
        tableView.allowsSelection = settings.allowsSelection
        tableView.allowsMultipleSelection = settings.allowsMultipleSelection
        return tableView
    }()
    
//    lazy var dataSource: UITableViewDiffableDataSource {
//        let data = UITableViewDiffableDataSource<Int, Hashable>(tableView: tableView) { tableView, indexPath, itemIdentifier in
//            return MemberCell()
//        }
//        
//        return data
//    }
}

// MARK: - Private method
extension TableController {
    private func tableViewRegisterCell() {
        
    }
}
