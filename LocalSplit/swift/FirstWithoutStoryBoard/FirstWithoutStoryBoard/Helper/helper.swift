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
    
    func readData() {
        MainModel.shard.activities = read("mainData.json") ?? []
        MainModel.shard.members = read("memberData.json") ?? []
    }
    
    func saveData() {
        save("mainData.json", data: MainModel.shard.activities)
        save("memberData.json", data: MainModel.shard.members)
    }
    
    func read<T: Decodable>(_ fileName: String) -> T? {
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName)
            if FileManager().fileExists(atPath: fileURL.path) {
                let data = try Data(contentsOf: fileURL)
                return try JSONDecoder().decode(T.self, from: data)
            }
            return nil
        } catch {
            print("error reading data")
        }
        return nil
    }
    
    func save<T: Encodable>(_ fileName: String, data: T) {
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(fileName)
            try JSONEncoder().encode(data).write(to: fileURL)
        } catch {
            print("error writing data")
        }
    }
    
    func isDecimalString(_ string: String) -> Bool {
        let digits = CharacterSet(charactersIn: "0123456789.")
        let stringSet = CharacterSet(charactersIn: string)
        return digits.isSuperset(of: stringSet)
    }
    
    func accountCalculation(spends: [SpendModel]) -> [SplitResultModel] {
        let splitResult: SplitResult = SplitResult()
        
        for spend in spends {
            guard !spend.people.isEmpty else {
                continue
            }
            
            // 統計總份數
            var totalDenominator: Double = 0
            for person in spend.people {
                totalDenominator += person.ratio
            }
            if totalDenominator == 0 {
                totalDenominator = 1
            }
            
            // 統計分帳資訊
            for person in spend.people {
                // 分帳與付款同一人則不統計
                guard spend.payer.id != person.member.id else {
                    continue
                }
                splitResult.addResult(
                SplitResultModel(
                    payer: spend.payer,
                    splitPerson: person.member,
                    cost: spend.cost * (person.ratio / totalDenominator)
                ))
            }
        }
        
        splitResult.integrate()
        
        for result in splitResult.result {
            print("\(result.splitPerson.name) need pay to \(result.payer.name) \(result.cost)$")
        }
        
        return splitResult.result
    }
}
