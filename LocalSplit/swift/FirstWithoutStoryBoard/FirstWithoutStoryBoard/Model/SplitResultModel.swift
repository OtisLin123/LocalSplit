//
//  SplitResultModel.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/21.
//

import Foundation

struct SplitResultModel: Hashable {
    var payer: MemberModel
    var splitPerson: MemberModel
    var cost: Double = 0.0
}

struct CheckIntegrateResult {
    var firstIndex: Int = -1
    var secondIndex: Int = -1
    var isNeed: Bool = false
}
