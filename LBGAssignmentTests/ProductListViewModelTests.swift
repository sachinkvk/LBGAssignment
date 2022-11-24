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
    var products: [Product] = []
    var urlSession: URLSession = URLSession.init(configuration: .default)

    override func setUpWithError() throws {
        urlSession = URLSession.init(configuration: MockResponse.getSessionConfiguration())
        sut = ProductListViewModel()
        products = MockProduct.getProducts()
        WebService.urlSession = urlSession
    }

    override func tearDownWithError() throws {
        sut = nil
        products = []
    }

    func testScreenTitle() throws {
        XCTAssertEqual(sut.screenTitle, "Products")
    }

    func testCancelText() throws {
        XCTAssertEqual(sut.cancelText, "Cancel")
    }

    func testPriceText() throws {
        XCTAssertEqual(sut.priceText, "Price")
    }

    func testProductListApiSuccess() {
        let mockedData = Utility.readJSONFrom(fileName: "ProductList") as? [[String: Any]] ?? [[:]]
        MockResponse.setMock(response: mockedData,
                                     requestUrl: MockResponse.getMockUrl(),
                                     statusCode: 200)
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

    func testProductListApiFailure() {
        MockResponse.setMock(response: [[:]],
                                     requestUrl: MockResponse.getMockUrl(),
                                     statusCode: 400)
        let expectation = self.expectation(description: "Failure")
        sut.fetchProducts {  result in
                switch result {
                case .success(let response):
                    XCTAssertEqual(response.count, 20)
                case .failure(let error):
                    XCTAssertEqual(error, ServiceError.badStatusCode)
                }
                expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testProductListApiUnauthorized() {
        MockResponse.setMock(response: [[:]],
                                     requestUrl: MockResponse.getMockUrl(),
                                     statusCode: 401)
        let expectation = self.expectation(description: "Failure")
        sut.fetchProducts {  result in
                switch result {
                case .success(let response):
                    XCTAssertEqual(response.count, 20)
                case .failure(let error):
                    XCTAssertEqual(error, ServiceError.unauthorized)
                }
                expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testProductList() {
        sut.productsCopy = sut.products
        XCTAssertNotNil(sut.products)
        sut.isSortingApplied = true
        XCTAssertNotNil(sut.productsCopy)
    }

    func testSortBy() {
        XCTAssertNotNil(sut.sortBy(order: .lowToHigh))
        XCTAssertNotNil(sut.sortBy(order: .highToLow))
    }

    func testServieError() {
        let enumString = ServiceError.decode
        XCTAssertNotNil(enumString.message)
    }
}
