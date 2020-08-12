//
//  CartCell.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 12/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import Foundation
import UIKit

protocol CartCellDelegate {
    
    func didTapMinus(product: Product)
    func didTapPlus(product: Product)
    func didTapTrash(product: Product)
    
}

class CartCell: UITableViewCell {
    
    @IBOutlet var cartItemName: UILabel!
    @IBOutlet var cartItemAmount: UILabel!
    
    var cartItem: CartItem!
    var delegate: CartCellDelegate?
    
    func setupCell(item: CartItem) {
        cartItem = item
        cartItemName.text = item.product.name
        cartItemAmount.text = "\(item.amount)"
    }
    
    @IBAction func cartItemMinusButtonTapped(_ sender: Any) {
        delegate?.didTapMinus(product: cartItem.product)
    }
    
    @IBAction func cartItemPlusButtonTapped(_ sender: Any) {
        delegate?.didTapPlus(product: cartItem.product)
    }
    
    @IBAction func cartItemTrashButtonTapped(_ sender: Any) {
        delegate?.didTapTrash(product: cartItem.product)
    }
}
