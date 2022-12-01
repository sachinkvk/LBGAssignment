//
//  ViewControllersTests.swift
//  LBGAssignmentTests
//
//  Created by Sachin Panigrahi on 24/11/22.
//

import XCTest
@testable import LBGAssignment

final class ViewControllersTests: XCTestCase {
    var products: [Product] = []
    var viewController: ProductListViewController?

    override func setUpWithError() throws {
        products = MockProduct.getProducts()
        viewController = ProductListViewController.instantiate(appStoryboard: .main) as? ProductListViewController
        viewController?.loadView()
    }

    override func tearDownWithError() throws {
        viewController = nil
        products = []
    }

    func testProductListViewControllerIfLoaded() {
        XCTAssertNotNil(viewController?.viewDidLoad())
    }

    func testActionSheetTaps() {
        XCTAssertNotNil(viewController?.prepareActionSheetDataSource())
        XCTAssertNotNil(viewController?.handleSheetAction(sortOrder: SortOptions.highToLow.rawValue))
        XCTAssertNotNil(viewController?.handleSheetAction(sortOrder: SortOptions.lowToHigh.rawValue))
        XCTAssertNotNil(viewController?.handleSheetAction(sortOrder: "Cancel"))
    }

    func testProductListCollectionViewPresent() {
        XCTAssertNotNil(viewController?.productListCollectionView, "Collection view is present")
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

    func testReloadProducts() {
        XCTAssertNotNil(viewController?.reloadProducts())
    }

    func testShowViewsBasedOnConnectivity() {
        XCTAssertNotNil(viewController?.showViewsBasedOnConnectivity())
    }

    func testRetryButtonTapped() {
        if let viewController = viewController {
            XCTAssertNotNil(viewController.retryTapped(viewController.self))
        }
    }

    func testProductDetailsIfLoaded() {
        let viewController = ProductDetailsViewController.instantiate(appStoryboard: .main)
        guard let productDetailsVC = viewController as? ProductDetailsViewController else { return }
        productDetailsVC.loadView()
        XCTAssertNotNil(productDetailsVC.viewDidLoad())
    }

}
