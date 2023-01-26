//
//  ExetensionUIFont .swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 08.12.2022.
//

import UIKit

typealias FS = UIFont.FontSize

extension UIFont {
    struct FontSize {
        private static let SCREEN_WIDTH = Int(UIScreen.main.bounds.size.width)
        
        public static func s(_ s: CGFloat) -> CGFloat {
            var ns = s
            
            switch SCREEN_WIDTH {
            case 320:
                break
            case 375:
                ns += 2
            case 376...500:
                ns += 4
            default:
                break
            }
            
            return ns
        }
    }
}
