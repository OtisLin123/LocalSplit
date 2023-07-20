//
//  ActivitiesPage.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/7.
//

import UIKit
import Combine

class ActivitiesPage: UIViewController {
    private var viewModel: ActivitiesPageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        self.view.backgroundColor = UIColor(named: "Background")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "PrimaryText")
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
//        button.backgroundColor = UIColor(named: "PrimaryBackground")
//        button.setTitleColor(UIColor(named: "PrimaryText"), for: .normal)
        
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        
        button.addTarget(self, action: #selector(didClickCreatButton), for: .touchUpInside)
        return button
    }()
    
    lazy var userBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "person.badge.plus")?.withTintColor(UIColor(named: "PrimaryText")!), style: .plain, target: self, action: #selector(didClickMemberEditorButton))
        return button
    }()
    
    lazy var activitiesGridViewController: ActivityGridController = {
        let gridController = ActivityGridController(count: 2, activities: viewModel.activities)
        gridController.view.translatesAutoresizingMaskIntoConstraints = false
        gridController.delegate = self
        return gridController
    }()
}

// MARK: - SLOT
extension ActivitiesPage {
    @objc private func didClickCreatButton() {
        let activityInfoPage =
        ActivityEditorController(
            data: ActivityEditorData(
                id: UUID().uuidString,
                activityName: "",
                selectedMembers: []
            ),
            mode: ActivityEditorMode.Create, totalMembers: MainModel.shard.members
        )
        activityInfoPage.delegate = self
        self.navigationController?.pushViewController(activityInfoPage, animated: true)
    }
    
    @objc private func didClickMemberEditorButton() {
        let memberEditorController = MemberEditorController(members: MainModel.shard.members)
        memberEditorController.delegate = self
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
            createButton.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor, constant: -50),
            createButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
}

// MARK: - MemberEditorPageDelegate
extension ActivitiesPage: MemberEditorPageDelegate {
    func replaceMembersData(members: [MemberModel]) {
        MainModel.shard.members = members
    }
}

// MARK: - ActivityInfoCallBackDelegate
extension ActivitiesPage: ActivityEditorDelegate {
    func receiveData(data: ActivityEditorData) {
        var activity = viewModel.getActivity(data.id) ?? ActivityModel()
        activity.id = data.id
        activity.name = data.activityName
        activity.people = data.selectedMembers
        viewModel.setActivity(activity)
    }
}

// MARK: - ActivityGridControllerCallBackDelegate
extension ActivitiesPage: ActivityGridControllerDelegate {
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
        ActivityEditorController(
            data: ActivityEditorData(
                id: activity?.id,
                activityName: activity?.name,
                selectedMembers: activity?.people
            ),
            mode: ActivityEditorMode.Modify, totalMembers: MainModel.shard.members
        )
        activityInfoPage.delegate = self
        self.navigationController?.pushViewController(activityInfoPage, animated: true)
    }
}
