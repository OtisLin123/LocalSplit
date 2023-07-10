//
//  MyCollectionViewCell.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/7.
//

import UIKit

class ActivitiesCell: UICollectionViewCell {
    var imageView: UIImageView!
    var titleLable: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let w = Double(UIScreen.main.bounds.size.width)
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: w/3-10, height: w/3-10))
        self.addSubview(imageView)
        
        titleLable = UILabel(frame:CGRect(x: 0, y: 0, width: w/3-10, height: 40))
        titleLable.textAlignment = .center
        titleLable.textColor = UIColor.white
        self.addSubview(titleLable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
