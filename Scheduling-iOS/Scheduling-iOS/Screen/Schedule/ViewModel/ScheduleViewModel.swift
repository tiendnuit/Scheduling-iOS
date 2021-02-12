//
//  ScheduleViewModel.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation
import Combine

class ScheduleViewModel {
    private let MATCH_PER_WEEK = 5
    @Published private(set) var matches: [Match] = []
    @Published private(set) var reload = false
    @Published private(set) var dismissed: Bool = false
    @Published private(set) var nextable: Bool = false  // Can go next
    @Published private(set) var preable: Bool = false   // Can go back
    @Published private(set) var currentWeek = 1
    
    fileprivate var bindings = Set<AnyCancellable>()
    fileprivate var expanded: [Bool] = []
    fileprivate var pools: [Pool] = []
    fileprivate var opponentsDict: [String: Pool] = [:]
    
    
    init(pools: [Pool]) {
        self.pools = pools
        calculate()
    }
    
    /// calculate to get schedule detail
    private func calculate() {
        //reset teams in each of pool
        pools.forEach {$0.reset()}
        //Random pick opponent for each pool
        pools = pools.shuffled()
        stride(from: 0, to: pools.count - 1, by: 2).forEach {
            opponentsDict[pools[$0].name] = pools[$0+1]
            opponentsDict[pools[$0+1].name] = pools[$0]
        }
        
        var numOfMatches = [Match]()
        for pool in pools {
            //Add matches from same pool
            numOfMatches.append(contentsOf: pool.matchesFromSamePool())
            if let opponentPool = opponentsDict[pool.name] {
                numOfMatches.append(contentsOf: pool.matchesFromOpponentPool(opponentPool))
            }
        }
        
        matches = numOfMatches.shuffled()
        updateWeekButtonsStatus()
    }
    
    private func updateWeekButtonsStatus() {
        let totalWeeks = Int(ceil(Float(matches.count) / Float(MATCH_PER_WEEK)))
        nextable = currentWeek < totalWeeks - 1
        preable = currentWeek > 1
    }
    
    func dismiss() {
        dismissed = true
    }
    
    func goNext() {
        currentWeek += 1
        updateWeekButtonsStatus()
    }
    
    func goBack() {
        currentWeek -= 1
        updateWeekButtonsStatus()
    }
    
}

extension ScheduleViewModel: ListMatchProtocol {
    var items: [MatchCellViewModel] {
        let fromIdx = (currentWeek-1)*MATCH_PER_WEEK
        let toIdx = min(fromIdx + MATCH_PER_WEEK, matches.count)
        return Array(matches[fromIdx..<toIdx]).enumerated().map{MatchCellViewModel(match: $1, day: $0/3+1, game: fromIdx+$0+1)}
    }
}
