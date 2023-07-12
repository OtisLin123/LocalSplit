//
//  ActivityModel.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/10.
//

import Foundation

struct ActivityModel: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var people: [MemberModel]
    var expense: [ExpenseModel]
}
