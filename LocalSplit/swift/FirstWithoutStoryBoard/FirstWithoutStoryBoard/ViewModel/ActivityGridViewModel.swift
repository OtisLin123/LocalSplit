//
//  ActivityGridViewModel.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/11.
//

import Foundation

class ActivityGridViewModel : NSObject{
    
    private(set) var activitiesData : [ActivityModel]! {
        didSet {
            self.bindActivityGridViewModelToController()
        }
    }
    
    var bindActivityGridViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        callFuncToGetActivitiesData()
    }
    
    func callFuncToGetActivitiesData() {
        activitiesData = activities
    }
}
