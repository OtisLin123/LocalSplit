//
//  SettlePageController.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/23.
//

import UIKit

enum SettleSection: CaseIterable {
    case main
}

class SettlePageController: UIViewController {
    var viewModel: SettleViewModel?
    
    convenience init(_ spendModels: [SpendModel]) {
        self.init()
        initViewModel(spendModels)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Background")
        self.view.addSubview(tableView)
        self.title = "Settle"
        
        doLayout()
        
        viewModel?.settle()
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SettleCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 85
        tableView.dequeueReusableCell(withIdentifier: "Cell")
        tableView.backgroundColor = UIColor(named: "SecondaryBackground")
        tableView.delegate = self
        return tableView
    }()
    
    lazy var dataSource: UITableViewDiffableDataSource = {
        let dataSource = UITableViewDiffableDataSource<SettleSection, SplitResultModel>(tableView: tableView) {
            tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SettleCell
            cell.setData(model)
            return cell
        }
        return dataSource
    }()
}

// MARK: - Private method
extension SettlePageController {
    private func initViewModel(_ spendModels: [SpendModel]) {
        viewModel = SettleViewModel(spendModels)
        viewModel?.delegate = self
    }
    
    private func applySnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<SettleSection, SplitResultModel>()
        snapShot.appendSections([.main])
        snapShot.appendItems(viewModel?.splitResultModels ?? [])
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    private func doLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeTopAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.safeRightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor),
        ])
    }
}

// MARK: - SettleViewModelDelegate
extension SettlePageController: SettleViewModelDelegate {
    func bindSplitResultModelsChanged() {
        applySnapShot()
    }
}

// MARK: - TableViewDelegate
extension SettlePageController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
