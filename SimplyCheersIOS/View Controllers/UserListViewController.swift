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
    var users = [User]()
    
    
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
        users = createArray()
        userList.delegate = self
        userList.dataSource = self
    }
    
    @IBAction func navigationUserSearchButtonClicked(_ sender: Any) {
        if userSearchBar.isHidden == true {
            userSearchBar.isHidden = false }
        else { userSearchBar.isHidden = true }
    }
    
    func createArray() -> [User] {
        var temp = [User]()
        let user1 = User(userId: 1, firstName: "Arjen", lastName: "Trinquet", balance: Decimal(10), fine: true)
        let user2 = User(userId: 2, firstName: "Test", lastName: "Achternaam", balance: Decimal(-1), fine: false)
        temp.append(user1)
        temp.append(user2)
        
        return temp
    }
    
}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.setupCell(user: user)
        return cell
    }
}
