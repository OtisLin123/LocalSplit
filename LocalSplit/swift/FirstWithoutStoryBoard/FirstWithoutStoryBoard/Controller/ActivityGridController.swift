//
//  ActivityGridViewController.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/7.
//

import Foundation
import UIKit

class ActivityGridController: UIViewController {
    var fullScreenSize: CGSize?
    var countOfRow: Int = 1
    private var activityGridViewModel: ActivityGridViewModel!
    var activityGridControllerCallBackDelegate: ActivityGridControllerCallBackDelegate?
    
    convenience init(count countOfRow: Int, activities: [ActivityModel]){
        self.init()
        self.countOfRow = countOfRow
        initViewModel(activities: activities)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        fullScreenSize = UIScreen.main.bounds.size
        
        self.view.addSubview(collectionView)
        doLayout()
    }
    
    lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: fullScreenSize!.width / CGFloat(countOfRow) - 10, height: fullScreenSize!.width / CGFloat(countOfRow) - 10)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ActivitiesCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
}

// MARK: - Public method
extension ActivityGridController {
    func setActivitiesData(activities : [ActivityModel]) {
        activityGridViewModel.setActivitiesData(activities: activities)
    }
}

// MARK: - Private method
extension ActivityGridController {
    private func doLayout() {
        collectionView.expend(to: self)
    }
    
    private func initViewModel(activities: [ActivityModel]) {
        self.activityGridViewModel = ActivityGridViewModel(activities: activities)
        self.activityGridViewModel.bindDidActivitiesChanged = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ActivityGridController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if activityGridViewModel == nil {
            return 0
        }
        return activityGridViewModel.activitiesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ActivitiesCell
        cell.setUpData(activityGridViewModel.activitiesData[indexPath.row])
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = CGFloat(8)
        cell.layer.backgroundColor = UIColor.random.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        activityGridControllerCallBackDelegate?.didActivitySelected(id: activityGridViewModel.activitiesData[indexPath.row].id)
    }
}

// MARK: - UICollectionViewDataSource
extension ActivityGridController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
