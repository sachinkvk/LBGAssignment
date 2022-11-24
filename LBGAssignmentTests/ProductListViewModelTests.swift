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
    var products: [Products] = []
    var urlSession: URLSession = URLSession.init(configuration: .default)
    
    override func setUpWithError() throws {
        urlSession = URLSession.init(configuration: MockResponse.getSessionConfiguration())
        sut = ProductListViewModel(urlSession: urlSession)
        products = MockProduct.getProducts()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        products = []
    }

    func testScreenTitle() throws {
        XCTAssertEqual(sut.screenTitle, "Products")
    }
    
    func fetchProducts(session: URLSession = URLSession(configuration: .default),
                       _ completion: @escaping (Result<[Products], ServiceError>) -> Void) {
        Task {
            let result = await WebService.sharedInstance.fetch(with: RequestTypes.allProducts.request,
                                                               decodingType: [Products].self,
                                                               session: urlSession)
            completion(result)
        }
    }
    
    func testProductListApiSuccess() {
        let mockedData = AppConstant.readJSONFrom(fileName: "ProductList") as? [[String: Any]] ?? [[:]]
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
                                     statusCode: 401)
        let expectation = self.expectation(description: "Success")
        sut.fetchProducts {  result in
                switch result {
                case .success(let response):
                    XCTAssertEqual(response.count, 20)
                case .failure(let error):
                    XCTAssertEqual(error, ServiceError.unexpectedStatusCode)
                }
                expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testTranslateProducts() {
        XCTAssertNotNil(sut.translateProducts(products))
    }
    
    func testProductList() {
        sut.translateProducts(products)
        sut.productsCopy = sut.products
        XCTAssertNotNil(sut.products)
        sut.isSortingApplied = true
        XCTAssertNotNil(sut.productsCopy)
    }
    
    func testSortBy() {
        XCTAssertNotNil(sut.sortBy(order: .lowToHigh))
        XCTAssertNotNil(sut.sortBy(order: .HighToLow))
    }
    
    func testServieError() {
        let enumString = ServiceError.decode
        XCTAssertNotNil(enumString.message)
    }
    
}
