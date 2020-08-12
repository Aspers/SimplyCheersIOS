//
//  CartCell.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 12/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import Foundation
import UIKit

class CartCell: UITableViewCell {
    
    @IBOutlet var cartItemName: UILabel!
    @IBOutlet var cartItemAmount: UILabel!
    
    var cartItem: CartItem!
    
    func setupCell(item: CartItem) {
        cartItem = item
        cartItemName.text = item.product.name
        cartItemAmount.text = "\(item.amount)"
    }
    
    @IBAction func cartItemMinusButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func cartItemPlusButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func cartItemTrashButtonTapped(_ sender: Any) {
        
    }
}
