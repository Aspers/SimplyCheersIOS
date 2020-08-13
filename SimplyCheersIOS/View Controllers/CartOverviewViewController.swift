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
    @IBOutlet var cartTabBarItem: UITabBarItem!
    @IBOutlet var checkoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setSelectedUser), name: UserController.selectedUserUpdatedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCartUI), name: CartController.cartItemsUpdatedNotification, object: nil)
        
        checkoutButton.layer.cornerRadius = 7
        
        setSelectedUser()
        updateCartUI()
        
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
                selectedUserBalance.textColor = UIColor.red.withAlphaComponent(0.7)
            } else {
                selectedUserBalance.textColor = UIColor.black
            }
        }
    }
    
    @objc func updateCartUI() {
        DispatchQueue.main.async {
            self.cartList.reloadData()
            self.cartTotal.text = String(format: "Totaal: € %.2f", Double(truncating: CartController.shared.cart.totalPrice as NSNumber))
        }
    }
}

extension CartOverviewViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = CartController.shared.cart.cartItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as! CartCell
        cell.setupCell(item: item)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartController.shared.cart.cartItems.count
    }
}

extension CartOverviewViewController: CartCellDelegate {
    func didTapMinus(product: Product) {
        CartController.shared.removeProductFromCart(product: product)
    }
    
    func didTapPlus(product: Product) {
        CartController.shared.addProductToCart(product: product)
    }
    
    func didTapTrash(product: Product) {
        CartController.shared.deleteProductFromCart(product: product)
    }
    
    
}
