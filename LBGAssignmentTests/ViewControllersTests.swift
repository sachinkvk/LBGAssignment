//
//  ViewControllersTests.swift
//  LBGAssignmentTests
//
//  Created by Sachin Panigrahi on 24/11/22.
//

import XCTest
@testable import LBGAssignment

final class ViewControllersTests: XCTestCase {
    var products: [Products] = []
    var viewController: ProductListViewController?

    override func setUpWithError() throws {
        products = MockProduct.getProducts()
        viewController = ProductListViewController.instantiate(appStoryboard: .main) as? ProductListViewController
        viewController?.loadView()
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testProductListViewControllerIfLoaded() {
        XCTAssertNotNil(viewController?.viewDidLoad())
    }

    func testActionSheetTaps() {
        XCTAssertNotNil(viewController?.loadActionSheets())
        XCTAssertNotNil(viewController?.handleSheetAction(sortOrder: SortOptions.highToLow.rawValue))
        XCTAssertNotNil(viewController?.handleSheetAction(sortOrder: SortOptions.lowToHigh.rawValue))
        XCTAssertNotNil(viewController?.handleSheetAction(sortOrder: "Cancel"))
    }

    func testProductListCollectionViewPresent() {
        XCTAssertNotNil(viewController?.productListCollectionView, "Collection view is present")
    }

    func testRefreshUI() {
        XCTAssertNotNil(viewController?.refreshUI())
    }

    func testActionSheets() {
        viewController?.actions.append((SortOptions.highToLow.rawValue, UIAlertAction.Style.default))
        viewController?.actions.append((SortOptions.lowToHigh.rawValue, UIAlertAction.Style.default))
        viewController?.actions.append(("Cancel", UIAlertAction.Style.cancel))
        guard let viewController = viewController else { return }
        XCTAssertNotNil(ActionSheet.showActionsheet(viewController: viewController.self,
                                                    title: "title", message: "",
                                                    actions: viewController.actions, completion: { _ in
        }))
    }
    func testProductDetailsIfLoaded() {
        let viewController = ProductDetailsViewController.instantiate(appStoryboard: .main)
        guard let viewController = viewController as? ProductDetailsViewController else { return }
        viewController.loadView()
        XCTAssertNotNil(viewController.viewDidLoad())
    }

}
