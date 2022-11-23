//
//  ProductListViewController.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak private var productListCollectionView: UICollectionView!
    var viewModel = ProductListViewModel()
    private let cellIdentifier = AppConstant.CellIdentifiers.cellIdentifier.rawValue
    private let productCollectionViewCell = AppConstant.CellIdentifiers.productCollectionViewCell.rawValue
    private let refreshControl = UIRefreshControl()
    var actions: [(String, UIAlertAction.Style, SortingList)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        productListCollectionView.register(UINib(nibName: productCollectionViewCell,
                                                 bundle: nil), forCellWithReuseIdentifier: cellIdentifier )
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        loadActionSheets()
        self.title = viewModel.screenTitle
        refreshControl.attributedTitle = NSAttributedString(string: viewModel.pullToRefreshText)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        productListCollectionView.addSubview(refreshControl)
        fetchProducts()
        self.view.showLoader()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        fetchProducts()
    }
    
    private func loadActionSheets() {
        actions.append((SortingList.HighToLow.rawValue, UIAlertAction.Style.default, .HighToLow))
        actions.append((SortingList.lowToHigh.rawValue, UIAlertAction.Style.default, .lowToHigh))
        actions.append((SortingList.Cancel.rawValue, UIAlertAction.Style.cancel, .Cancel))
    }
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        ActionSheet.showActionsheet(viewController: self, title: "Price", message: "", actions: actions) { [weak self] type in
            switch type {
            case .HighToLow:
                self?.viewModel.isSortingApplied = true
                self?.viewModel.productsCopy = self?.viewModel.sortBy(order: .HighToLow) ?? []
                self?.reloadProducts()
            case .lowToHigh:
                self?.viewModel.isSortingApplied = true
                self?.viewModel.productsCopy = self?.viewModel.sortBy(order: .lowToHigh) ?? []
                self?.reloadProducts()
            default:
                print("none")
            }
        }
    }
    
    func reloadProducts() {
        DispatchQueue.main.async {
            self.productListCollectionView.reloadData()
        }
    }
    
    private func fetchProducts() {
        viewModel.fetchProducts { [weak self] result in
            switch result {
            case .success(let products):
                self?.viewModel.translateProducts(products)
                self?.viewModel.productsCopy = self?.viewModel.products ?? []
                DispatchQueue.main.async {
                    self?.view.hideLoader()
                    self?.refreshControl.endRefreshing()
                    self?.productListCollectionView.reloadData()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
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

class ActionSheet {
    static func showActionsheet(viewController: UIViewController, title: String,
                                message: String, actions: [(String, UIAlertAction.Style, SortingList)],
                                completion: @escaping (_ type: SortingList) -> Void) {
    let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for (_ , (title, style, type)) in actions.enumerated() {
        let alertAction = UIAlertAction(title: title, style: style) { (_) in
            completion(type)
        }
        alertViewController.addAction(alertAction)
     }
     viewController.present(alertViewController, animated: true, completion: nil)
    }
}
