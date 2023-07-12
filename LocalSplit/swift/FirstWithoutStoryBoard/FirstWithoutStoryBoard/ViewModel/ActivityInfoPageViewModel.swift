//
//  ActivityInfoPageViewModel.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/12.
//

import Foundation

enum ActivityInfoPageMode: String, CaseIterable {
    case Modify
    case Create
}

class ActivityInfoPageViewModel: NSObject {
    
    private(set) var totalMembers: [MemberModel] {
        didSet {
            self.bindDidTotalMemberChanged()
        }
    }

    private(set) var selectedMembers: [MemberModel] {
        didSet {
            self.bindDidSelectedMemberChanged()
        }
    }
    
    var mode: ActivityInfoPageMode = ActivityInfoPageMode.Create
    var activityName: String
    var id: String
    var bindDidSelectedMemberChanged: (() -> ()) = {}
    var bindDidTotalMemberChanged: (() -> ()) = {}
    
    init(data: ActivityInfoData, mode: ActivityInfoPageMode, totalMembers: [MemberModel]){
        self.mode = mode
        self.id = data.id
        self.activityName = data.activityName
        self.totalMembers = totalMembers
        self.selectedMembers = data.selectedMembers ?? []
        super.init()
    }
}

extension ActivityInfoPageViewModel {
    func setSelectedMember(_ members: [MemberModel]) {
        self.selectedMembers = members
    }
}
