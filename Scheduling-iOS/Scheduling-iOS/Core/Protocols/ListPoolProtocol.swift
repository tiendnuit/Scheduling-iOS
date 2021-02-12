//
//  ListPoolProtocol.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation

protocol ListPoolProtocol: class {
    var sections: [PoolSection] { get }
    func numberOfItems(at section: Int) -> Int
    func numberOfSections() -> Int
    func item(at indexPath: IndexPath) -> Team?
    func itemSelected(at: IndexPath)
    func titleForHeader(_ at: Int) -> String
    func expandeSection(at section: Int)
    func isExpandedSection(at section: Int) -> Bool
    func editSectionName(_ name: String, at section: Int)
    func editRowName(_ name: String, at indexPath: IndexPath)
}


extension ListPoolProtocol {
    func numberOfItems(at section: Int) -> Int {
        guard section < sections.count else {
            return 0
        }
        
        return sections[section].items.count
    }
    
    func numberOfSections() -> Int {
        sections.count
    }
    
    func item(at indexPath: IndexPath) -> Team? {
        guard indexPath.section < sections.count,
              indexPath.row < sections[indexPath.section].items.count else {
            return nil
        }
        
        return sections[indexPath.section].items[indexPath.row]
    }
    
    func itemSelected(at: IndexPath) {
        guard let item = item(at: at) else { return }
    }
    
    func titleForHeader(_ at: Int) -> String {
        sections[at].header
    }
}
