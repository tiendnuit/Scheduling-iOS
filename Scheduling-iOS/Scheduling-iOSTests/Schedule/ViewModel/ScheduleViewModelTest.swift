//
//  ScheduleViewModelTest.swift
//  Scheduling-iOSTests
//
//  Created by Scor Doan on 12/02/2021.
//

import Foundation
import XCTest
@testable import Scheduling_iOS

class ScheduleViewModelTest: XCTestCase {
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
        let poolSize = 4
        let teamSize = 8
        let minMatch = 8
        let minTotalMatch = teamSize/2 * minMatch
        let homeVM = HomeViewModel()
        homeVM.updatePools(size: poolSize, teamSize:teamSize)
        
        //When
        viewModel = ScheduleViewModel(pools: homeVM.pools)

        //Then
        XCTAssert(homeVM.pools.first!.teams.filter{$0.numOfMatches < minMatch}.count == 0)
        XCTAssert(viewModel.matches.count >= minTotalMatch)
    }
    
    func test_goNext() {

        //Given
        let currentWeek = viewModel.currentWeek

        //When
        viewModel.goNext()

        //Then
        XCTAssert(viewModel.currentWeek == currentWeek + 1)
        XCTAssert(viewModel.items.count > 0 && viewModel.items.count <= 5)
    }
    
    func test_goPre() {

        //Given
        viewModel.goNext()
        let currentWeek = viewModel.currentWeek
        
        //When
        viewModel.goBack()

        //Then
        XCTAssert(viewModel.currentWeek == currentWeek - 1)
        XCTAssert(viewModel.items.count > 0 && viewModel.items.count <= 5)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

