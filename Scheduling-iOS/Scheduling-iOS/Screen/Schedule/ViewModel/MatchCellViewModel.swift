//
//  MatchCellViewModel.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 12/02/2021.
//

import Foundation

class MatchCellViewModel {
    var match: Match!
    var day: Int!
    var game: Int!
    
    init(match: Match, day: Int, game: Int) {
        self.match = match
        self.day = day
        self.game = game
    }
    
    var matchString: String {
        return "Day \(day!) Game \(game!): \(match.leftTeamNameText) vs \(match.rightTeamNameText)"
    }
}
