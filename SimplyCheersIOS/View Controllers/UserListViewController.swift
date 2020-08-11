//
//  UserViewController.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 04/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import UIKit
import Lottie

class UserListViewController: UIViewController {

    @IBOutlet var searchContainerView: UIView!
    @IBOutlet var userList: UITableView!
    @IBOutlet var mainUserSelectionView: UIStackView!
    
    var searchController: UISearchController!
    var users = [User]()
    var filteredUsers = [User]()
    var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup searchController
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
        
        animationView = .init(name: "loadingBeer")
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 2
        animationView?.frame = view.bounds
        view.addSubview(animationView!)
        
        self.loading()
        
        UserController.shared.fetchAllActiveUsers {
            (users) in
            if let users = users {
                self.updateUI(with: users)
            }
        }
        
        // Delegates instellen
        userList.delegate = self
        userList.dataSource = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController.isActive = false
    }
    
    func updateUI(with users: [User]){
        DispatchQueue.main.async {
            self.users = users
            self.filteredUsers = users
            self.userList.reloadData()
            self.doneLoading()
        }
    }
    
    func filterUserListToSearchText(_ searchText: String) {
        
        if searchText.count > 0 {
            
            filteredUsers = users
            filteredUsers = users.filter { (user: User) -> Bool in
                let name = "\(user.firstName) \(user.lastName)"
                return name.lowercased().contains(searchText.lowercased())
            }
            userList.reloadData()
        }
        if searchText.count == 0 {
            filteredUsers = users
            userList.reloadData()
        }
    }
    
    private func loading() {
        mainUserSelectionView.isHidden = true
        animationView?.isHidden = false
        animationView?.play()
    }
    
    private func doneLoading() {
        animationView?.stop()
        animationView?.isHidden = true
        mainUserSelectionView.isHidden = false
    }
}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = filteredUsers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.setupCell(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = self.filteredUsers[indexPath.row]
        if UserController.shared.selectedUser == nil || selectedUser.userId != UserController.shared.selectedUser.userId {
            UserController.shared.selectedUser = selectedUser
        }
    }
    
}

extension UserListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        if let searchText = searchBar.text {
            filterUserListToSearchText(searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        
        if let searchText = searchBar.text, !searchText.isEmpty {
            filteredUsers = users
            userList.reloadData()
        }
    }
    
}

extension UserListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterUserListToSearchText(searchText)
        }
    }
    
}

