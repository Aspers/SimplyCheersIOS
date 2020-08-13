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
    @IBOutlet var userContainer: UIView!
    
    var user: User!
    
    func setupCell(user: User) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(setSelectedUser), name: UserController.selectedUserUpdatedNotification, object: nil)
        
        self.user = user
        userNameLabel.text = user.firstName + " " + user.lastName
        nicknameLabel.text = user.nickname
        avatarLabel.text = (user.firstName.prefix(1) + user.lastName.prefix(1)).uppercased()
        balanceLabel.text = String(format: "€ %.2f", Double(truncating: user.balance as NSNumber))
        setSelectedUser()
        
        userContainer.layer.cornerRadius = 10
        
        if user.nickname == nil {
            userContainer.centerYAnchor.constraint(equalTo: self.userNameLabel.centerYAnchor).isActive = true
        }
        
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
    
    @objc func setSelectedUser() {
        if UserController.shared.selectedUser == nil || UserController.shared.selectedUser.userId != self.user.userId {
            self.avatarLabel.backgroundColor = UIColor(red: 86/255, green: 98/255, blue: 106/255, alpha: 1)
            self.avatarLabel.text = (user.firstName.prefix(1) + user.lastName.prefix(1)).uppercased()
        } else {
            self.avatarLabel.backgroundColor = UIColor(red: 153/255, green: 214/255, blue: 177/255, alpha: 0.75)
            self.avatarLabel.text = ""
            let attachment = NSTextAttachment()
            attachment.image = UIImage(systemName: "checkmark")
            let string = NSAttributedString(attachment: attachment)
            self.avatarLabel.attributedText = string
        }
    }

}
