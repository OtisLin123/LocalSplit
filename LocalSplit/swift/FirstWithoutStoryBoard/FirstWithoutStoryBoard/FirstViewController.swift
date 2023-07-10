//
//  ViewController.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/6.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        button.backgroundColor = .green
        button.isSelected = true
        button.setTitle("normal", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        
//        button.setTitle("highlighted", for: .highlighted)
//        button.setTitleColor(.red, for: .highlighted)
        
        button.setTitle("selected", for: .selected)
        button.setTitleColor(UIColor.blue, for: .selected)
//
//        button.addAction(UIAction {
//            _ in
//
//            if (self.navigationController == nil) {
//                print("aaaa")
//            }
//            self.navigationController?.pushViewController(SecondViewController(), animated: true)
//        }, for: .touchUpInside)
//
        self.view.addSubview(button)
    }

}

