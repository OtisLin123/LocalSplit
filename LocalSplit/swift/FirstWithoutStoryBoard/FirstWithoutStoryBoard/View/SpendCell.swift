//
//  SpendCell.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/16.
//

import UIKit

class SpendCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(lableStack)
        self.contentView.addSubview(buttonStack)
//        self.contentView.layer.cornerRadius = 15
//        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .white
//        self.backgroundColor = .clear
        doLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var lableStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(payerLabel)
        stack.addArrangedSubview(peopleLabel)
        return stack
    }()
    
    lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .trailing
        stack.distribution = .fillProportionally
        stack.addArrangedSubview(modifyButton)
        stack.addArrangedSubview(deleteButton)
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        return title
    }()
    
    lazy var payerLabel: UILabel = {
        let payer = UILabel()
        payer.textColor = .black
        return payer
    }()
    
    lazy var peopleLabel: UILabel = {
        let people = UILabel()
        people.textColor = .black
        return people
    }()
    
    lazy var modifyButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = .black
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var deleteButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .black
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
}

// MARK: - Public method
extension SpendCell {
    func setData(_ data: SpendModel) {
        titleLabel.numberOfLines = 0
        titleLabel.text = "SpendName: \(data.name)"
        payerLabel.text = "Payer: \(data.payer) $\(data.cost)"
        
        var peopleStr = ""
        data.people.forEach { (key: String, value: Double) in
            if peopleStr.isEmpty {
                peopleStr = key
            }
            else {
                peopleStr += ", \(key)"
            }
        }
        peopleLabel.text = "SplitPeople: \(peopleStr)"
    }
}

// MARK: - Private method
extension SpendCell {
    func doLayout() {
        NSLayoutConstraint.activate([
            lableStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            lableStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15),
            lableStack.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15),
            lableStack.rightAnchor.constraint(equalTo: buttonStack.leftAnchor),
        ])
        
        NSLayoutConstraint.activate([
            buttonStack.leftAnchor.constraint(equalTo: lableStack.rightAnchor),
            buttonStack.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15),
            buttonStack.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
//            buttonStack.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        ])
//        
        NSLayoutConstraint.activate([
            modifyButton.widthAnchor.constraint(equalToConstant: 40),
            modifyButton.heightAnchor.constraint(equalToConstant: 40),
        ])

        NSLayoutConstraint.activate([
            deleteButton.widthAnchor.constraint(equalToConstant: 40),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
        ])

//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
//            titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
//            titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
//            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
//        ])
    }
}
