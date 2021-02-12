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
    var randomTeam: Team? {
        return teams.randomElement()
    }
    
    var randomTeamIndex: Int? {
        return (0..<teams.count).randomElement()
    }
    
    init(name: String, teamSize: Int) {
        self.name = name
        teams = (1...teamSize).map{Team(name: "Team \($0)")}
    }
    
    func updateTeamName(_ name: String, at index: Int) {
        teams[index] = teams[index].updateName(name)
    }
    
    func matchesFromSamePool() -> [Match] {
        var results = [Match]()
        //Get Match from each of Team
        for team in teams {
            let matches = teams.compactMap {
                return $0 == team ? nil : Match(leftPool: self, leftTeam: team, rightTeam: $0, rightPool: self)
            }
            results.append(contentsOf: matches)
        }
        //Update number of matches in same pool = teams.count
        teams = teams.map{$0.updateMatchCount(teams.count-1)}
        
        return results
    }
    
    func matchesFromOpponentPool(_ pool: Pool) -> [Match] {
        var results = [Match]()
        for team in teams {
            if team.numOfMatches < teams.count,
               let randomTeamIndex = pool.randomTeamIndex {
                //Update match Count of team from opponent pool
                pool.teams[randomTeamIndex] = pool.teams[randomTeamIndex].updateMatchCount(1)
                results.append(Match(leftPool: self, leftTeam: team,
                                     rightTeam: pool.teams[randomTeamIndex], rightPool: pool))
            }
        }
        teams = teams.map { $0.numOfMatches < teams.count ? $0.updateMatchCount(1) : $0 }
        return results
    }
    
}

extension Pool: Equatable {
    static func == (lhs: Pool, rhs: Pool) -> Bool {
        return lhs.name == rhs.name
    }
}
