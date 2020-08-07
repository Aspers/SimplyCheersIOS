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

    @IBOutlet var navigationUserSearchButton: UIBarButtonItem!
    @IBOutlet var userSearchBar: UISearchBar!
    @IBOutlet var userList: UITableView!
    
    let networkController = NetworkController()
    var users = [User]()
    var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userSearchBar.isHidden = true
        animationView = .init(name: "loadingBeer")
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 2
        animationView?.frame = view.bounds
        view.addSubview(animationView!)
        
        self.loading()
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
            self.doneLoading()
        }
    }
    
    private func loading() {
        userList.isHidden = true
        animationView?.isHidden = false
        animationView?.play()
    }
    
    private func doneLoading() {
        animationView?.stop()
        animationView?.isHidden = true
        userList.isHidden = false
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
