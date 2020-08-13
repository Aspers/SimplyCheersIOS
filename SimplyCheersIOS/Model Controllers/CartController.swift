//
//  CartController.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 10/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import Foundation

class CartController {
    
    static let shared = CartController()
    
    static let cartItemsUpdatedNotification = Notification.Name("CartController.cartItemsUpdated")
    var cart = Cart()
    
    func addProductToCart(product: Product) -> Void {
        cart.addProduct(product: product)
    }
    
    func removeProductFromCart(product: Product) -> Void {
        cart.removeProduct(product: product)
    }
    
    func deleteProductFromCart(product: Product) -> Void {
        cart.deleteProduct(product: product)
    }
    
    func checkoutCart() {
        UserController.shared.updateUserBalance(forAmount: cart.totalPrice)
        cart.clearCart()
        UserController.shared.clearSelectedUser()
    }
    
}
