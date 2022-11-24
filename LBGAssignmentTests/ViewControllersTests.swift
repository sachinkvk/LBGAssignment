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
        XCTAssertNotNil(viewController?.handleSheetAction(sortOrder: SortingTypes.HighToLow.rawValue))
        XCTAssertNotNil(viewController?.handleSheetAction(sortOrder: SortingTypes.lowToHigh.rawValue))
        XCTAssertNotNil(viewController?.handleSheetAction(sortOrder: "Cancel"))
    }
    
    func testActionSheetSource() {
        viewController?.actions.append((SortingTypes.HighToLow.rawValue, UIAlertAction.Style.default))
        viewController?.actions.append((SortingTypes.lowToHigh.rawValue, UIAlertAction.Style.default))
        viewController?.actions.append(("Cancel", UIAlertAction.Style.cancel))
    }
    
    func testProductListCollectionViewPresent() {
        XCTAssertNotNil(viewController?.productListCollectionView, "Collection view is present")
    }
    
    func testRefreshUI() {
        XCTAssertNotNil(viewController?.refreshUI())
    }
    
    func testActionSheets() {
        viewController?.actions.append((SortingTypes.HighToLow.rawValue, UIAlertAction.Style.default))
        viewController?.actions.append((SortingTypes.lowToHigh.rawValue, UIAlertAction.Style.default))
        viewController?.actions.append(("Cancel", UIAlertAction.Style.cancel))
        guard let viewController = viewController else { return }
        XCTAssertNotNil(ActionSheet.showActionsheet(viewController: viewController.self,
                                                    title: "title", message: "",
                                                    actions: viewController.actions, completion: { sortOrder in
            
        }))
    }
    
    func testProductDetailsIfLoaded() {
        guard let viewController = ProductDetailsViewController.instantiate(appStoryboard: .main) as? ProductDetailsViewController else { return }
        viewController.loadView()
        XCTAssertNotNil(viewController.viewDidLoad())
    }

}
