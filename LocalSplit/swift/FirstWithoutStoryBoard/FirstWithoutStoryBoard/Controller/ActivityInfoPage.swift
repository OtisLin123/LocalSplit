//
//  ActivityInfoPage.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/12.
//

import Foundation
import UIKit

struct ActivityInfoData {
    var id: String!
    var activityName: String!
    var selectedMembers: [MemberModel]!
}

class ActivityInfoPage: UIViewController {
    var viewModel: ActivityInfoPageViewModel!
    var activityInfoCallBackDelegate: ActivityInfoCallBackDelegate?
    
    convenience init (data: ActivityInfoData, mode: ActivityInfoPageMode, totalMembers: [MemberModel]) {
        self.init()
        initViewModel(data: data, mode: mode, totalMembers: totalMembers)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch viewModel.mode {
        case ActivityInfoPageMode.Create:
            self.title = "CreateActivity"
        case ActivityInfoPageMode.Modify:
            self.title = "ModifyActivity"
        }
        
        super.view.addSubview(textField)
        super.view.addSubview(addMemberButton)
        add(memberTableViewController)
        super.view.addSubview(confirmButton)
        doLayout()
        
        updateCreateButtonEnabled()
        applyDataOnView()
    }
    
    override func viewDidLayoutSubviews() {
        textField.addUnderLine(color: UIColor.darkGray.cgColor)
    }
    
    lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.placeholder = "EntryActivityName"
        textField.addTarget(self, action: #selector(didActivityNameChanged), for: .editingChanged)
        return textField
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.center
        return stackView
    }()
    
    lazy var confirmButton: UIButton = {
        var buttonTitle = ""
        
        switch viewModel.mode {
        case ActivityInfoPageMode.Create:
            buttonTitle = "Create"
        case ActivityInfoPageMode.Modify:
            buttonTitle = "Modify"
        }
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(didConfirmButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var addMemberButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("AddActivityMember", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(didAddActivityMemberButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var memberTableViewController: MemberTableController = {
        let controller = MemberTableController(members: viewModel.selectedMembers, showDelete: false)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()
}

// MARK: - Private method
extension ActivityInfoPage {
    private func initViewModel(data: ActivityInfoData, mode: ActivityInfoPageMode, totalMembers: [MemberModel]) {
        viewModel = ActivityInfoPageViewModel(data: data, mode: mode, totalMembers: totalMembers)
        viewModel.bindDidSelectedMemberChanged = {
            DispatchQueue.main.async {
                self.memberTableViewController.setData(members: self.viewModel.selectedMembers)
            }
        }
        viewModel.bindDidTotalMemberChanged = {
            DispatchQueue.main.async {
                
            }
        }
    }
    
    private func applyDataOnView() {
        memberTableViewController.setData(members: viewModel.selectedMembers)
        textField.text = viewModel.activityName
    }
    
    private func doLayout() {
        // layout text field
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.topAnchor.constraint(equalTo: self.view.safeTopAnchor),
            textField.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor, constant: 20),
            textField.rightAnchor.constraint(equalTo: self.view.safeRightAnchor, constant: -20),
            textField.bottomAnchor.constraint(equalTo: addMemberButton.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            addMemberButton.heightAnchor.constraint(equalToConstant: 40),
            addMemberButton.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor, constant: 20),
            addMemberButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            addMemberButton.bottomAnchor.constraint(equalTo: memberTableViewController.view.topAnchor),
        ])
        
        // layout table view
        NSLayoutConstraint.activate([
            memberTableViewController.view.topAnchor.constraint(equalTo: addMemberButton.bottomAnchor),
            memberTableViewController.view.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor),
            memberTableViewController.view.rightAnchor.constraint(equalTo: self.view.safeRightAnchor),
            memberTableViewController.view.bottomAnchor.constraint(equalTo: confirmButton.topAnchor),
        ])
        
        // layout create button
        NSLayoutConstraint.activate([
            confirmButton.heightAnchor.constraint(equalToConstant: 40),
            confirmButton.widthAnchor.constraint(equalToConstant: 100),
            confirmButton.rightAnchor.constraint(equalTo: self.view.safeRightAnchor),
            confirmButton.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor),
            confirmButton.topAnchor.constraint(equalTo: memberTableViewController.view.bottomAnchor),
        ])
    }
    
    private func updateCreateButtonEnabled() {
        print(!(textField.text?.isEmpty ?? true))
        self.confirmButton.isUserInteractionEnabled = !(textField.text?.isEmpty ?? true)
    }
}

// MARK: - Slot
extension ActivityInfoPage {
    @objc func didConfirmButtonClick() {
        activityInfoCallBackDelegate?.receiveData(
            data: ActivityInfoData(
                id: self.viewModel.id,
                activityName: self.viewModel.activityName,
                selectedMembers: self.viewModel.selectedMembers
            )
        )
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didAddActivityMemberButtonClick() {
        //        self.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
    @objc func didActivityNameChanged() {
        self.viewModel.activityName = textField.text ?? ""
        updateCreateButtonEnabled()
    }
}

// MARK: - UITableViewDelegate
extension ActivityInfoPage: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
