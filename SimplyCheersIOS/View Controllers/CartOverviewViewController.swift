//
//  CartViewController.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 04/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import UIKit

class CartOverviewViewController: UIViewController {

    @IBOutlet var selectedUserName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setSelectedUser), name: UserController.selectedUserUpdatedNotification, object: nil)
        if UserController.shared.selectedUser != nil {
            selectedUserName.text = UserController.shared.selectedUser.firstName
        }
    }
    
    @objc func setSelectedUser() {
        self.selectedUserName.text = UserController.shared.selectedUser.firstName
    }

}
