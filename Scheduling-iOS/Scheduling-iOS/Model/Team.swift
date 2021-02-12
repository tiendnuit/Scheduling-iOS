//
//  Team.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation

struct Team {
    let name: String
    var numOfMatches: Int = 0
    
    func updateName(_ name: String) -> Team {
        return Team(name: name, numOfMatches: numOfMatches)
    }
    
    func updateMatchCount(_ count: Int) -> Team {
        return Team(name: name, numOfMatches: numOfMatches + count)
    }
    
    func reset() -> Team {
        return Team(name: name)
    }
}

extension Team: TeamPresenter {
    var nameText: String {
        return name
    }
}

extension Team: Equatable {
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.name == rhs.name
    }
}
