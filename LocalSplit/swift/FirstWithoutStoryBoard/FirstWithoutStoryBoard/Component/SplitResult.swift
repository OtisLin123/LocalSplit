//
//  SplitResult.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/21.
//

import Foundation

class SplitResult {
    var result: [SplitResultModel] = []
    
    func addResult(_ data: SplitResultModel) {
        guard data.cost > 0 else {
            return
        }
        
        // 付款及欠債人相同則整合入原本資料中
        for (index, splitResult) in result.enumerated() {
            if splitResult.payer.id == data.payer.id && splitResult.splitPerson.id == data.splitPerson.id {
                var new = splitResult
                new.cost += data.cost
                result[index] = new
                return
            }
        }
        
        // 付款及欠債人不同則新增資料
        result.append(data)
    }
    
    func integrate() {
        var integrateResult: CheckIntegrateResult = isNeedIntegrate()
        guard integrateResult.isNeed else {
            return
        }
        
        while(integrateResult.isNeed) {
            var first: SplitResultModel = result[integrateResult.firstIndex]
            var second: SplitResultModel = result[integrateResult.secondIndex]
            result.remove(at: integrateResult.secondIndex)
            result.remove(at: integrateResult.firstIndex)
            
            var delta: Double = first.cost - second.cost
            if delta > 0 {
                // first 欠款大於 second
                first.cost = delta
                result.append(first)
            }
            else if delta < 0 {
                // second 欠款大於 first
                second.cost = abs(delta)
                result.append(second)
            }
            integrateResult = isNeedIntegrate()
        }
    }
    
    func isNeedIntegrate() -> CheckIntegrateResult {
        // 檢查是否有互相欠款資訊
        for i in 0..<result.count {
            for j in i+1..<result.count {
                if result[i].payer.id == result[j].splitPerson.id && result[i].splitPerson.id == result[j].payer.id {
                    return CheckIntegrateResult(
                        firstIndex: i,
                        secondIndex: j,
                        isNeed: true
                    )
                }
            }
        }
        return CheckIntegrateResult(
            isNeed: false
        )
    }
}
