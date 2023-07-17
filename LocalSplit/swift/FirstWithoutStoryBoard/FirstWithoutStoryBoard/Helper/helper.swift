//
//  helper.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/11.
//

import Foundation
class Helper {
    func load<T: Decodable>(_ filename: String) -> T {
        let decoder = JSONDecoder()
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
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
    
    func isDecimalString(_ string: String) -> Bool {
        let digits = CharacterSet(charactersIn: "0123456789.")
        let stringSet = CharacterSet(charactersIn: string)
        return digits.isSuperset(of: stringSet)
    }
}
