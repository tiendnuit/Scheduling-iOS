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

    func test_match_dayString() {

        //Given
        let randomMatch = viewModel.items.randomElement()!
        let dayString = "Day \(randomMatch.day!) Game \(randomMatch.game!):"
        
        //When
        

        //Then
        XCTAssert(randomMatch.dayString == dayString)
    }
    
    func test_matchCell_isEven() {

        //Given
        let firstMatch = viewModel.items.first
        let isEvenIndex = false
        
        //When
        

        //Then
        XCTAssert(firstMatch?.isEvenIndex == isEvenIndex)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

