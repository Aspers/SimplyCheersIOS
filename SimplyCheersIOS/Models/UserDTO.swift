//
//  UserDTO.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 13/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import Foundation

struct UserDTO : Codable {
    var userId: Int
    var balance: Decimal
    
    init(userId: Int, balance: Decimal) {
        self.userId = userId
        self.balance = balance
    }
}
