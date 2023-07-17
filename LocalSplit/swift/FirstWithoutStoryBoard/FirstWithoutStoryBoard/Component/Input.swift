//
//  Input.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/17.
//

import UIKit

class Input: UIView {
    
    init() {
        super.init(frame: .zero)
        self.addSubview(titleLabel)
        self.addSubview(textField)
        doLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.addUnderLine(color: UIColor.darkGray.cgColor)
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
}

// MARK: - Private method
extension Input {
    private func doLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: textField.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor),
            textField.leftAnchor.constraint(equalTo: self.leftAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
