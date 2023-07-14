//
//  MyCollectionViewCell.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/7.
//

import UIKit

class ActivitiesCell: UICollectionViewCell {
    var data: ActivityModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let w = Double(UIScreen.main.bounds.size.width)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: w/3-10, height: w/3-10))
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let w = Double(UIScreen.main.bounds.size.width)
        let titleLabel = UILabel(frame:CGRect(x: 0, y: 0, width: w/3-10, height: 40))
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        return titleLabel
    }()
    
}

// MARK: - Public method
extension ActivitiesCell {
    func setUpData(_ data: ActivityModel) {
        self.data = data
        titleLabel.text = data.name
    }
}
