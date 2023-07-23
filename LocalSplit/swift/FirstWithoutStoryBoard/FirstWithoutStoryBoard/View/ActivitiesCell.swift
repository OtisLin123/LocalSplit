//
//  MyCollectionViewCell.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/7.
//

import UIKit

protocol ActivitiesCellCallBack {
    func didClickModifyButton(id: String)
}

class ActivitiesCell: UICollectionViewCell {
    var data: ActivityModel!
    var callBack: ActivitiesCellCallBack?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(modifyButton)
        doLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let w = Double(UIScreen.main.bounds.size.width)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: w/3-10, height: w/3-10))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let w = Double(UIScreen.main.bounds.size.width)
        let titleLabel = UILabel(frame:CGRect(x: 0, y: 0, width: w/3-10, height: 40))
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(named: "PrimaryText")
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    lazy var modifyButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor(named: "PrimaryText")
        button.addTarget(self, action: #selector(modifyButtonClick), for: .touchUpInside)
        
        return button
    }()
}

// MARK: - Public method
extension ActivitiesCell {
    func setUpData(_ data: ActivityModel) {
        self.data = data
        titleLabel.text = data.name
    }
}

// MARK: - Private method
extension ActivitiesCell {
    private func doLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            modifyButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            modifyButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
        ])
    }
}

// MARK: - SLOT
extension ActivitiesCell {
    @objc func modifyButtonClick() {
        callBack?.didClickModifyButton(id: data.id)
    }
}
