//
//  ExtensionUILabel .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 02.12.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, aligment: NSTextAlignment = .left, textColor: UIColor = .black) {
        self.init()
        
        self.text = text
        self.font = font
        self.textAlignment = aligment
        self.textColor = textColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
    }
}

