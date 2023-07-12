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
    var activityInfoPageViewModel: ActivityInfoPageViewModel!
    var activityInfoCallBackDelegate: ActivityInfoCallBackDelegate?
    
    convenience init (data: ActivityInfoData, mode: ActivityInfoPageMode, totalMembers: [MemberModel]) {
        self.init()
        initViewModel(data: data, mode: mode, totalMembers: totalMembers)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch activityInfoPageViewModel.mode {
        case ActivityInfoPageMode.Create:
            self.title = "CreateActivity"
        case ActivityInfoPageMode.Modify:
            self.title = "ModifyActivity"
        }
        
        super.view.addSubview(textField)
        super.view.addSubview(addMemberButton)
        add(memberTableViewController)
        super.view.addSubview(createButton)
        doLayout()
        
        updateCreateButtonEnabled()
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
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(didCreateButtonClick), for: .touchUpInside)
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
        let controller = MemberTableController(members: activityInfoPageViewModel.selectedMembers)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()
}

// Private method
extension ActivityInfoPage {
    private func initViewModel(data: ActivityInfoData, mode: ActivityInfoPageMode, totalMembers: [MemberModel]) {
        activityInfoPageViewModel = ActivityInfoPageViewModel(data: data, mode: mode, totalMembers: totalMembers)
        activityInfoPageViewModel.bindDidSelectedMemberChanged = {
            DispatchQueue.main.async {
                self.memberTableViewController.setData(members: self.activityInfoPageViewModel.selectedMembers)
            }
        }
        activityInfoPageViewModel.bindDidTotalMemberChanged = {
            DispatchQueue.main.async {
                
            }
        }
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
            memberTableViewController.view.bottomAnchor.constraint(equalTo: createButton.topAnchor),
        ])
        
        // layout create button
        NSLayoutConstraint.activate([
            createButton.heightAnchor.constraint(equalToConstant: 40),
            createButton.widthAnchor.constraint(equalToConstant: 100),
            createButton.rightAnchor.constraint(equalTo: self.view.safeRightAnchor),
            createButton.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor),
            createButton.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor),
            createButton.topAnchor.constraint(equalTo: memberTableViewController.view.bottomAnchor),
        ])
    }
    
    func updateCreateButtonEnabled() {
        print(!(textField.text?.isEmpty ?? true))
        self.createButton.isUserInteractionEnabled = !(textField.text?.isEmpty ?? true)
    }
}

// Slot
extension ActivityInfoPage {
    @objc func didCreateButtonClick() {
        activityInfoCallBackDelegate?.createActivity(
            data: ActivityInfoData(
                id: self.activityInfoPageViewModel.id,
                activityName: self.activityInfoPageViewModel.activityName,
                selectedMembers: self.activityInfoPageViewModel.selectedMembers
            )
            
        )
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didAddActivityMemberButtonClick() {
        //        self.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
    @objc func didActivityNameChanged() {
        self.activityInfoPageViewModel.activityName = textField.text ?? ""
        updateCreateButtonEnabled()
    }
}

extension ActivityInfoPage: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
