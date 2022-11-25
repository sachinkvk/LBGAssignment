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

    private let cellIdentifier = AppConstant.CellIdentifiers.productCellIdentifier
    private let productCollectionViewCell = AppConstant.CellIdentifiers.productCollectionViewCell
    var actions: [(String, UIAlertAction.Style)] = []

    var viewModel = ProductListViewModel()

    var shouldShowCollectionView: Bool = true {
        didSet {
            DispatchQueue.main.async {
                self.productListCollectionView.isHidden = !self.shouldShowCollectionView
                self.sortView.isHidden = !self.shouldShowCollectionView
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        productListCollectionView.register(UINib(nibName: productCollectionViewCell,
                                                 bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        loadActionSheets()
        self.title = viewModel.screenTitle
        self.view.showLoader()
        showViewsBasedOnConnectivity()
    }

    func loadActionSheets() {
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

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        guard let cell = cell as? ProductCollectionViewCell else { return UICollectionViewCell() }
        cell.productViewModel = viewModel.productList[indexPath.row]
        return cell
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let viewController = ProductDetailsViewController.instantiate(appStoryboard: .main)
        guard let productDetailsVC = viewController as? ProductDetailsViewController else { return }
        let product = viewModel.productList[indexPath.row]
        productDetailsVC.productDetailsViewModel = ProductDetailsViewModel(product: product)
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftRightPaddings: CGFloat = 10
        let numberOfItemsPerRow: CGFloat = 2.0

        let width = (collectionView.frame.width-leftRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width)
    }
}
