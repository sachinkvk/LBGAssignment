//
//  ProductListViewController.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var productListCollectionView: UICollectionView!
    var viewModel = ProductListViewModel()
    let cellIdentifier = AppConstant.CellIdentifiers.cellIdentifier.rawValue
    let productCollectionViewCell = AppConstant.CellIdentifiers.productCollectionViewCell.rawValue
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productListCollectionView.register(UINib(nibName: productCollectionViewCell,
                                                 bundle: nil), forCellWithReuseIdentifier: cellIdentifier )
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        self.title = "Products"
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        productListCollectionView.addSubview(refreshControl) // not required when using UITableViewController
        fetchProducts()
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        fetchProducts()
    }
    
    private func fetchProducts() {
        viewModel.fetchProducts { [weak self] result in
            switch result {
            case .success(let products):
                self?.viewModel.products = products
                DispatchQueue.main.async {
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
        return viewModel.products.count == 0 ? 0 : viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        cell.productViewModel = viewModel.products[indexPath.row]
        return cell
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = ProductDetailsViewController.instantiate(appStoryboard: .main) as? ProductDetailsViewController else { return }
        vc.productDetailsViewModel = ProductDetailsViewModel(product: viewModel.products[indexPath.row])
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
