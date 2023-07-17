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
        self.view.addSubview(buttonStack)
        doLayout()
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
            cell.delegate = self
            cell.setData(model.data)
            return cell
        }
        return data
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("AddSpend", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(didClickAddSpendButton), for: .touchUpInside)
        return button
    }()
    
    lazy var resultButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Settle", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.addArrangedSubview(addButton)
        stack.addArrangedSubview(resultButton)
        return stack
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
            tableView.bottomAnchor.constraint(equalTo: buttonStack.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            buttonStack.rightAnchor.constraint(equalTo: self.view.safeRightAnchor),
            buttonStack.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor),
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

// MARK: - SLOT
extension SpendsPageController {
    @objc func didClickAddSpendButton() {
        let spendModel: SpendModel = SpendModel(id: UUID().uuidString)
        let spendEditor = SpendEditorController(mode: SpendEditorMode.Create, spendModel: spendModel)
        spendEditor.delegate = self
        self.navigationController?.pushViewController(spendEditor, animated: true)
    }
}

// MARK: - SpendCellDelegate
extension SpendsPageController: SpendCellDelegate {
    func didClickDelete(_ spendId: String) {
        print("click spend delete")
    }
    
    func didClickModify(_ spendId: String) {
        let spendModel: SpendModel? = viewModel?.getSpendData(spendId)
        guard spendModel != nil else {
            return
        }
        let spendEditor = SpendEditorController(mode: SpendEditorMode.Modify, spendModel: spendModel!)
        spendEditor.delegate = self
        self.navigationController?.pushViewController(spendEditor, animated: true)
    }
}

// MARK: - SpendEditorControllerDelegate
extension SpendsPageController: SpendEditorControllerDelegate {
    func didApplyClick(_ model: SpendModel) {
        print(model.name)
        print(model)
    }
}
