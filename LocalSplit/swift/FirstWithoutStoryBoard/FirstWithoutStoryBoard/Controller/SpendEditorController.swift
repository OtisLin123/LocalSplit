//
//  SpendEditorPage.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/16.
//

import UIKit

enum SplitSection: CaseIterable {
    case main
}

enum SpendEditorMode: String, CaseIterable {
    case Modify
    case Create
}

protocol SpendEditorControllerDelegate: NSObjectProtocol {
    func didClickApply(_ model: SpendModel) -> ()
}

protocol SplitorMemberSelectorDelegate: NSObjectProtocol {
    func receiveSplictorMembers(_: [MemberModel])
}

protocol PayerMemberSelectorDelegate: NSObjectProtocol {
    func receivePayerMember(_: [MemberModel])
}


class SpendEditorController: UIViewController {
    
    var mode: SpendEditorMode = SpendEditorMode.Create
    var viewModel: SpendEditorViewModel?
    weak var delegate: SpendEditorControllerDelegate?
    var splitorDelegate: SplitorMemberSelectorCallBack = SplitorMemberSelectorCallBack()
    var payerDelegate: PayerMemberSelectorCallBack = PayerMemberSelectorCallBack()
    
    convenience init(mode: SpendEditorMode, spendModel: SpendModel) {
        self.init()
        self.mode = mode
        splitorDelegate.delegate = self
        payerDelegate.delegate = self
        initViewModel(spendModel: spendModel)
        costInput.textField.text = viewModel?.spendData?.cost.removeZerosFromEnd()
        spendNameInput.textField.text = viewModel?.spendData?.name
        payerLabel.text = viewModel?.spendData?.payer.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        self.view.backgroundColor = .white
        
        switch self.mode {
        case SpendEditorMode.Create:
            self.title = "AddSpend"
        case SpendEditorMode.Modify:
            self.title = "ModifySpend"
        }
    
        super.view.addSubview(spendNameInput)
        super.view.addSubview(costInput)
        super.view.addSubview(tableView)
        super.view.addSubview(applyButton)
        splitorArea.addSubview(splitorLabel)
        splitorArea.addSubview(addSplitorButton)
        super.view.addSubview(splitorArea)
        super.view.addSubview(payerTitle)
        payerLabelBackground.addSubview(payerLabel)
        super.view.addSubview(payerLabelBackground)
        super.view.addSubview(line)
        doLayout()
    }
    
    lazy var spendNameInput: Input = {
        let input = Input()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.titleLabel.text = "SpendName"
        input.textField.addTarget(self, action: #selector(didSpendNameChanged), for: .editingChanged)
        return input
    }()
    
    lazy var costInput: Input = {
        let input = Input()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.titleLabel.text = "Cost"
        input.textField.delegate = self
        input.textField.keyboardType = .decimalPad
        input.textField.addTarget(self, action: #selector(didCostChanged), for: .editingChanged)
        return input
    }()
    
    lazy var applyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didClickApply), for: .touchUpInside)
        return button
    }()

    lazy var splitorArea: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var splitorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Splitor"
        label.textColor = .black
        return label
    }()
    
    lazy var payerLabelBackground = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didClickPayer))
        view.addGestureRecognizer(tap)
        return view
    }()

    lazy var payerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Payer"
        label.textColor = .black
        return label
    }()
    
    lazy var payerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    lazy var addSplitorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        button.contentVerticalAlignment = UIControl.ContentVerticalAlignment.fill
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.fill
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.addTarget(self, action: #selector(didClickSplitorButton), for: .touchUpInside)
        return button
    }()
    
    lazy var line: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.layer.borderColor = UIColor.black.cgColor
        line.layer.borderWidth = 1
        return line
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SplitCell.self, forCellReuseIdentifier: "Cell")
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .gray
        tableView.delegate = self
        return tableView
    }()
    
    lazy var dataSource: UITableViewDiffableDataSource = {
        let data = UITableViewDiffableDataSource<SplitSection, SplitModel>(tableView: tableView) { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SplitCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.setData(model)
            return cell
        }
        return data
    }()
}

