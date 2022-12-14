//
//  Demo.swift
//  
//
//  Created by Duy Tran on 24/08/2022.
//

import Foundation
import UIKit

struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

class NavbarHeight {
    
    var navbarHeight: CGFloat = {
        var height: CGFloat = 64
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            let topPadding = window?.safeAreaInsets.top
            print("topPadding: \(topPadding)")
            let bottomPadding = window?.safeAreaInsets.bottom
            if topPadding! > 20 {
                height += 36
            }

        }
       
        return height
    }()
    
//    init(_ a: Float) {
////        height = a
//    }
    
//    func navbarHeight() {
//
//    }
}
