//
//  extension.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/7.
//

import Foundation
import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func expend(to parent: UIViewController) {
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: parent.view.topAnchor),
            self.view.leftAnchor.constraint(equalTo: parent.view.leftAnchor),
            self.view.rightAnchor.constraint(equalTo: parent.view.rightAnchor),
            self.view.bottomAnchor.constraint(equalTo: parent.view.bottomAnchor),
        ])
    }
    
    func expend(to parent: UIView) {
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: parent.topAnchor),
            self.view.leftAnchor.constraint(equalTo: parent.leftAnchor),
            self.view.rightAnchor.constraint(equalTo: parent.rightAnchor),
            self.view.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
        ])
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

extension UIView {
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leftAnchor
        }
        return leftAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.rightAnchor
        }
        return rightAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    func expend(to parent: UIViewController) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parent.view.topAnchor),
            self.leftAnchor.constraint(equalTo: parent.view.leftAnchor),
            self.rightAnchor.constraint(equalTo: parent.view.rightAnchor),
            self.bottomAnchor.constraint(equalTo: parent.view.bottomAnchor),
        ])
    }
    
    func expend(to parent: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parent.topAnchor),
            self.leftAnchor.constraint(equalTo: parent.leftAnchor),
            self.rightAnchor.constraint(equalTo: parent.rightAnchor),
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
        ])
    }
}

extension UITextField {
    func addUnderLine (color: CGColor) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 3, width: self.frame.width, height: 1.5)
        bottomLine.backgroundColor = color

        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
        self.layer.masksToBounds = true
    }
}

extension Double {
    func removeZerosFromEnd() -> String {
          let formatter = NumberFormatter()
          let number = NSNumber(value: self)
          formatter.minimumFractionDigits = 0
          formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
          return String(formatter.string(from: number) ?? "")
      }
}
