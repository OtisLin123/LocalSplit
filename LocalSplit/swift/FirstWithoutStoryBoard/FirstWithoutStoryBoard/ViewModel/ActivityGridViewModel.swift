//
//  ActivityGridViewModel.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/11.
//

import Foundation

class ActivityGridViewModel : NSObject {
    
    private(set) var activitiesData : [ActivityModel] {
        didSet {
            self.bindDidActivitiesChanged()
        }
    }
    
    var bindDidActivitiesChanged: (() -> ()) = {}
    
    init(activities : [ActivityModel]){
        self.activitiesData = activities
        super.init()
    }
}

// Public Method
extension ActivityGridViewModel {
    func setActivitiesData(activities : [ActivityModel]) {
        self.activitiesData = activities
    }
}
