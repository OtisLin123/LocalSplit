//
//  SettleViewModel.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/23.
//

import Foundation

protocol SettleViewModelDelegate {
    func bindSplitResultModelsChanged()
}

class SettleViewModel: NSObject {
    var delegate: SettleViewModelDelegate?
    var spendModels: [SpendModel] = []
    
    private(set) var splitResultModels: [SplitResultModel] = [] {
        didSet {
            delegate?.bindSplitResultModelsChanged()
        }
    }
    
    convenience init(_ spendModels: [SpendModel]){
        self.init()
        self.spendModels = spendModels
    }
}

// MARK: - Public method
extension SettleViewModel {
    func settle() {
        self.splitResultModels = Helper().accountCalculation(spends: spendModels)
    }
}
