//
//  Product.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 04/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import Foundation

struct Product: Codable {
    var productId: Int
    var name: String
    var price: Decimal
    var favourite: Bool
    var active: Bool
    var imageURL: URL?
    var categories: [Category]?
    
    enum CodingKeys: String, CodingKey {
        case productId
        case name
        case price
        case favourite
        case active
        case imageURL = "image"
        case categories
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.productId = try valueContainer.decode(Int.self, forKey: CodingKeys.productId)
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.price = try valueContainer.decode(Decimal.self, forKey: CodingKeys.price)
        self.favourite = try valueContainer.decode(Bool.self, forKey: CodingKeys.favourite)
        self.active = try valueContainer.decode(Bool.self, forKey: CodingKeys.active)
        self.imageURL = try? valueContainer.decode(URL.self, forKey: CodingKeys.imageURL)
        self.categories = try? valueContainer.decode([Category].self, forKey: CodingKeys.categories)
    }
}
