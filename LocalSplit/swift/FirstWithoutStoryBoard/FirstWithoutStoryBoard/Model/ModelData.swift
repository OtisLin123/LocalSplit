//
//  ModelData.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/10.
//

import Foundation


var memberData = [MemberModel(name: "Apple"),
                  MemberModel(name: "Orange"),
                  MemberModel(name: "Banana"),]

var activities: [ActivityModel] =  load("activitiesData")

func load<T: Decodable>(_ filename: String) -> T {
    let decoder = JSONDecoder()
    let data: Data
    
    guard let file = Bundle.main.url(forResource: "activitiesData", withExtension: "json")
    else {
        fatalError("Coluden't find \(filename) in main bundle")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Coluden't load \(filename) from main bundle: \n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Coluden't parse \(filename) as \(T.self):\n\(error)")
    }
}




