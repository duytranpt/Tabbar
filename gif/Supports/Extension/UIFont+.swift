//
//  UIFont+.swift
//  gif
//
//  Created by Duy Tran on 21/12/2022.
//

import UIKit

extension UIFont {
    static func fontBold(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func fontMedium(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func fontRegular(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func fontCard(_ size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "SF-Pro-Display-Bold", size: size) else {
          return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
}
