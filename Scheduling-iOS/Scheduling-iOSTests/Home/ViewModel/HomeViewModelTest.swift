//
//  HomeViewModelTest.swift
//  Scheduling-iOSTests
//
//  Created by Scor Doan on 11/02/2021.
//

import XCTest
@testable import Scheduling_iOS

class HomeViewModelTest: XCTestCase {
    var viewModel: HomeViewModel!
    
    override func setUp() {
        viewModel = HomeViewModel()
        viewModel.updatePools(size: 4, teamSize: 4)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_update_poolSize_4_teamSize_8() {
        //Given
        let poolSize = 4
        let teamSize = 8
        
        //When
        viewModel.updatePools(size: poolSize, teamSize: teamSize)
        
        
        //Then
        XCTAssert(viewModel.pools.count != 0)
        XCTAssert(viewModel.pools.count == poolSize)
        XCTAssert(viewModel.pools.first!.teams.count == teamSize)
    }
    
    func test_update_poolName_success() {
        //Given
        let name = "Pool A"
        
        //When
        viewModel.editPoolName(name, at: 1)
        
        //Then
        XCTAssert(viewModel.pools[1].name == name)
    }
    
    func test_update_existedPoolName() {
        //Given
        let name = "Pool A"
        
        //When
        viewModel.editPoolName(name, at: 1)
        viewModel.editPoolName(name, at: 2)
        
        //Then
        XCTAssert(viewModel.pools[1].name == name)
        XCTAssert(viewModel.pools[2].name != name)
    }
    
    func test_update_teamName_success() {
        //Given
        let name = "Team A"
        let poolIndex = 0
        let teamIndex = 1
        
        //When
        viewModel.editTeamName(name, at: IndexPath(row: teamIndex, section: poolIndex))
        
        //Then
        XCTAssert(viewModel.pools[poolIndex].teams[teamIndex].name == name)
    }
    
    func test_update_existedTeamName_inSamePool() {
        //Given
        let name = "Team A"
        let poolIndex = 0
        let team1Index = 1
        let team2Index = 2
        
        //When
        viewModel.editTeamName(name, at: IndexPath(row: team1Index, section: poolIndex))
        viewModel.editTeamName(name, at: IndexPath(row: team2Index, section: poolIndex))
        
        //Then
        XCTAssert(viewModel.pools[poolIndex].teams[team1Index].name == name)
        XCTAssert(viewModel.pools[poolIndex].teams[team2Index].name != name)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

