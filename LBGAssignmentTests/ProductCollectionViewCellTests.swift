//
//  ProductCollectionViewCellTests.swift
//  LBGAssignmentTests
//
//  Created by Sachin Panigrahi on 24/11/22.
//

import XCTest
@testable import LBGAssignment

class ProductCollectionViewCellTests: XCTestCase {

    var subject: ProductCollectionViewCell!
    var productRating: UILabel!
    var productPrice: UILabel!
    var productName: UILabel!
    var productImageView: UIImageView!
    var containerView: UIView!
    var products: [Products] = []
    var product: ProductViewModel!
    
    override func setUp() {
       super.setUp()
        subject = ProductCollectionViewCell()
        productRating = UILabel()
        productPrice = UILabel()
        productName = UILabel()
        productImageView = UIImageView()
        containerView = UIView()
        
        subject.setValue(productRating, forKey: "productRating")
        subject.setValue(productPrice, forKey: "productPrice")
        subject.setValue(productName, forKey: "productName")
        subject.setValue(productImageView, forKey: "productImageView")
        subject.setValue(containerView, forKey: "containerView")
        product = ProductViewModel(imageName: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                                       title: "Mens Casual Premium Slim Fit T-Shirts ",
                                       desc: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                                       price: 134,
                                       rating: 4.1,
                                       category: "men's clothing")
        subject.productViewModel = product
        
        products = [Products(id: 1, title: "Title", price: 23, description: "description", category: "category",
                             image: "image", rating: Rating(rate: 12, count: 12))]
    }

    override func tearDown() {
        productRating = nil
        productName = nil
        productPrice = nil
        productImageView = nil
        subject = nil
        super.tearDown()
    }

    func test_awakeFromNib_setExpectedValues() {
        subject.awakeFromNib()
        XCTAssertNotNil(productRating.text)
        XCTAssertNotNil(productPrice.text)
        XCTAssertNotNil(productName.text)
    }
    
    func testThatServiceIsCalled() {
        guard let vc = ProductDetailsViewController.instantiate(appStoryboard: .main) as? ProductDetailsViewController else { return }
        vc.loadView()
        XCTAssertNotNil(vc.viewDidLoad())
    }
    
    func testProductListViewController() {
        guard let vc = ProductListViewController.instantiate(appStoryboard: .main) as? ProductListViewController else { return }
        vc.loadView()
        XCTAssertNotNil(vc.viewDidLoad())
        
        let enumString = ServiceError.decode
        XCTAssertNotNil(enumString.message)
        
        XCTAssertNotNil(vc.productListCollectionView, "Collection view is present")
        vc.viewModel = ProductListViewModel()
        vc.viewModel.products = [product]
        
        vc.actions.append((SortingList.HighToLow.rawValue, UIAlertAction.Style.default, .HighToLow))
        vc.actions.append((SortingList.lowToHigh.rawValue, UIAlertAction.Style.default, .lowToHigh))
        vc.actions.append((SortingList.Cancel.rawValue, UIAlertAction.Style.cancel, .Cancel))
        XCTAssertNotNil(vc.loadActionSheets())
        XCTAssertNotNil(vc.handleSheetAction(type: .HighToLow))
        XCTAssertNotNil(vc.handleSheetAction(type: .lowToHigh))
        XCTAssertNotNil(vc.handleSheetAction(type: .Cancel))

        XCTAssertNotNil(vc.refresh(vc.self))
    }
}