// MARK: - Private method
extension SpendEditorController {
    private func doLayout() {
        NSLayoutConstraint.activate([
            spendNameInput.topAnchor.constraint(equalTo: self.view.safeTopAnchor),
            spendNameInput.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor, constant: 20),
            spendNameInput.rightAnchor.constraint(equalTo: self.view.safeRightAnchor, constant: -20),
            spendNameInput.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            costInput.topAnchor.constraint(equalTo: spendNameInput.bottomAnchor),
            costInput.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor, constant: 20),
            costInput.rightAnchor.constraint(equalTo: self.view.safeRightAnchor, constant: -20),
            costInput.heightAnchor.constraint(equalToConstant: 80)
        ])
    
        NSLayoutConstraint.activate([
            payerTitle.topAnchor.constraint(equalTo: costInput.bottomAnchor),
            payerTitle.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor, constant: 20),
            payerTitle.rightAnchor.constraint(equalTo: self.view.safeRightAnchor, constant: -20),
            payerTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            payerLabel.topAnchor.constraint(equalTo: payerLabelBackground.topAnchor),
            payerLabel.leftAnchor.constraint(equalTo: payerLabelBackground.leftAnchor, constant: 20),
            payerLabel.rightAnchor.constraint(equalTo: payerLabelBackground.rightAnchor),
            payerLabel.bottomAnchor.constraint(equalTo: payerLabelBackground.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            payerLabelBackground.topAnchor.constraint(equalTo: payerTitle.bottomAnchor),
            payerLabelBackground.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor, constant: 20),
            payerLabelBackground.rightAnchor.constraint(equalTo: self.view.safeRightAnchor, constant: -20),
            payerLabelBackground.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: payerLabelBackground.bottomAnchor, constant: 20),
            line.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor, constant: 20),
            line.rightAnchor.constraint(equalTo: self.view.safeRightAnchor, constant: -20),
            line.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            splitorArea.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10),
            splitorArea.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor, constant: 20),
            splitorArea.rightAnchor.constraint(equalTo: self.view.safeRightAnchor, constant: -20),
            splitorArea.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            splitorLabel.topAnchor.constraint(equalTo: splitorArea.topAnchor),
            splitorLabel.leftAnchor.constraint(equalTo: splitorArea.leftAnchor),
            splitorLabel.bottomAnchor.constraint(equalTo: splitorArea.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            addSplitorButton.heightAnchor.constraint(equalToConstant: 30),
            addSplitorButton.widthAnchor.constraint(equalToConstant: 30),
            addSplitorButton.centerYAnchor.constraint(equalTo: splitorArea.centerYAnchor),
            addSplitorButton.leftAnchor.constraint(equalTo: splitorLabel.rightAnchor, constant: 20),
        ])

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: splitorArea.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.safeRightAnchor),
            tableView.bottomAnchor.constraint(equalTo: applyButton.topAnchor),
        ])

        NSLayoutConstraint.activate([
            applyButton.heightAnchor.constraint(equalToConstant: 40),
            applyButton.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor),
            applyButton.rightAnchor.constraint(equalTo: self.view.safeRightAnchor),
            applyButton.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor),
        ])
    }
    
    private func initViewModel(spendModel: SpendModel) {
        viewModel = SpendEditorViewModel()
        viewModel?.delegate = self
        viewModel?.setData(spendModel)
    }
    
    private func applySnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<SplitSection, SplitModel>()
        snapShot.appendSections([.main])
        snapShot.appendItems(viewModel?.spendData?.people ?? [])
        dataSource.apply(snapShot, animatingDifferences: true)
    }
}

