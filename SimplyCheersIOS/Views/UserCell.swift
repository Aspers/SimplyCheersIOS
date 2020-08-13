//
//  UserCell.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 05/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var balanceLabel: PaddingLabel!
    
    func setupCell(user: User) {
        // Waarden invullen in labels
        userNameLabel.text = user.firstName + " " + user.lastName
        avatarLabel.text = (user.firstName.prefix(1) + user.lastName.prefix(1)).uppercased()
        nicknameLabel.text = user.nickname
        balanceLabel.text = String(format: "€ %.2f", Double(truncating: user.balance as NSNumber))
        
        // Formatting van balance label
        balanceLabel.layer.cornerRadius = 10
        balanceLabel.layer.masksToBounds = true
        if user.balance.isLessThanOrEqualTo(Decimal(0)) {
            balanceLabel.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        } else if user.balance.isLessThanOrEqualTo(Decimal(5)) {
            balanceLabel.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
        } else {
            balanceLabel.backgroundColor = UIColor(red: 153/255, green: 214/255, blue: 177/255, alpha: 0.75)
        }
        
        // Formating van avatar label
        avatarLabel.layer.cornerRadius = avatarLabel.bounds.size.height/2
        avatarLabel.layer.masksToBounds = true
    }

}
