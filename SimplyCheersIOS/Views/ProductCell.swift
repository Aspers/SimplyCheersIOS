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
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var productImageView: UIImageView!
    
    var product: Product!
    
    func setupCell(product: Product) {
        
        // Set container shadow
        productContainer.layer.cornerRadius = 10
        productContainer.layer.shadowColor = UIColor.black.cgColor
        productContainer.layer.shadowOpacity = 0.2
        productContainer.layer.shadowOffset = CGSize(width: 2, height: 2)
        productContainer.layer.shadowRadius = 1
        productContainer.layer.shouldRasterize = true
        productContainer.layer.rasterizationScale = UIScreen.main.scale
        
        // Set product values
        self.product = product
        productNameLabel.text = product.name
        productPriceLabel.text = String(format: "‎€ %.2f", Double(truncating: product.price as NSNumber))
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.addToCart))
        self.productContainer.addGestureRecognizer(gesture)
        
        
    }
    
    @objc func addToCart(sender: UITapGestureRecognizer) {
        CartController.shared.cart.addProduct(product: product)
        UIView.animate(withDuration: 0.08, delay: 0, options: .curveEaseIn, animations: {
            self.productContainer.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }){ (_) in
            UIView.animate(withDuration: 0.08, delay: 0, options: .curveEaseIn, animations: {
                self.productContainer.transform = .identity
            })
        }
    }
    
}
