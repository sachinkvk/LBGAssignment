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
        sut = ProductListViewModel()
        
        urlSession = URLSession.init(configuration: MockResponse.getSessionConfiguration())
        products = [Products(id: 1, title: "Title", price: 23, description: "description", category: "category",
                             image: "image", rating: Rating(rate: 12, count: 12))]
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
        let mockedData = AppConstant.readJSONFromFile(fileName: "ProductList") as? [[String: Any]] ?? [[:]]
        MockResponse.setMock(response: mockedData,
                                     requestUrl: MockResponse.getMockUrl(),
                                     statusCode: 200)
        let expectation = self.expectation(description: "Success")
        fetchProducts(session: urlSession) {  result in
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
        fetchProducts(session: urlSession) {  result in
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
        XCTAssertNotNil(sut.sortBy(order: .Cancel))
    }
    
}
