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
        datas.forEach { data in
            let index = spendDatas.firstIndex { spendModel in
                spendModel.id == data.id
            }
            if index != nil {
                spendDatas[index!] = data
            }
            else {
                spendDatas.append(data)
            }
        }
    }
    
    func setSpendData(_ data: SpendModel) {
        let index = spendDatas.firstIndex { spendModel in
            spendModel.id == data.id
        }
        if index != nil {
            spendDatas[index!] = data
        }
        else {
            spendDatas.append(data)
        }
    }
    
    func removeSpendData(_ id: String) {
        let index = spendDatas.firstIndex { spendModel in
            spendModel.id == id
        }
        if index != nil {
            spendDatas.remove(at: index!)
        }
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
    
    func getSpendData(_ id: String) -> SpendModel? {
        for data in spendDatas {
            if data.id == id {
                return data
            }
        }
        return nil
    }
}
