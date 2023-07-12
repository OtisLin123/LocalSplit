//
//  ActivitiesPageViewModel.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/11.
//

import Foundation

class ActivitiesPageViewModel: NSObject {
    private(set) var activitiesData : [ActivityModel]! {
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
        activitiesData = Helper().load("activitiesData")
    }
}
