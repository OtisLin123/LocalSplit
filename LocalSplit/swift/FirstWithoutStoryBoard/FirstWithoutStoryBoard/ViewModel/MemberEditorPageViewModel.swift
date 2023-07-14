//
//  MemberEditorPageViewController.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/12.
//

import Foundation
class MemberEditorPageViewModel: NSObject {
    private(set) var members: [MemberModel] {
        didSet {
            self.bindDidMemberChanged()
        }
    }
    
    var bindDidMemberChanged: (() -> ()) = {}
    
    init(members: [MemberModel]) {
        self.members = members
        super.init()
    }
}

// MARK: - Public method
extension MemberEditorPageViewModel {
    func removeMember(_ index: Int) {
        members.remove(at: index)
        print("remove \(index)")
    }
    
    func addMember(_ member: MemberModel) {
        members.append(member)
        print("add \(member.name)")
    }
}
