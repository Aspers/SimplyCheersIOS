//
//  Cart.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 04/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import Foundation

struct Cart {
    var selectedUser: User?
    var cartItems: [CartItem]
    var totalPrice: Decimal {
        return cartItems.map({$0.cartItemTotal}).reduce(0, +)
    }
    var totalItems: Int {
        return cartItems.map({$0.amount}).reduce(0, +)
    }
    var newUserBalance: Decimal? {
        guard selectedUser == nil else { return nil }
        return selectedUser!.balance - totalPrice
    }
    
    init() {
        selectedUser = nil
        cartItems = []
    }
    
    mutating func addProduct(product: Product) {
        if !isInCart(product: product) {
            self.cartItems.append(CartItem(product: product))
        } else {
            let index = self.cartItems.firstIndex(where: {$0.product.productId == product.productId} )!
            self.cartItems[index].addProduct()
        }
    }
    
    mutating func removeProduct(product: Product) {
        if !isInCart(product: product) {
            return
        } else {
            let index = self.cartItems.firstIndex(where: {$0.product.productId == product.productId} )!
            if self.cartItems[index].amount > 0 {
                self.cartItems[index].removeProduct()
            } else {
                self.cartItems.remove(at: index)
            }
        }
    }
    
    private func isInCart(product: Product) -> Bool {
        let items = self.cartItems.filter { $0.product.productId == product.productId }
        return items.isEmpty
    }
}
