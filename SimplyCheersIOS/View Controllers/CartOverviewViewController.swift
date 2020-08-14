//
//  CartViewController.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 04/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import UIKit
import Lottie

enum SuccesKeyFrames: CGFloat {
    case startLoading = 0
    case endSuccess = 31
}

class CartOverviewViewController: UIViewController {

    @IBOutlet var selectedUserName: UILabel!
    @IBOutlet var selectedUserBalance: UILabel!
    @IBOutlet var cartList: UITableView!
    @IBOutlet var cartTotal: UILabel!
    @IBOutlet var cartTabBarItem: UITabBarItem!
    @IBOutlet var checkoutButton: UIButton!
    
    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setSelectedUser), name: UserController.selectedUserUpdatedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCartUI), name: CartController.cartItemsUpdatedNotification, object: nil)
        
        animationView = .init(name: "checkAnimation")
        animationView?.animationSpeed = 1
        animationView?.frame = view.bounds
        view.addSubview(animationView!)
        animationView?.isHidden = true
        
        checkoutButton.layer.cornerRadius = 7
        
        setSelectedUser()
        updateCartUI()
        
        cartList.delegate = self
        cartList.dataSource = self
    }
    
    @IBAction func checkoutCart(_ sender: Any) {
        CartController.shared.checkoutCart() {
            (complete) in
            DispatchQueue.main.async {
                if complete {
                    self.playSuccesAnimation()
                } else {
                    print("Something went wrong")
                }
            }
        }
    }
    
    @objc func setSelectedUser() {
        let selectedUser = UserController.shared.selectedUser
        if selectedUser == nil {
            selectedUserName.text = "Selecteer een gebruiker"
            selectedUserBalance.text = nil
            disableButton()
        } else {
            enableButton()
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
            if CartController.shared.cart.totalItems < 1 {
                self.disableButton()
            } else {
                self.enableButton()
            }
        }
    }
    
    private func disableButton() {
        checkoutButton.isEnabled = false
        checkoutButton.backgroundColor = UIColor.lightGray
    }
    
    private func enableButton() {
        guard UserController.shared.selectedUser != nil, CartController.shared.cart.totalItems > 0 else {return}
        checkoutButton.isEnabled = true
        checkoutButton.backgroundColor = UIColor(red: 199/255, green: 121/255, blue: 126/255, alpha: 1)
    }
    
    private func playSuccesAnimation() {
        self.animationView?.isHidden = false
        animationView!.play(fromFrame: SuccesKeyFrames.startLoading.rawValue, toFrame: SuccesKeyFrames.endSuccess.rawValue, loopMode: .playOnce) {
            (_) in
            self.animationView?.isHidden = true
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
