//
//  UserViewController.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 04/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {

    @IBOutlet var navigationUserSearchButton: UIBarButtonItem!
    @IBOutlet var userSearchBar: UISearchBar!
    @IBOutlet var userList: UITableView!
    
    let networkController = NetworkController()
    
    
    override func viewDidLoad() {        //networkController.fetchAllCategories()
        //networkController.fetchAllProducts()
        
//        networkController.fetchAllActiveUsers {
//            (users) in
//            guard let users = users else { return }
//            print(users)
//        }
        networkController.fetchAllProducts {
            (products) in
            guard let products = products else { return }
            print(products)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func navigationUserSearchButtonClicked(_ sender: Any) {
        if userSearchBar.isHidden == true {
            userSearchBar.isHidden = false }
        else { userSearchBar.isHidden = true }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.isHidden = true
    }
    
}
