//
//  MatchCellViewModelTest.swift
//  Scheduling-iOSTests
//
//  Created by Scor Doan on 12/02/2021.
//

import Foundation
import XCTest
@testable import Scheduling_iOS

class MatchCellViewModelTest: XCTestCase {
    var viewModel: ScheduleViewModel!
    
    override func setUp() {
        let homeVM = HomeViewModel()
        homeVM.updatePools(size: 4, teamSize:8)
        viewModel = ScheduleViewModel(pools: homeVM.pools)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_calculate_schedule_poolSize_4_teamSize_8() {

        //Given
        let randomMatch = viewModel.items.randomElement()!
        let matchString = "Day \(randomMatch.day!) Game \(randomMatch.game!): \(randomMatch.match.leftTeamNameText) vs \(randomMatch.match.rightTeamNameText)"
        
        //When
        

        //Then
        XCTAssert(randomMatch.matchString == matchString)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

