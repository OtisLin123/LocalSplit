//
//  MemberSelectorPageController.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/14.
//

import UIKit

protocol MemberSelectorDelegate: NSObjectProtocol {
    func receiveSelectedMembers(_: [MemberModel])
}

class MemberSelectorPageController: UIViewController{
    private var viewModel: MemberSelectorPageViewModel!
    weak var delegate: MemberSelectorDelegate?
    var allowsMultipleSelection: Bool = false
    var allowSelection: Bool = false
    
    convenience init(memberItems: [MemberItem], allowSelection: Bool = false, allowsMultipleSelection: Bool = false) {
        self.init()
        initViewModel(memberItems: memberItems)
        self.allowSelection = allowSelection
        self.allowsMultipleSelection = allowsMultipleSelection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose member"
        add(memberTableViewController)
        doLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        var selectedMembers: [MemberModel] = []
        viewModel.memberItems.forEach {
            member in
            if member.isSelected{
                selectedMembers.append(member.data)
            }
        }
        delegate?.receiveSelectedMembers(selectedMembers)
        super.viewWillDisappear(animated)
    }
    
    lazy var memberTableViewController: MemberTableController = {
        let controller = MemberTableController(members: viewModel.memberItems, allowSelection: self.allowSelection, allowsMultipleSelection: self.allowsMultipleSelection)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.delegate = self
        return controller
    }()
}

// MARK: - Private method
extension MemberSelectorPageController {
    private func initViewModel(memberItems: [MemberItem]) {
        viewModel = MemberSelectorPageViewModel(memberItems: memberItems)
    }
    
    private func doLayout() {
        NSLayoutConstraint.activate([
            memberTableViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            memberTableViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            memberTableViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            memberTableViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

// MARK: - MemberTableCallBackDelegate
extension MemberSelectorPageController: MemberTableDelegate {
    func deleteMember(index: Int) {
        
    }
    
    func didMemberSelectedChanged(_ memberItems: [MemberItem]) {
        self.viewModel.setMemberItems(memberItems: memberItems)
    }
}
