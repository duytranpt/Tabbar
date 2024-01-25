//
//  Color+.swift
//  gif
//
//  Created by Duy Tran on 06/09/2022.
//

import UIKit

extension UIColor {
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func colorFromHex(_ hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6 {
            return UIColor.magenta
        }
        
        var rgb: UInt64 = 0
        Scanner.init(string: hexString).scanHexInt64(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16)/255,
                            green: CGFloat((rgb & 0x00FF00) >> 8)/255,
                            blue: CGFloat(rgb & 0x0000FF)/255,
                            alpha: 1.0)
    }
    
    func hexStringFromColor(color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
     }

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

extension UIColor {
    static let text_Red_2 = colorFromHex("FF5C22")
    static let LightTextColor = colorFromHex("919191")
    static let button_main_color = rgbColor(red: 219, green: 163, blue: 16, alpha: 1.0)
    static let text_gray_color = rgbColor(red: 144, green: 144, blue: 144, alpha: 1.0)
    static let text_Color = rgbColor(red: 47, green: 47, blue: 47, alpha: 1)
}

enum COLOR_TYPE {
    case DEFAULT_COLOR
    case COLOR1
    case COLOR2
    case COLOR3
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
