//
//  User.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 04/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import Foundation

struct User: Codable {
    var userId: Int
    var firstName: String
    var lastName: String
    var balance: Decimal
    var fine: Bool
    var nickname: String?
    
    init(userId: Int, firstName: String, lastName: String, balance: Decimal, fine: Bool) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.balance = balance
        self.fine = fine
    }
}
