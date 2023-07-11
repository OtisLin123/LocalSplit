//
//  ExpenseModel.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/10.
//

import Foundation
struct ExpenseModel: Hashable, Codable, Identifiable {
    var id: String
    var cost: Double = 0.0
    var people: [String : Double] = [String : Double]()
    var payer: String = ""
}
