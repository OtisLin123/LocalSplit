//
//  MenberEditorPageController.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/8.
//

import UIKit

protocol MemberEditorPageDelegate: NSObjectProtocol {
    func replaceMembersData(members: [MemberModel])
}

class MemberEditorController: UIViewController {
    private var viewModel: MemberEditorViewModel!
    weak var delegate: MemberEditorPageDelegate?
    
    convenience init(members: [MemberModel]) {
        self.init()
        initViewModel(members: members)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        self.view.backgroundColor = UIColor(named: "Background")
        self.title = "MemberEditor"
        
        inputArea.addSubview(textField)
        inputArea.addSubview(addButton)
        self.view.addSubview(inputArea)
        add(memberTableViewController)
        doLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.replaceMembersData(members: viewModel.members)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        textField.addUnderLine(color: UIColor.darkGray.cgColor)
    }
    
    lazy var inputArea: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Background")
        return view
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false;
        textField.placeholder = "EntryMemberName"
        return textField
    }()
    
    lazy var addButton: UIButton = {
        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        addButton.setImage(UIImage(systemName: "plus.app"), for: .normal)
        addButton.tintColor = UIColor(named: "PrimaryText")
        addButton.addTarget(self, action: #selector(didAddButtonClick), for: .touchUpInside)
        return addButton
    }()
    
    lazy var memberTableViewController: MemberTableController = {
        let controller = MemberTableController(members: viewModel.getMemberItems(), showDelete: true)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.delegate = self
        return controller
    }()
}

// MARK: - Public method
extension MemberEditorController {
    func addMember(_ data: MemberModel) {
        viewModel.addMember(data)
    }
}

// MARK: - Private method
extension MemberEditorController {
    private func initViewModel(members: [MemberModel]) {
        viewModel = MemberEditorViewModel(members: members)
        viewModel.bindDidMemberChanged = {
            DispatchQueue.main.async {
                self.memberTableViewController.setData(members: self.viewModel.getMemberItems())
            }
        }
    }
    
    private func doLayout() {
        /// layout input area
        NSLayoutConstraint.activate([
            inputArea.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor),
            inputArea.rightAnchor.constraint(equalTo: self.view.safeRightAnchor),
            inputArea.topAnchor.constraint(equalTo: self.view.safeTopAnchor),
            inputArea.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        /// layout text field
        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: inputArea.leftAnchor, constant: 10),
            textField.rightAnchor.constraint(equalTo: addButton.leftAnchor),
            textField.centerYAnchor.constraint(equalTo: inputArea.centerYAnchor)
        ])
        
        /// add button
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 40),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.rightAnchor.constraint(equalTo: inputArea.rightAnchor),
            addButton.centerYAnchor.constraint(equalTo: inputArea.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            memberTableViewController.view.topAnchor.constraint(equalTo: inputArea.bottomAnchor),
            memberTableViewController.view.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor),
            memberTableViewController.view.rightAnchor.constraint(equalTo: self.view.safeRightAnchor),
            memberTableViewController.view.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor),
        ])
    }
}

// MARK: - SLOT
extension MemberEditorController {
    @objc func didAddButtonClick() {
        guard ((textField.text) != nil) else {
            return
        }
        guard !textField.text!.isEmpty else {
            return
        }
        addMember(MemberModel(
            id: UUID().uuidString,
            name: textField.text!))
        textField.text = ""
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - MemberTableDelegate
extension MemberEditorController: MemberTableDelegate {
    func didMemberSelectedChanged(_: [MemberItem]) {
        
    }
    
    func deleteMember(index: Int) {
        viewModel.removeMember(index)
    }
}
