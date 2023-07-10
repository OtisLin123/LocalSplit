//
//  ActivityGridViewController.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/7.
//

import Foundation
import UIKit

class ActivityGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var fullScreenSize: CGSize?
    var countOfRow: Int = 1
    
    convenience init(count countOfRow: Int){
        self.init()
        self.countOfRow = countOfRow
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ActivitiesCell
        cell.imageView.image = UIImage(named: "0\(indexPath.item + 1).jpg")
        cell.titleLable.text = "0\(indexPath.item + 1).jpg"
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = CGFloat(8)
        cell.layer.backgroundColor = UIColor.random.cgColor
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green

        fullScreenSize = UIScreen.main.bounds.size
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: fullScreenSize!.width / CGFloat(countOfRow) - 10, height: fullScreenSize!.width / CGFloat(countOfRow) - 10)
//        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let myCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.register(ActivitiesCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        self.view.addSubview(myCollectionView)

        myCollectionView.expend(to: self)
    }
}
