//
//  PoolTest.swift
//  Scheduling-iOSTests
//
//  Created by Scor Doan on 23/02/2021.
//

import Foundation
import XCTest
@testable import Scheduling_iOS

class PoolTest: XCTestCase {
    var pool: Pool!
    
    override func setUp() {
        pool = Pool(name: "Test", teamSize: 8)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_matches_from_same_pool_teamSize_8() {

        //Given
        let numOfMatches = 28 // 7*8/2
        
        //When
        let matches = pool.matchesFromSamePool()

        //Then
        XCTAssert(matches.count == numOfMatches)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

