//
//  MemberTableViewController.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/9.
//

import UIKit

struct MemberItem: Hashable {
    var data: MemberModel!
    var isSelected: Bool = false
}

protocol MemberTableCallBackDelegate {
    func didMemberSelectedChanged(_: [MemberItem])
}

class MemberTableController: UIViewController {
    var members: [MemberItem] = []
    var memberDataDelegate: MemberDataDelegate? = nil
    var showDelete: Bool = true
    var allowsMultipleSelection: Bool = false
    var allowSelection: Bool = false
    var callBackDelegate: MemberTableCallBackDelegate?
    
    convenience init (members: [MemberItem], showDelete: Bool = false, allowSelection: Bool = false, allowsMultipleSelection: Bool = false) {
        self.init()
        self.members = members
        self.showDelete = showDelete
        self.allowsMultipleSelection = allowsMultipleSelection
        self.allowSelection = allowSelection
    }
    
    override func viewDidLoad() {
        self.view.addSubview(tableView)
        doLayout()
        applySnapShot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDefaultSelectOnTable()
    }
    
    func applySnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, MemberItem>()
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
        view.allowsSelection = allowSelection
        view.allowsMultipleSelection = allowsMultipleSelection
        return view
    }()
    
    lazy var dataSource: UITableViewDiffableDataSource = {
        let data = UITableViewDiffableDataSource<Section, MemberItem>(tableView: tableView) {
        tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MemberCell
            cell.selectionStyle = .none
            cell.cellDelegate = self
            cell.setData(model.data, showDelete: self.showDelete)
            cell.indexPath = indexPath
            return cell
        }
        data.defaultRowAnimation = .fade
        return data
    }()
}

// MARK: - Public method
extension MemberTableController {
    func setData(members: [MemberItem]) {
        self.members = members
        applySnapShot()
        tableView.reloadData()
    }
}

// MARK: - Private method
extension MemberTableController {
    private func setDefaultSelectOnTable() {
        guard allowsMultipleSelection || allowSelection else {
            return
        }
        
        for (index, member) in members.enumerated() {
            if member.isSelected {
                let indexPath = IndexPath(row: index, section: Section.main.rawValue)
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension MemberTableController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var memberItem = members[indexPath.row]
        memberItem.isSelected = true
        members[indexPath.row] = memberItem
        callBackDelegate?.didMemberSelectedChanged(members)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        var memberItem = members[indexPath.row]
        memberItem.isSelected = false
        members[indexPath.row] = memberItem
        callBackDelegate?.didMemberSelectedChanged(members)
    }
}

// MARK: - MemberCellDelegate
extension MemberTableController: MemberCellDelegate {
    func didDeleteTap(_ indexPath: IndexPath) {
        memberDataDelegate?.deleteMember(index: indexPath.row)
    }
}

// MARK: - Section Enum
enum Section: Int, CaseIterable {
    case main
}
