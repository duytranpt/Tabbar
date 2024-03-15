//
//  App.swift
//  gif
//
//  Created by Duy Tran on 14/03/2024.
//

import UIKit

struct App {
    static var Lang = "vi"
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    
    static var topHeight: CGFloat {
        let inset = UIApplication.shared.windows.first?.safeAreaInsets
        return inset?.top ?? 0.0
    }
    
    static var bottomHeight: CGFloat {
        let inset = UIApplication.shared.keyWindow?.safeAreaInsets
        return inset?.bottom ?? 0.0
    }
}
