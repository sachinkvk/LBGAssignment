//
//  ProductListViewModelTests.swift
//  LBGAssignmentTests
//
//  Created by Sachin Panigrahi on 23/11/22.
//

import XCTest
@testable import LBGAssignment

final class ProductListViewModelTests: XCTestCase {

    var sut: ProductListViewModel!
    
    override func setUpWithError() throws {
        sut = ProductListViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testScreenTitle() throws {
        XCTAssertEqual(sut.screenTitle, "Products")
    }
    
    func testPullToRefreshText() throws {
        XCTAssertEqual(sut.pullToRefreshText, "Pull to refresh")
    }
    
    func testProductListApiSuccess() {
//        let mockedData = readJSONFromFile(fileName: "ProductList") as? [String: Any] ?? [:]
//        DataMocker.setMockedData(mockData: mockedData,
//                                     requestUrl: DataMocker.getServerUrl(),
//                                     statusCode: 200)
        let expectation = self.expectation(description: "Success")
        sut.fetchProducts {  result in
                switch result {
                case .success(let response):
                    XCTAssertEqual(response.count, 20)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func readJSONFromFile(fileName: String) -> Any? {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                print("parse error: \(error.localizedDescription)")
            }
        }
        return json
    }
}
