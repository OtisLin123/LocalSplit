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

class MemberEditorPageController: UIViewController {
    private var viewModel: MemberEditorPageViewModel!
    weak var delegate: MemberEditorPageDelegate?
    
    convenience init(members: [MemberModel]) {
        self.init()
        initViewModel(members: members)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        self.view.backgroundColor = .white
        self.title = "MemberEditor"
        
        add(safeArea)
        safeArea.view.addSubview(textField)
        safeArea.view.addSubview(addButton)
        safeArea.add(memberTableViewController)
        doLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.replaceMembersData(members: viewModel.members)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        textField.addUnderLine(color: UIColor.darkGray.cgColor)
    }
    
    lazy var safeArea: UIViewController = {
        let safeArea = UIViewController()
        safeArea.view.translatesAutoresizingMaskIntoConstraints = false
        return safeArea
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false;
        return textField
    }()
    
    lazy var addButton: UIButton = {
        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        addButton.setImage(UIImage(systemName: "plus.app")?.withTintColor(.black), for: .normal)
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
extension MemberEditorPageController {
    func addMember(_ data: MemberModel) {
        viewModel.addMember(data)
    }
}

// MARK: - Private method
extension MemberEditorPageController {
    private func initViewModel(members: [MemberModel]) {
        viewModel = MemberEditorPageViewModel(members: members)
        viewModel.bindDidMemberChanged = {
            DispatchQueue.main.async {
                self.memberTableViewController.setData(members: self.viewModel.getMemberItems())
            }
        }
    }
    
    private func doLayout() {
        /// layout safe area
        NSLayoutConstraint.activate([
            safeArea.view.topAnchor.constraint(equalTo: self.view.safeTopAnchor),
            safeArea.view.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor),
            safeArea.view.rightAnchor.constraint(equalTo: self.view.safeRightAnchor),
            safeArea.view.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor),
        ])
        
        /// layout text field
        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: safeArea.view.leftAnchor, constant: 10),
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.rightAnchor.constraint(equalTo: addButton.leftAnchor),
            textField.topAnchor.constraint(equalTo: safeArea.view.topAnchor),
        ])
        
        /// add button
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 40),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.rightAnchor.constraint(equalTo: safeArea.view.rightAnchor),
            addButton.topAnchor.constraint(equalTo: safeArea.view.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            memberTableViewController.view.topAnchor.constraint(equalTo: textField.bottomAnchor),
            memberTableViewController.view.leftAnchor.constraint(equalTo: safeArea.view.leftAnchor),
            memberTableViewController.view.rightAnchor.constraint(equalTo: safeArea.view.rightAnchor),
            memberTableViewController.view.bottomAnchor.constraint(equalTo: safeArea.view.bottomAnchor),
        ])
    }
}

// MARK: - SLOT
extension MemberEditorPageController {
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
extension MemberEditorPageController: MemberTableDelegate {
    func didMemberSelectedChanged(_: [MemberItem]) {
        
    }
    
    func deleteMember(index: Int) {
        viewModel.removeMember(index)
    }
}
