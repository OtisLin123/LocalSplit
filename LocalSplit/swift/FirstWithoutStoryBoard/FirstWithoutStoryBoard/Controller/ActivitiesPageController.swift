//
//  ActivitiesPage.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/7.
//

import UIKit

class ActivitiesPage: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let userEditorButton = UIBarButtonItem(image: UIImage(systemName: "person.badge.plus"), style: .plain, target: self, action: #selector(didClickMemberEditorButton)) //
        self.title = "Activities"
        self.navigationItem.rightBarButtonItem = userEditorButton;
        
        /// create safe area
        let safeArea = UIViewController()
        safeArea.view.translatesAutoresizingMaskIntoConstraints = false
        safeArea.view.backgroundColor = .blue
        add(safeArea)
        
        /// activities grid view
        let grid = ActivityGridViewController(count: 2)
        grid.view.translatesAutoresizingMaskIntoConstraints = false;
        safeArea.add(grid)
        
        
        /// create activity button
        let creatButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 80))
        creatButton.setTitle("Create Activity", for: .normal)
        creatButton.backgroundColor = .lightGray
        creatButton.addTarget(self, action: #selector(didClickCreatButton), for: .touchUpInside)
        creatButton.translatesAutoresizingMaskIntoConstraints = false;
        safeArea.add(creatButton)
        
        /// layout safe area
        NSLayoutConstraint.activate([
            safeArea.view.topAnchor.constraint(equalTo: self.view.safeTopAnchor),
            safeArea.view.leftAnchor.constraint(equalTo: self.view.safeLeftAnchor),
            safeArea.view.rightAnchor.constraint(equalTo: self.view.safeRightAnchor),
            safeArea.view.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor),
        ])
        
        /// layout grid view
        NSLayoutConstraint.activate([
            grid.view.topAnchor.constraint(equalTo: safeArea.view.topAnchor),
            grid.view.leftAnchor.constraint(equalTo: safeArea.view.leftAnchor),
            grid.view.rightAnchor.constraint(equalTo: safeArea.view.rightAnchor),
            grid.view.bottomAnchor.constraint(equalTo: creatButton.topAnchor),
        ])

        /// layout  button
        NSLayoutConstraint.activate([
            creatButton.topAnchor.constraint(equalTo: grid.view.bottomAnchor),
            creatButton.leftAnchor.constraint(equalTo: safeArea.view.leftAnchor),
            creatButton.rightAnchor.constraint(equalTo: safeArea.view.rightAnchor),
            creatButton.bottomAnchor.constraint(equalTo: safeArea.view.bottomAnchor),
        ])
    }
    
    @objc private func didClickCreatButton() {
        print("didClickCreatButton")
    }
    
    @objc private func didClickMemberEditorButton() {
        print("didClickCreatButton")
        let memberEditorController = MemberEditorPageController()
        memberEditorController.view.backgroundColor = .white
        self.navigationController?.pushViewController(memberEditorController, animated: true)
    }
}
