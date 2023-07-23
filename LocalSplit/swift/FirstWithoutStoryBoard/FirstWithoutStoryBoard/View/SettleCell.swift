//
//  SettleCell.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/23.
//

import UIKit

class SettleCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor(named: "ActivityCard")
        self.contentView.addSubview(label)
        doLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "PrimaryText")
        return label
    }()
}

// MARK: - Public method
extension SettleCell {
    func setData(_ data: SplitResultModel) {
        var cost = String(format: "%.2f", data.cost)
        label.text = "\(data.splitPerson.name) need pay \(cost)$ to \(data.payer.name)"
    }
}

// MARK: - Private method
extension SettleCell {
    private func doLayout() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            label.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            label.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
