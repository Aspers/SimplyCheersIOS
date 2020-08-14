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

    @IBOutlet var mainView: UIView!
    @IBOutlet var searchContainerView: UIView!
    @IBOutlet var userList: UITableView!
    @IBOutlet var mainUserSelectionView: UIStackView!
    
    var searchController: UISearchController!
    var users = [User]()
    var filteredUsers = [User]()
    var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         NotificationCenter.default.addObserver(self, selector: #selector(updateUsers), name: CartController.cartCheckoutNotification, object: nil)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.barTintColor = UIColor(red: 249/255, green: 255/255, blue: 251/255, alpha: 1)
        searchController.searchBar.tintColor = UIColor(red: 199/255, green: 121/255, blue: 126/255, alpha: 1)
        searchController.searchBar.placeholder = "Zoeken"
        searchController.searchBar.setValue("Annuleren", forKey: "cancelButtonText")
        searchController.searchBar.delegate = self
        
        animationView = .init(name: "loadingBeer")
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 2
        animationView?.frame = view.bounds
        view.addSubview(animationView!)

        self.updateUsers()

        userList.delegate = self
        userList.dataSource = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController.isActive = false
    }
    
    @objc func updateUsers(){
        DispatchQueue.main.async {
            self.loading()
            UserController.shared.fetchAllActiveUsers {
                (users) in
                if let users = users {
                    DispatchQueue.main.async {
                        self.users = users
                        self.filteredUsers = users
                        self.userList.reloadData()
                        self.doneLoading()
                    }
                }
            }
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
        mainView.backgroundColor = UIColor(red: 249/255, green: 255/255, blue: 251/255, alpha: 1)
        animationView?.isHidden = false
        animationView?.play()
    }
    
    private func doneLoading() {
        animationView?.stop()
        animationView?.isHidden = true
        mainView.backgroundColor = UIColor(red: 179/255, green: 203/255, blue: 200/255, alpha: 1)
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
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        
        UIView.animate(withDuration: 0.08, delay: 0, options: .curveEaseIn, animations: {
            cell.userContainer.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }){ (_) in
            UIView.animate(withDuration: 0.08, delay: 0, options: .curveEaseIn, animations: {
                cell.userContainer.transform = .identity
            })
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

