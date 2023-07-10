//
//  SecondViewController.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/7.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = .black
        
//        
//        let action = UIAction {
//            _ in
//            print("second view button clicked")
//            self.navigationController?.popViewController(animated: true)
//        }
//        button.addAction(action, for: .touchUpInside)
//        
        self.view.addSubview(button)
    }
}
