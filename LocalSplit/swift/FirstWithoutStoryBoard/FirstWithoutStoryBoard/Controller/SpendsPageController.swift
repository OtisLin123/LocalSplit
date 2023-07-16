//
//  SpendsPageController.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/16.
//

import UIKit

struct SpendsItemModel: Hashable {
    var data: SpendModel
}

enum SpendSection: CaseIterable {
    case main
}

class SpendsPageController: UIViewController {
    private var viewModel: SpendsPageViewModel?
    
    convenience init(_ datas: [SpendModel]) {
        self.init()
        initViewModel()
        setSpendDatas(datas)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Spends"
        self.view.addSubview(tableView)
        doLayout()
        tableView.reloadData()
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SpendCell.self, forCellReuseIdentifier: "Cell")
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .gray
        return tableView
    }()
    
    lazy var dataSource: UITableViewDiffableDataSource = {
        let data = UITableViewDiffableDataSource<SpendSection, SpendsItemModel>(tableView: tableView) { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SpendCell
            cell.selectionStyle = .none
            cell.setData(model.data)
            return cell
        }
        return data
    }()
}

// MARK: - Public method
extension SpendsPageController {
    func setSpendDatas(_ datas: [SpendModel]) {
        viewModel?.setSpendDatas(datas)
    }
}

// MARK: - Private method
extension SpendsPageController {
    private func doLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeTopAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.safeRightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor),
        ])
    }
    
    private func applySnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<SpendSection, SpendsItemModel>()
        snapShot.appendSections([.main])
        snapShot.appendItems(viewModel?.getSpendItemModels() ?? [])
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    private func initViewModel() {
        viewModel = SpendsPageViewModel()
        viewModel?.delegate = self
    }
}

// MARK: - SpendsPageViewModelDelegate
extension SpendsPageController: SpendsPageViewModelDelegate {
    func bindSpendDatasChanged() {
        applySnapShot()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension SpendsPageController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.backgroundColor = .black
//    }
//
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var memberItem = members[indexPath.row]
//        memberItem.isSelected = true
//        members[indexPath.row] = memberItem
//        callBackDelegate?.didMemberSelectedChanged(members)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        var memberItem = members[indexPath.row]
//        memberItem.isSelected = false
//        members[indexPath.row] = memberItem
//        callBackDelegate?.didMemberSelectedChanged(members)
    }
}
