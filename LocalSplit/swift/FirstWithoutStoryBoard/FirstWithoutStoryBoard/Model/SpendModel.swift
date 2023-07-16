//
//  SpendModel.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/10.
//

import Foundation
struct SpendModel: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var cost: Double = 0.0
    var people: [String : Double] = [String : Double]()
    var payer: String = ""
}
