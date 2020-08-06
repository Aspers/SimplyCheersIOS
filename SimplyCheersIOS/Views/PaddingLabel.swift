//
//  PaddingLabel.swift
//  SimplyCheersIOS
//
//  Created by Arjen Trinquet on 05/08/2020.
//  Copyright © 2020 Arjen Trinquet. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {

    var topPadding: CGFloat = 5.0
    var bottomPadding: CGFloat = 5.0
    var leftPadding: CGFloat = 7.0
    var rightPadding: CGFloat = 7.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftPadding + rightPadding,
                          height: size.height + topPadding + bottomPadding)
    }

    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftPadding + rightPadding)
        }
    }
}
