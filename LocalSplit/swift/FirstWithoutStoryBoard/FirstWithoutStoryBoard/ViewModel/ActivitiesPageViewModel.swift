//
//  ActivitiesPageViewModel.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/11.
//

import Foundation

struct Activities {
    var activities : [ActivityModel] = []
}

class ActivitiesPageViewModel: NSObject {
    private(set) var activities : [ActivityModel] = [] {
        didSet {
            self.bindActivitiesPageViewModelToController()
        }
    }
    
    var bindActivitiesPageViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        callFuncToGetActivitiesData()
    }
    
    func callFuncToGetActivitiesData() {
//        activities = Helper().load("activitiesData")
    }
}

// MARK: - Public method
extension ActivitiesPageViewModel {
    func getActivity(_ id: String) -> ActivityModel? {
        for activity in activities {
            if activity.id == id {
                return activity
            }
        }
        return nil
    }
    
    func setActivity(_ data: ActivityModel) {
        for (index, activity) in activities.enumerated() {
            if activity.id == data.id {
                activities[index] = data
                return
            }
        }
        activities.append(data)
    }
}
