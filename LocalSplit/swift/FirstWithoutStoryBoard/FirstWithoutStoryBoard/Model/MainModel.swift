//
//  MainModel.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/18.
//

import Foundation

class MainModel {
    static let shard = MainModel()
    
    var members: [MemberModel] = []
    
    private init(){
//        members = Helper().load("membersData")
    }
}
