import XCTest
@testable import CocktailBook

class CocktailBookTests: XCTestCase {

    let model = CocktailBookListViewModel()
    
    override func setUpWithError() throws {
        model.fetchCocktails()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testAPI() {
        let expectation = XCTestExpectation(description: "sampleJson")
        model.cocktailsAPI.fetchCocktails { result in
            if case let .success(data) = result {
                XCTAssertNotNil(data)
                expectation.fulfill()
            } else if case let .failure(error) = result {
                XCTFail("Error fetching cocktails: \(error)")
            }
        }
    }
    
    func testApplyFilter() {
        XCTAssertNotNil(model.applyFilter(.all))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
