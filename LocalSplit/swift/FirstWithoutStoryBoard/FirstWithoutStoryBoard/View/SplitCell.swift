//
//  SplitCell.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/17.
//

import UIKit

protocol SplitCellDelegate: NSObjectProtocol {
    func didRatioEditChanged(_ splitModel: SplitModel) -> ()
}

class SplitCell: UITableViewCell {
    var splitModel: SplitModel?
    weak var delegate: SplitCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(splitRatio)
        self.backgroundColor = UIColor(named: "ActivityCard")
        self.tintColor = UIColor(named: "PrimaryText")
        doLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var splitRatio: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.delegate = self
        input.addTarget(self, action: #selector(didRatioEditingChanged), for: .editingChanged)
        input.layer.borderColor = UIColor.black.cgColor
        input.layer.borderWidth = 1
        return input
    }()
}

// MARK: - Public method
extension SplitCell {
    func setData(_ data: SplitModel) {
        splitModel = data
        nameLabel.text = data.name
        splitRatio.text = String(data.ratio)
    }
}

// MARK: - Private method
extension SplitCell {
    private func doLayout() {
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: splitRatio.leftAnchor),
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            splitRatio.widthAnchor.constraint(equalToConstant: self.bounds.width/3),
            splitRatio.heightAnchor.constraint(equalToConstant: self.bounds.height/1.5),
            splitRatio.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            splitRatio.leftAnchor.constraint(equalTo: nameLabel.rightAnchor),
            splitRatio.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
        ])
    }
}

// MARK: - SLOT
extension SplitCell {
    @objc func didRatioEditingChanged(_ textField: UITextField) {
        guard splitModel != nil,
              textField.text != nil
        else {
            return
        }
        splitModel?.ratio = Double(textField.text!) ?? 0
        delegate?.didRatioEditChanged(splitModel!)
    }
}

// MARK: - UITextFieldDelegate
extension SplitCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.first == "." {
            textField.text = ""
            return false
        }
        
        if Helper().isDecimalString(string) {
            return true
        }
        else {
            textField.text = textField.text
            return false
        }
    }
}
