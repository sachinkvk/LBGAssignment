//
//  ProductListViewController.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak private var sortView: UIView!
    @IBOutlet weak private var retryView: UIView!
    @IBOutlet weak var productListCollectionView: UICollectionView!

    private let cellIdentifier = ProductCollectionViewCell.reuseIdentifier
    var actions: [(String, UIAlertAction.Style)] = []
    weak var coordinator: MainCoordinator?

    var viewModel = ProductListViewModel()

    private var shouldShowCollectionView: Bool = true {
        didSet {
            DispatchQueue.main.async {
                self.productListCollectionView.isHidden = !self.shouldShowCollectionView
                self.sortView.isHidden = !self.shouldShowCollectionView
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        productListCollectionView.register(UINib(nibName: cellIdentifier,
                                                 bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        prepareActionSheetDataSource()
        self.title = viewModel.screenTitle
        self.view.showLoader()
        showViewsBasedOnConnectivity()
    }

    func prepareActionSheetDataSource() {
        actions.append((SortOptions.highToLow.rawValue, UIAlertAction.Style.default))
        actions.append((SortOptions.lowToHigh.rawValue, UIAlertAction.Style.default))
        actions.append((viewModel.cancelText, UIAlertAction.Style.cancel))
    }

    @IBAction func sortButtonTapped(_ sender: Any) {
        ActionSheet.showActionsheet(viewController: self, title: viewModel.priceText,
                                    message: "", actions: actions) { [weak self] sortOrder in
            self?.handleSheetAction(sortOrder: sortOrder)
        }
    }

    func handleSheetAction(sortOrder: String) {
        guard let order = SortOptions(rawValue: sortOrder) else { return }

        viewModel.isSortingApplied = true
        viewModel.productsCopy = self.viewModel.sortBy(order)
        reloadProducts()
    }

    func reloadProducts() {
        DispatchQueue.main.async {
            self.view.hideLoader()
            self.productListCollectionView.reloadData()
        }
    }

    func showViewsBasedOnConnectivity() {
        switch Reachability.isConnectedToNetwork() {
        case true:
            fetchProducts()
        case false:
            shouldShowCollectionView = false
            self.view.hideLoader()
        }
    }

    private func fetchProducts() {
        viewModel.fetchProducts { [weak self] result in
            switch result {
            case .success(let products):
                self?.viewModel.products = products
                self?.viewModel.productsCopy = self?.viewModel.products ?? []
                self?.shouldShowCollectionView = true
                self?.reloadProducts()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

    @IBAction func retryTapped(_ sender: Any) {
        shouldShowCollectionView = true
        self.view.showLoader()
        showViewsBasedOnConnectivity()
    }
}

extension ProductListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productList.count == 0 ? 0 : viewModel.productList.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                            for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.product = viewModel.productList[indexPath.row]
        return cell
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.productList[indexPath.row]
        coordinator?.productDetails(product)
    }
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: AppConstant.CellPadding.top,
                            left: AppConstant.CellPadding.left,
                            bottom: AppConstant.CellPadding.bottom,
                            right: AppConstant.CellPadding.right)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftRightPaddings = AppConstant.CellProperties.leftRightPaddings
        let numberOfItemsPerRow = AppConstant.CellProperties.noOfItemsInRow

        let width = (collectionView.frame.width - leftRightPaddings) / numberOfItemsPerRow
        return CGSize(width: width, height: width)
    }
}
