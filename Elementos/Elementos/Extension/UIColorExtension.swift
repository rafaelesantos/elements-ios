//
//  UIColorExtension.swift
//  Eprimora
//
//  Created by Rafael Escaleira on 11/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit

extension UIColor {
    
    public static func hexStringToUIColor (hex: String) -> UIColor {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") { cString.remove(at: cString.startIndex) }
        
        if cString.count != 6 { return UIColor.label }

        var rgbValue: UInt64 = 0
        
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
    
    var toHexString: String {
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(format: "%02X%02X%02X", Int(r * 0xff), Int(g * 0xff), Int(b * 0xff))
    }
}