// MARK: - SLOT
extension SpendEditorController {
    @objc func didSpendNameChanged(_ textField: UITextField) {
        guard textField.text != nil else {
            return
        }
        viewModel?.spendData?.name = textField.text!
    }
    
    @objc func didCostChanged(_ textField: UITextField) {
        guard textField.text != nil else {
            return
        }
        viewModel?.spendData?.cost = Double(textField.text!) ?? 0
    }
    
    @objc func didClickApply() {
        delegate?.didClickApply(viewModel!.spendData!)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didClickSplitorButton() {
        let page = MemberSelectorPageController(memberItems: viewModel?.getSplitorMemberItem() ?? [], allowSelection: true, allowsMultipleSelection: true)
        page.delegate = splitorDelegate
        self.navigationController?.present(UINavigationController(rootViewController:page), animated: true)
    }
    
    @objc func didClickPayer() {
        let page = MemberSelectorPageController(memberItems: viewModel?.getPayerMemberItem() ?? [], allowSelection: true, allowsMultipleSelection: false)
        page.delegate = payerDelegate
        self.navigationController?.present(UINavigationController(rootViewController:page), animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - SpendEditorViewModelDelegate
extension SpendEditorController: SpendEditorViewModelDelegate {
    func bindPayerDatasChanged() {
        payerLabel.text = viewModel?.spendData?.payer.name
    }
    
    func bindSplitDatasChanged() {
        applySnapShot()
        tableView.reloadData()
    }
}

// MARK: - UITextFieldDelegate
extension SpendEditorController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.first == "." {
            textField.text = ""
            return false
        }
        
        if Helper().isDecimalString(string) {
            return true
        }
        else {
            textField.text = textField.text
            return false
        }
    }
}

// MARK: - UITableViewDelegate
extension SpendEditorController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - SplitCellDelegate
extension SpendEditorController: SplitCellDelegate {
    func didRatioEditChanged(_ splitModel: SplitModel) {
        viewModel?.updateSplitModel(splitModel)
    }
}

// MARK: - MemberSelectorCallBackDelegate
extension SpendEditorController: MemberSelectorDelegate {
    func receiveSelectedMembers(_ members: [MemberModel]) {
        var splitDatas: [SplitModel] = []
        for member in members {
            var splitModel = viewModel?.getSplitModel(member.id)
            if splitModel == nil {
                splitModel = SplitModel(id: member.id, name: member.name, ratio: 1)
            }
            splitDatas.append(splitModel!)
        }
        viewModel?.setSplitDatas(splitDatas)
    }
}

// MARK: - MemberSelectorCallBackDelegate
class SplitorMemberSelectorCallBack: NSObject, MemberSelectorDelegate {
    weak var delegate: SplitorMemberSelectorDelegate?
    func receiveSelectedMembers(_ members: [MemberModel]) {
        delegate?.receiveSplictorMembers(members)
    }
}

class PayerMemberSelectorCallBack: NSObject, MemberSelectorDelegate {
    weak var delegate: PayerMemberSelectorDelegate?
    func receiveSelectedMembers(_ members: [MemberModel]) {
        delegate?.receivePayerMember(members)
    }
}

// MARK: - SplitorMemberSelectorDelegate
extension SpendEditorController: SplitorMemberSelectorDelegate {
    func receiveSplictorMembers(_ members: [MemberModel]) {
        var splitDatas: [SplitModel] = []
        for member in members {
            var splitModel = viewModel?.getSplitModel(member.id)
            if splitModel == nil {
                splitModel = SplitModel(id: member.id, name: member.name, ratio: 1)
            }
            splitDatas.append(splitModel!)
        }
        viewModel?.setSplitDatas(splitDatas)
    }
}

// MARK: - PayerMemberSelectorDelegate
extension SpendEditorController: PayerMemberSelectorDelegate {
    func receivePayerMember(_ members: [MemberModel]) {
        guard members.count > 0 else {
            return
        }
        viewModel?.setPayer(member: members.first!)
    }
}
