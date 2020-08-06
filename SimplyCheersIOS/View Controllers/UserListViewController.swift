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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkController.fetchAllActiveUsers {
            (users) in
            if let users = users {
                self.updateUI(with: users)
            }
        }
        userList.delegate = self
        userList.dataSource = self
    }
    
    @IBAction func navigationUserSearchButtonClicked(_ sender: Any) {
        if userSearchBar.isHidden == true {
            userSearchBar.isHidden = false }
        else { userSearchBar.isHidden = true }
    }
    
    func updateUI(with users: [User]){
        DispatchQueue.main.async {
            self.users = users
            self.userList.reloadData()
        }
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
