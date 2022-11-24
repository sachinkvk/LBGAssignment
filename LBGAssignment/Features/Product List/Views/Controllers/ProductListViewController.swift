//
//  ProductListViewController.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak private var retryView: UIView!
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    private let cellIdentifier = AppConstant.CellIdentifiers.productCellIdentifier
    private let productCollectionViewCell = AppConstant.CellIdentifiers.productCollectionViewCell
    private let refreshControl = UIRefreshControl()
    var actions: [(String, UIAlertAction.Style)] = []
    
    var viewModel = ProductListViewModel()

    private var shouldShowCollectionView: Bool = true {
        didSet {
            productListCollectionView.isHidden = !shouldShowCollectionView
            if shouldShowCollectionView {
                DispatchQueue.main.async {
                    self.view.showLoader()
                }
            } else {
                DispatchQueue.main.async {
                    self.view.hideLoader()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productListCollectionView.register(UINib(nibName: productCollectionViewCell,
                                                 bundle: nil), forCellWithReuseIdentifier: cellIdentifier )
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        loadActionSheets()
        self.title = viewModel.screenTitle
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        productListCollectionView.addSubview(refreshControl)
        shouldShowCollectionView = true
        fetchProducts()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        fetchProducts()
    }
    
    func loadActionSheets() {
        actions.append((SortOptions.HighToLow.rawValue, UIAlertAction.Style.default))
        actions.append((SortOptions.lowToHigh.rawValue, UIAlertAction.Style.default))
        actions.append(("Cancel", UIAlertAction.Style.cancel))
    }
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        ActionSheet.showActionsheet(viewController: self, title: "Price", message: "", actions: actions) { [weak self] sortOrder in
            self?.handleSheetAction(sortOrder: sortOrder)
        }
    }
    
    func handleSheetAction(sortOrder: String) {
        guard let order = SortOptions(rawValue: sortOrder) else { return }
        
        viewModel.isSortingApplied = true
        viewModel.productsCopy = self.viewModel.sortBy(order: order)
        reloadProducts()
    }
    
    func reloadProducts() {
        DispatchQueue.main.async {
            self.productListCollectionView.reloadData()
        }
    }
    
    private func fetchProducts() {
        if !Reachability.isConnectedToNetwork() {
            shouldShowCollectionView = false
            return
        }
        
        viewModel.fetchProducts { [weak self] result in
            switch result {
            case .success(let products):
                self?.viewModel.products = products
                self?.viewModel.productsCopy = self?.viewModel.products ?? []
                self?.refreshUI()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func refreshUI() {
        DispatchQueue.main.async {
            self.view.hideLoader()
            self.refreshControl.endRefreshing()
        }
        reloadProducts()
    }
    
    @IBAction func retryTapped(_ sender: Any) {
        shouldShowCollectionView = true
        fetchProducts()
    }
}

extension ProductListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productList.count == 0 ? 0 : viewModel.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        cell.productViewModel = viewModel.productList[indexPath.row]
        return cell
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = ProductDetailsViewController.instantiate(appStoryboard: .main) as? ProductDetailsViewController else { return }
        let product = viewModel.productList[indexPath.row]
        vc.productDetailsViewModel = ProductDetailsViewModel(product: product)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftRightPaddings: CGFloat = 10
        let numberOfItemsPerRow: CGFloat = 2.0
    
        let width = (collectionView.frame.width-leftRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width)
    }
}
