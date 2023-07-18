//
//  SpandEditorViewModel.swift
//  FirstWithoutStoryBoard
//
//  Created by 林易德 on 2023/7/16.
//

import Foundation

protocol SpendEditorViewModelDelegate {
    func bindSplitDatasChanged() -> ()
}

class SpendEditorViewModel: NSObject {
    var delegate: SpendEditorViewModelDelegate?
    var spendData: SpendModel?
}

// MARK: - Public method
extension SpendEditorViewModel {
    func setData(_ data: SpendModel) {
        spendData = data
        setSplitDatas(data.people)
    }
    
    func setSplitDatas(_ datas: [SplitModel]) {
//        var currentSplitDatas = spendData?.people ?? []
//        for data in datas.reversed() {
//            let index = currentSplitDatas.firstIndex{ splitData in
//                data.id == splitData.id
//            }
//
//            if index == nil {
//                currentSplitDatas.append(data)
//            }
//            else {
//                currentSplitDatas[index!] = data
//            }
//        }
        spendData?.people = datas
        delegate?.bindSplitDatasChanged()
    }
    
    func setSplitData(_ data: SplitModel) {
        var currentSplitDatas = spendData?.people ?? []
        for (index, splitData) in currentSplitDatas.enumerated() {
            if splitData.id == data.id {
                currentSplitDatas[index] = data
                break
            }
        }
        spendData?.people = currentSplitDatas
        delegate?.bindSplitDatasChanged()
    }
    
    func getSplitModel(_ id: String) -> SplitModel? {
        let currentSplitDatas = spendData?.people ?? []
        for splitData in currentSplitDatas {
            if splitData.id == id {
                return splitData
            }
        }
        return nil
    }
    
    func updateSplitModel(_ splitModel: SplitModel) {
        var currentSplitDatas = spendData?.people ?? []
        for (index, splitData) in currentSplitDatas.enumerated() {
            if splitData.id == splitModel.id {
                currentSplitDatas[index] = splitModel
                break
            }
        }
        spendData?.people = currentSplitDatas
    }
    
    func getSplitorMemberItem() -> [MemberItem] {
        var memberItem: [MemberItem] = []
        MainModel.shard.members.forEach { member in
            let isSelected = spendData?.people.contains {
                person in
                person.id == member.id
            }
            memberItem.append(MemberItem(data: member, isSelected: isSelected ?? false))
        }
        return memberItem
    }
}
