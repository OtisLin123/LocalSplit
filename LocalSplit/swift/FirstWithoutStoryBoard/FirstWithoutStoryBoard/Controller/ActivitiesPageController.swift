//
//  ActivitiesPage.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/7.
//

import UIKit
import Combine

protocol MembersDataCallBackDelegate {
    func replaceMembersData(members: [MemberModel])
}

class ActivitiesPage: UIViewController {
    private var viewModel: ActivitiesPageViewModel!
    private var members: [MemberModel] = Helper().load("membersData")
//    [MemberModel(id: "111", name: "Apple"), MemberModel(id: "113", name: "Banana"), MemberModel(id: "112", name: "Orange")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        
        self.view.backgroundColor = .white
        self.title = "Activities"
        
        self.navigationItem.rightBarButtonItem = userBarButton;
        add(activitiesGridViewController)
        self.view.addSubview(createButton)
        doLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        createButton.sizeThatFits(.zero)
    }
    
    lazy var createButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.setTitle("Create Activity", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didClickCreatButton), for: .touchUpInside)
        return button
    }()
    
    lazy var userBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "person.badge.plus"), style: .plain, target: self, action: #selector(didClickMemberEditorButton))
        return button
    }()
    
    lazy var activitiesGridViewController: ActivityGridController = {
        let gridController = ActivityGridController(count: 2, activities: viewModel.activities)
        gridController.view.translatesAutoresizingMaskIntoConstraints = false
        gridController.activityGridControllerCallBackDelegate = self
        return gridController
    }()
}

// MARK: - SLOT
extension ActivitiesPage {
    @objc private func didClickCreatButton() {
        let activityInfoPage =
        ActivityInfoPage(
            data: ActivityInfoData(
                id: UUID().uuidString,
                activityName: "",
                selectedMembers: []
            ),
            mode: ActivityInfoPageMode.Create, totalMembers: members
        )
        activityInfoPage.activityInfoCallBackDelegate = self
        activityInfoPage.view.backgroundColor = .white
        self.navigationController?.pushViewController(activityInfoPage, animated: true)
    }
    
    @objc private func didClickMemberEditorButton() {
        let memberEditorController = MemberEditorPageController(members: self.members)
        memberEditorController.view.backgroundColor = .white
        memberEditorController.membersDataCallBackDelegate = self
        self.navigationController?.pushViewController(memberEditorController, animated: true)
    }
}

// MARK: - Private method
extension ActivitiesPage {
    private func initViewModel() {
        self.viewModel = ActivitiesPageViewModel()
        self.viewModel.bindActivitiesPageViewModelToController = {
            DispatchQueue.main.async {
                self.activitiesGridViewController.setActivitiesData(activities: self.viewModel.activities)
            }
        }
    }
    
    private func doLayout() {
        /// layout grid view
        NSLayoutConstraint.activate([
            activitiesGridViewController.view.topAnchor.constraint(equalTo: self.view.safeTopAnchor),
            activitiesGridViewController.view.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor),
            activitiesGridViewController.view.rightAnchor.constraint(equalTo: self.view.safeRightAnchor),
            activitiesGridViewController.view.bottomAnchor.constraint(equalTo: createButton.topAnchor),
        ])
        
        /// layout  button
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: activitiesGridViewController.view.bottomAnchor, constant: 20),
            createButton.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor),
            createButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
}

// MARK: - MemberDataCallBackDelegate
extension ActivitiesPage: MembersDataCallBackDelegate {
    func replaceMembersData(members: [MemberModel]) {
        self.members = members
    }
}

// MARK: - ActivityInfoCallBackDelegate
extension ActivitiesPage: ActivityInfoCallBackDelegate {
    func receiveData(data: ActivityInfoData) {
        var activity = viewModel.getActivity(data.id) ?? ActivityModel()
        activity.id = data.id
        activity.name = data.activityName
        activity.people = data.selectedMembers
        viewModel.setActivity(activity)
    }
}

// MARK: - ActivityGridControllerCallBackDelegate
extension ActivitiesPage: ActivityGridControllerCallBackDelegate {
    func didClickActivity(id: String) {
        let activity = viewModel.getActivity(id)
        
        guard activity != nil else {
            return
        }
     
        let spendsPage = SpendsPageController(activity?.spend ?? [])
        self.navigationController?.pushViewController(spendsPage, animated: true)
    }
    
    func didClickModify(id: String) {
        let activity = viewModel.getActivity(id)
        
        guard activity != nil else {
            return
        }
        
        let activityInfoPage =
        ActivityInfoPage(
            data: ActivityInfoData(
                id: activity?.id,
                activityName: activity?.name,
                selectedMembers: activity?.people
            ),
            mode: ActivityInfoPageMode.Modify, totalMembers: members
        )
        activityInfoPage.activityInfoCallBackDelegate = self
        activityInfoPage.view.backgroundColor = .white
        self.navigationController?.pushViewController(activityInfoPage, animated: true)
    }
}
