//
//  MemberTableViewController.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/9.
//

import UIKit

class MemberTableViewController: UIViewController {
    
    override func viewDidLoad() {
        self.view.addSubview(tableView)
        doLayout()
        applySnapShot()
    }
    
    func applySnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, MemberModel>()
        snapShot.appendSections([.main])
        snapShot.appendItems(memberData, toSection: .main)
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
            cell.titleLabel.text = model.name
            cell.selectionStyle = .none
            cell.cellDelegate = self
            cell.indexPath = indexPath
            return cell
        }
        data.defaultRowAnimation = .fade
        return data
    }()
}

// Public method
extension MemberTableViewController {
    func addData(name value: String) {
        memberData.append(MemberModel(name: value))
        applySnapShot()
    }
}

// delegate
extension MemberTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MemberTableViewController: MemberCellDelegate {
    func didDeleteTap(_ indexPath: IndexPath) {
        guard indexPath.row >= 0 && indexPath.row < memberData.count else {
            return
        }
        memberData.remove(at: indexPath.row)
        applySnapShot()
        tableView.reloadData()
    }
}

//define
enum Section: CaseIterable {
    case main
}

struct MemberModel: Hashable {
    var name: String
}
