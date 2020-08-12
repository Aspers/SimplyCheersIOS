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
    @IBOutlet var selectedUserBalance: UILabel!
    @IBOutlet var cartList: UITableView!
    @IBOutlet var cartTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setSelectedUser), name: UserController.selectedUserUpdatedNotification, object: nil)
        setSelectedUser()
        cartTotal.text = "\(CartController.shared.cart.totalItems)"
        
        cartList.delegate = self
        cartList.dataSource = self
    }
    
    @objc func setSelectedUser() {
        let selectedUser = UserController.shared.selectedUser
        if selectedUser == nil {
            selectedUserName.text = "Selecteer een gebruiker"
            selectedUserBalance.text = nil
        } else {
            selectedUserName.text = "\(selectedUser!.firstName) \(selectedUser!.lastName)"
            selectedUserBalance.text = String(format: "€ %.2f", Double(truncating: selectedUser!.balance as NSNumber))
            if selectedUser!.balance <= 0 {
                selectedUserBalance.textColor = UIColor.red
            } else {
                selectedUserBalance.textColor = UIColor.black
            }
        }
    }
}

extension CartOverviewViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = CartController.shared.cart.cartItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as! CartCell
        cell.setupCell(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartController.shared.cart.cartItems.count
    }
}
