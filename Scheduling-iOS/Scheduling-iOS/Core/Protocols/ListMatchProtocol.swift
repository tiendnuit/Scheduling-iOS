//
//  ListMatchProtocol.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 12/02/2021.
//

import Foundation
protocol ListMatchProtocol: class {
    var items: [MatchCellViewModel] {get}
    func numberOfItems() -> Int
    func item(at indexPath: IndexPath) -> MatchCellViewModel?
    func itemSelected(at: IndexPath)
}

extension ListMatchProtocol {
    func numberOfItems() -> Int {
        return items.count
    }
    
    func item(at indexPath: IndexPath) -> MatchCellViewModel? {
        guard indexPath.row < items.count else { return nil }
        return items[indexPath.row]
    }
    
    func itemSelected(at indexPath: IndexPath) {
        // selected Item
    }
}
