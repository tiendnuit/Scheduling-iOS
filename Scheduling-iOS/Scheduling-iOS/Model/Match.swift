//
//  Match.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation

struct Match {
    let leftPool: Pool
    let leftTeam: Team
    let rightTeam: Team
    let rightPool: Pool
}

extension Match: MatchPresenter {
    var leftTeamNameText: String {
        return leftPool.name + " - " + leftTeam.name
    }
    
    var rightTeamNameText: String {
        return rightPool.name + " - " + rightTeam.name
    }
    
    
}
