//
//  ModelData.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/10.
//

import Foundation
class ModelData: NSObject {
    lazy var memberData: [MemberModel] = {
        let memberData = [MemberModel(name: "Apple"),
                          MemberModel(name: "Orange"),
                          MemberModel(name: "Banana"),]
        return memberData
    }()
    
    lazy var activities: [ActivityModel] = {
        var activities: [ActivityModel] = Helper().load("activitiesData")
        return activities
    }()
}

