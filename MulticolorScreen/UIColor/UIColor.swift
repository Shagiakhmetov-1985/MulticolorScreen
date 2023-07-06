//
//  UIColor.swift
//  MulticolorScreen
//
//  Created by Marat Shagiakhmetov on 06.07.2023.
//

import UIKit

extension UIColor {
    func toHex() -> String {
        guard let components = cgColor.components, components.count >= 3 else { return "" }
        
        let red = Float(components[0]) * 255
        let green = Float(components[1]) * 255
        let blue = Float(components[2]) * 255
        
        return "HEX: #" + String(format: "%02lX%02lX%02lX", lroundf(red), lroundf(green), lroundf(blue))
    }
    
    func toRgb() -> String {
        guard let components = cgColor.components, components.count >= 3 else { return "" }
        
        let red = Float(components[0]) * 255
        let green = Float(components[1]) * 255
        let blue = Float(components[2]) * 255
        let rgbRed = String(format: "%.0f", red)
        let rgbGreen = String(format: "%.0f", green)
        let rgbBlue = String(format: "%.0f", blue)
        
        return "RGB: Red \(rgbRed), Green \(rgbGreen), Blue \(rgbBlue)"
    }
}
