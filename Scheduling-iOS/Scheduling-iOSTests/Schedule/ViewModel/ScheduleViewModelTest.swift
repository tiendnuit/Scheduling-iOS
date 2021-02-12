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
        homeVM.updatePools(size: 4, teamSize: 4)
        viewModel = ScheduleViewModel(pools: homeVM.pools)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_update_poolSize_4_teamSize_8() {

//        //Given
//        let poolSize = 4
//        let teamSize = 8
//
//        //When
//        viewModel.updatePools(size: poolSize, teamSize: teamSize)
//
//
//        //Then
//        XCTAssert(viewModel.pools.count != 0)
//        XCTAssert(viewModel.pools.count == poolSize)
//        XCTAssert(viewModel.pools.first!.teams.count == teamSize)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

