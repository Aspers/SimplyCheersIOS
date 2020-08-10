//
//  ProductViewController.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 04/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import UIKit
import Lottie

class StoreViewController: UIViewController {
    
    @IBOutlet var productList: UITableView!
    @IBOutlet var searchContainerView: UIView!
    @IBOutlet var mainProductSelectionView: UIStackView!
    
    private var searchController: UISearchController!
    private var categories = [Category]()
    private var products = [Product]()
    private var filteredProducts = [Product]()
    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.barTintColor = UIColor(red: 215/255, green: 244/255, blue: 240/255, alpha: 1)
        searchController.searchBar.delegate = self
        
        //productList.refreshControl = refreshControl
        //refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        animationView = .init(name: "loadingBeer")
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 2
        animationView?.frame = view.bounds
        view.addSubview(animationView!)
        
        self.loading()
        self.fetchData()

        // Delegates instellen
        productList.delegate = self
        productList.dataSource = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController.isActive = false
    }
    
    func updateUI(with products: [Product]){
        DispatchQueue.main.async {
            self.products = products
            self.filteredProducts = products
            self.productList.reloadData()
            self.doneLoading()
        }
    }
    
    func updateCategories(with categories: [Category]) {
        DispatchQueue.main.async {
            self.categories = categories
            print(self.categories)
        }
    }
    
    func filterProductListToSearchText(_ searchText: String) {
        
        if searchText.count > 0 {
            
            filteredProducts = products
            filteredProducts = products.filter { (product: Product) -> Bool in
                return product.name.lowercased().contains(searchText.lowercased())
            }
            productList.reloadData()
        }
        if searchText.count == 0 {
            filteredProducts = products
            productList.reloadData()
        }
    }
    
    private func fetchData() {
        CategoryController.shared.fetchAllCategories {
            (categories) in
            if let categories = categories {
                self.updateCategories(with: categories)
            }
        }
        
        ProductController.shared.fetchAllProducts {
            (products) in
            if let products = products {
                self.updateUI(with: products)
                
            }
        }
        
    }
    
    private func loading() {
        mainProductSelectionView.isHidden = true
        animationView?.isHidden = false
        animationView?.play()
    }
    
    private func doneLoading() {
        animationView?.stop()
        animationView?.isHidden = true
        mainProductSelectionView.isHidden = false
    }
    
}

extension StoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    // TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = filteredProducts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
        if product.imageURL != nil {
            ProductController.shared.fetchProductImage(url: product.imageURL!) {
                (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        if let currentIndexPath = tableView.indexPath(for: cell), currentIndexPath != indexPath {
                            return
                        }
                        cell.productImageView?.image = image
                    }
                }
            }
        } else {
            cell.productImageView?.image = UIImage(named: "drink")
        }
        cell.setupCell(product: product)
        return cell
    }
    
}

extension StoreViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        if let searchText = searchBar.text {
            filterProductListToSearchText(searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        
        if let searchText = searchBar.text, !searchText.isEmpty {
            filteredProducts = products
            productList.reloadData()
        }
    }
    
}

extension StoreViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterProductListToSearchText(searchText)
        }
    }
    
}
