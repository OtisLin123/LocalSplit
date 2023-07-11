//
//  MemberCell.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/9.
//

import UIKit

class MemberCell: UITableViewCell {
    var titleLabel = UILabel()
    var indexPath: IndexPath!
    weak var cellDelegate: MemberCellDelegate? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        deleteButton.addTarget(self, action: #selector(didDeleteClick), for: .touchUpInside)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MemberCell {
    @objc func didDeleteClick() {
        cellDelegate?.didDeleteTap(indexPath)
    }
}
