//
//  CartItem.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 12/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import Foundation

struct CartItem {
    var product: Product
    var amount: Int
    var cartItemTotal: Decimal {
        return product.price * Decimal(amount)
    }
    
    init(product: Product) {
        self.product = product
        amount = 1
    }
    
    mutating func addProduct() -> Void {
        self.amount+=1
    }
    
    mutating func removeProduct() -> Void {
        self.amount-=1
    }
}
