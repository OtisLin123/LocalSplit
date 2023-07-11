//
//  CellProtocol.swift
//  FirstWithoutStoryBoard
//
//  Created by CI-Otis.Lin on 2023/7/10.
//

import Foundation

protocol MemberCellDelegate: AnyObject {
    func didDeleteTap(_ indexPath: IndexPath)
}
