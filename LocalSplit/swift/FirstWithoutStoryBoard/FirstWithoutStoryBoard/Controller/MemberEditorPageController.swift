//
//  MenberEditorPageController.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/8.
//

import UIKit

class MemberEditorPageController: UIViewController {
    let textField = UITextField(frame: .zero)
    let memberTableViewController = MemberTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.title = "MemberEditor"
        
        let safeArea = UIViewController()
        safeArea.view.translatesAutoresizingMaskIntoConstraints = false
        add(safeArea)
        
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false;
        
        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        addButton.setImage(UIImage(systemName: "plus.app")?.withTintColor(.black), for: .normal)
        addButton.addTarget(self, action: #selector(didAddButtonClick), for: .touchUpInside)
        
        memberTableViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        safeArea.add(textField)
        safeArea.add(addButton)
        safeArea.add(memberTableViewController)
        
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
    
    override func viewDidLayoutSubviews() {
        textField.addUnderLine(color: UIColor.darkGray.cgColor)
    }
    
    @objc func didAddButtonClick() {
        guard ((textField.text?.isEmpty) != nil) else {
            return
        }
        memberTableViewController.addData(name: textField.text!)
        textField.text = ""
    }
    
}
