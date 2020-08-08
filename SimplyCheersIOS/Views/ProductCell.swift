//
//  ProductCell.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 08/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet var productContainer: UIView!
    
    func setupCell(product: Product) {
        
        productContainer.layer.cornerRadius = 10
        productContainer.layer.shadowColor = UIColor.black.cgColor
        productContainer.layer.shadowOpacity = 0.2
        productContainer.layer.shadowOffset = CGSize(width: 2, height: 2)
        productContainer.layer.shadowRadius = 1
    }
    
}
