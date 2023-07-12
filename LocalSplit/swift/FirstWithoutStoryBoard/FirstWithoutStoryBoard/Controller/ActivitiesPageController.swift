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
    private var activitiesPageViewModel: ActivitiesPageViewModel!
    private var activities: [ActivityModel] = Helper().load("activitiesData")
    private var members: [MemberModel] = [MemberModel(name: "Apple")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Activities"
        
        self.navigationItem.rightBarButtonItem = userBarButton;
        add(safeArea)
        safeArea.add(activitiesGridViewController)
        safeArea.view.addSubview(createButton)
        doLayout()
        
        initViewModel()
    }
    
    lazy var createButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 80))
        button.setTitle("Create Activity", for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(didClickCreatButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var userBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "person.badge.plus"), style: .plain, target: self, action: #selector(didClickMemberEditorButton))
        return button
    }()
    
    lazy var safeArea: UIViewController = {
        let safeArea = UIViewController()
        safeArea.view.translatesAutoresizingMaskIntoConstraints = false
        safeArea.view.backgroundColor = .blue
        return safeArea
    }()
    
    lazy var activitiesGridViewController: ActivityGridController = {
        let gridController = ActivityGridController(count: 2, activities: activities)
        gridController.view.translatesAutoresizingMaskIntoConstraints = false
        return gridController
    }()
    
    @objc private func didClickCreatButton() {
        print("didClickCreatButton")
    }
    
    @objc private func didClickMemberEditorButton() {
        print("didClickCreatButton")
        let memberEditorController = MemberEditorPageController(members: self.members)
        memberEditorController.view.backgroundColor = .white
        memberEditorController.membersDataCallBackDelegate = self
        self.navigationController?.pushViewController(memberEditorController, animated: true)
    }
    
}

// Private method
extension ActivitiesPage {
    private func initViewModel() {
        self.activitiesPageViewModel = ActivitiesPageViewModel()
        self.activitiesPageViewModel.bindActivitiesPageViewModelToController = {
            DispatchQueue.main.async {
                self.activitiesGridViewController.collectionReload()
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
        
        /// layout grid view
        NSLayoutConstraint.activate([
            activitiesGridViewController.view.topAnchor.constraint(equalTo: safeArea.view.topAnchor),
            activitiesGridViewController.view.leftAnchor.constraint(equalTo: safeArea.view.leftAnchor),
            activitiesGridViewController.view.rightAnchor.constraint(equalTo: safeArea.view.rightAnchor),
            activitiesGridViewController.view.bottomAnchor.constraint(equalTo: createButton.topAnchor),
        ])
        
        /// layout  button
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: activitiesGridViewController.view.bottomAnchor),
            createButton.leftAnchor.constraint(equalTo: safeArea.view.leftAnchor),
            createButton.rightAnchor.constraint(equalTo: safeArea.view.rightAnchor),
            createButton.bottomAnchor.constraint(equalTo: safeArea.view.bottomAnchor),
        ])
    }
}

extension ActivitiesPage: MembersDataCallBackDelegate {
    func replaceMembersData(members: [MemberModel]) {
        self.members = members
    }
}
