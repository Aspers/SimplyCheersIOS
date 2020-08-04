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
}
