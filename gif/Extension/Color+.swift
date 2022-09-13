//
//  Color+.swift
//  gif
//
//  Created by Duy Tran on 06/09/2022.
//

import Foundation
import UIKit

extension UIColor {
    
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
//    45 103 130

    static func cgRGB(rgb: String) -> UIColor {
        let colorArr = rgb.components(separatedBy: " ")
        let r = Int(colorArr[0])!
        let g = Int(colorArr[1])!
        let b = Int(colorArr[2])!
        
        let red: CGFloat = CGFloat(r)
        let green: CGFloat = CGFloat(g)
        let blue: CGFloat = CGFloat(b)
        
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    //    rgba 0 0 0, 0.08
    
    static func cgRGBA(rgba: String) -> UIColor {
        let colorArr = rgba.components(separatedBy: " ")
        let r = Int(colorArr[0])!
        let g = Int(colorArr[1])!
        let b = Int(colorArr[2].dropLast())!
        let a = Double(colorArr[3])!
        
        let red: CGFloat = CGFloat(r)
        let green: CGFloat = CGFloat(g)
        let blue: CGFloat = CGFloat(b)
        let alpha: CGFloat = CGFloat(a)
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }

}

enum COLOR_TYPE {
    case DEFAULT_COLOR
    case COLOR1
    case COLOR2
    case COLOR3
}
