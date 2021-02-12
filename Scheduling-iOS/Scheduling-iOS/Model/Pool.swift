//
//  Pool.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation

class Pool {
    var name: String
    var teams: [Team] = []
    
    init(name: String, teamSize: Int) {
        self.name = name
        teams = (1...teamSize).map{Team(name: "Team \($0)")}
    }
    
    func updateTeamName(_ name: String, at index: Int) {
        teams[index] = teams[index].updateName(name)
    }
}
