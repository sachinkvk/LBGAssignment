//
//  ViewControllersTests.swift
//  LBGAssignmentTests
//
//  Created by Sachin Panigrahi on 24/11/22.
//

import XCTest
@testable import LBGAssignment

final class ViewControllersTests: XCTestCase {
    var product: ProductViewModel!
    var products: [Products] = []
    var viewController: ProductListViewController?
    
    override func setUpWithError() throws {
        products = MockProduct.getProducts()
        viewController = ProductListViewController.instantiate(appStoryboard: .main) as? ProductListViewController
        viewController?.loadView()
    }

    override func tearDownWithError() throws {
        viewController = nil
        product = nil
    }
    
    func testProductListViewControllerIfLoaded() {
        XCTAssertNotNil(viewController?.viewDidLoad())
    }
    
    func testActionSheetTaps() {
        XCTAssertNotNil(viewController?.loadActionSheets())
        XCTAssertNotNil(viewController?.handleSheetAction(type: .HighToLow))
        XCTAssertNotNil(viewController?.handleSheetAction(type: .lowToHigh))
        XCTAssertNotNil(viewController?.handleSheetAction(type: .Cancel))
    }
    
    func testActionSheetSource() {
        viewController?.actions.append((SortingTypes.HighToLow.rawValue, UIAlertAction.Style.default, .HighToLow))
        viewController?.actions.append((SortingTypes.lowToHigh.rawValue, UIAlertAction.Style.default, .lowToHigh))
        viewController?.actions.append((SortingTypes.Cancel.rawValue, UIAlertAction.Style.cancel, .Cancel))
    }
    
    func testProductListCollectionViewPresent() {
        XCTAssertNotNil(viewController?.productListCollectionView, "Collection view is present")
    }
    
    func testProductDetailsIfLoaded() {
        guard let viewController = ProductDetailsViewController.instantiate(appStoryboard: .main) as? ProductDetailsViewController else { return }
        viewController.loadView()
        XCTAssertNotNil(viewController.viewDidLoad())
    }

}
