# Scheduling-iOS!

An example of MVVM-C + POP + UIKit + Combine show plan weekend schedule for an input pools(Pool A, Pool B, Pool C and Pool D) of teams.


# Key Features
-  Using **Swift** + **MVVM-C** + **UIKit** + **Combine** + **POP**
-  Show plan weekend schedule for an input pools(Pool A, Pool B, Pool C and Pool D) of teams.
-  Make UI with programmatically.
-  Light & dark mode compatible.
-  No third-party libraries.
-  Unit test


## Requirements
-   iOS 13.0+
-   Xcode 12.2

## Architecture
Using MVVM-C pattern gives us some benefits like code reuse, ease of testing, bindings make UI updates easier to handle, ease of maintainability.

And splitting off protocols (DataSource and Delegate) into separate objects we can re-use those objects in other view controllers, or use different objects in the same view controller to get different behavior at runtime.
<a href="https://drive.google.com/uc?export=view&id=1KanVgWCzLd4697tTyixRY7QW6j0kITWu"><img src="https://drive.google.com/uc?export=view&id=1KanVgWCzLd4697tTyixRY7QW6j0kITWu" style="width: 650px; max-width: 100%; height: auto" title="Click to enlarge picture" />

## Unit Test

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
    
## Next Features
- Make UI with SwiftUI

## Author
Tommy Doan, [tiendnuit@gmail.com](mailto:tiendnuit@gmail.com) or [tommy.doan2710@gmail.com](mailto:tommy.doan2710@gmail.com)
