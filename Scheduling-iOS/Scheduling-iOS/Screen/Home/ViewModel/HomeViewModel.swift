//
//  HomeViewModel.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation
import Combine

class HomeViewModel {
    @Published private(set) var pools: [Pool] = []
    @Published private(set) var reload = false
    @Published private(set) var alertMessage = ""
    
    internal var bindings = Set<AnyCancellable>()
    fileprivate var expanded: [Bool] = []
    init() {
        
    }
    
    func updatePools(size: Int, teamSize: Int) {
        pools = (1...size).map{Pool(name: "Pool \($0)", teamSize: teamSize)}
        expanded = Array(repeating: false, count: size)
        reload = true
    }
    
    func editPoolName(_ name: String, at section: Int) {
        let notExisted = pools.filter{$0.name == name}.isEmpty
        guard notExisted else {
            alertMessage = "This name already exists!"
            return
        }
        pools[section].name = name
        reload = true
    }
    
    func editTeamName(_ name: String, at indexPath: IndexPath) {
        let pool = pools[indexPath.section]
        let notExisted = pool.teams.filter{$0.name == name}.isEmpty
        //Make sure this name not exists in the pool
        guard notExisted else {
            alertMessage = "This name already exists!"
            return
        }
        pool.updateTeamName(name, at: indexPath.row)
        reload = true
    }
}

extension HomeViewModel: ListPoolProtocol {
    var sections: [PoolSection] {
        return pools.enumerated().map{PoolSection(header:$1.name, items: expanded[$0] ? $1.teams : [])}
    }
    
    func expandeSection(at section: Int) {
        expanded[section] = !expanded[section]
        reload = true
    }
    
    func isExpandedSection(at section: Int) -> Bool {
        return expanded[section]
    }
    
    func editSectionName(_ name: String, at section: Int) {
        editPoolName(name, at: section)
    }
    
    func editRowName(_ name: String, at indexPath: IndexPath) {
        editTeamName(name, at: indexPath)
    }
}
