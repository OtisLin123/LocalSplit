//
//  MemberTableViewController.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/9.
//

import UIKit

class MemberTableController: UIViewController {
    var members: [MemberModel] = []
    var memberDataDelegate: MemberDataDelegate? = nil
    
    convenience init (members: [MemberModel]) {
        self.init()
        self.members = members
    }
    
    override func viewDidLoad() {
        self.view.addSubview(tableView)
        doLayout()
        applySnapShot()
    }
    
    func applySnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, MemberModel>()
        snapShot.appendSections([.main])
        snapShot.appendItems(members, toSection: .main)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    func doLayout() {
        /// layout table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MemberCell.self, forCellReuseIdentifier: "Cell")
        view.delegate = self
        view.allowsSelection = false
        return view
    }()
    
    lazy var dataSource: UITableViewDiffableDataSource = {
        let data = UITableViewDiffableDataSource<Section, MemberModel>(tableView: tableView) {
        tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MemberCell
            cell.selectionStyle = .none
            cell.cellDelegate = self
            cell.setData(model, showDelete: true)
            cell.indexPath = indexPath
            return cell
        }
        data.defaultRowAnimation = .fade
        return data
    }()
}

// Public method
extension MemberTableController {
    func setData(members: [MemberModel]) {
        self.members = members
        applySnapShot()
        tableView.reloadData()
    }
}

// delegate
extension MemberTableController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MemberTableController: MemberCellDelegate {
    func didDeleteTap(_ indexPath: IndexPath) {
        memberDataDelegate?.deleteMember(index: indexPath.row)
    }
}

//define
enum Section: CaseIterable {
    case main
}
