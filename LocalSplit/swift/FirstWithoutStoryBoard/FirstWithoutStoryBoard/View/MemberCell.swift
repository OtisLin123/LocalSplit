//
//  MemberCell.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/9.
//

import UIKit

class MemberCell: UITableViewCell {
    var indexPath: IndexPath!
    weak var cellDelegate: MemberCellDelegate? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        doLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.addTarget(self, action: #selector(didDeleteClick), for: .touchUpInside)
        return button
    }()
}

extension MemberCell {
    @objc func didDeleteClick() {
        cellDelegate?.didDeleteTap(indexPath)
    }
}

// MARK: - Public method
extension MemberCell {
    func setData(_ data: MemberModel, showDelete: Bool) {
        titleLabel.text = data.name
        deleteButton.layer.opacity = showDelete ? 1 : 0
    }
}

// MARK: - Private method
extension MemberCell {
    private func doLayout() {
        /// layout label
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: deleteButton.leftAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.widthAnchor.constraint(equalToConstant: 40),
            deleteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            deleteButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor),
        ])
    }
}
