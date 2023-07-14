//
//  MemberSelectorPageViewModel.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/14.
//

import Foundation

class MemberSelectorPageViewModel: NSObject {
    private(set) var memberItems: [MemberItem] {
        didSet {
            bindDidSelectedMemberChanged()
        }
    }
    
    var bindDidSelectedMemberChanged: (() -> ()) = {}
    
    init(memberItems: [MemberItem]) {
        self.memberItems = memberItems
        super.init()
    }
}

// MARK: - Public method
extension MemberSelectorPageViewModel {
    func setMemberItems(memberItems: [MemberItem]) {
        self.memberItems = memberItems
    }
}
