//
//  SplitModel.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/17.
//

import Foundation

struct SplitModel: Hashable, Codable, Identifiable {
    var id: String
    var member: MemberModel
    var ratio: Double
}
