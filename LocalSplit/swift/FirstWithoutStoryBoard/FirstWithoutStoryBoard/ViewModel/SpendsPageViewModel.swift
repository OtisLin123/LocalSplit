//
//  SpendsPageViewModel.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/16.
//

import Foundation

protocol SpendsPageViewModelDelegate {
    func bindSpendDatasChanged() -> ()
}

class SpendsPageViewModel: NSObject {
    var delegate: SpendsPageViewModelDelegate?
    
    private(set) var spendDatas: [SpendModel] = [] {
        didSet {
            delegate?.bindSpendDatasChanged()
        }
    }
}

// MARK: - Public method
extension SpendsPageViewModel {
    func setSpendDatas(_ datas: [SpendModel]) {
        spendDatas = datas
    }
    
    func getSpendItemModels() -> [SpendsItemModel] {
        var result: [SpendsItemModel] = []
        
        spendDatas.forEach { model in
            result.append(SpendsItemModel(
                data: model
            ))
        }
        
        return result
    }
}
