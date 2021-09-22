//
//  UIColor+Extension.swift
//  Music Bag
//
//  Created by Premier on 05/09/21.
//

import UIKit

extension UIColor {
    
    open class var blue505975: UIColor {
        return UIColor(hex: "#505975")
    }
    
    open class var grayD7D7D7: UIColor {
        return UIColor(hex: "#D7D7D7")
    }
    
    open class var grayE2E2E2: UIColor {
        return UIColor(hex: "#E2E2E2")
    }
    
    open class var green133433: UIColor {
        return UIColor(hex: "#133433")
    }
    
    open class var black101112: UIColor {
        return UIColor(hex: "#101112")
    }
    
    open class var gray383838: UIColor {
        return UIColor(hex: "#383838")
    }
    
    open class var black17181A: UIColor {
        return UIColor(hex: "#17181A")
    }
    
    open class var black1E2125: UIColor {
        return UIColor(hex: "#1E2125")
    }
    
    open class var pinkC700B0: UIColor {
        return UIColor(hex: "#db8fd2")
    }
}

extension UIColor {
    
    open class var CGBlackScaleDownTop: [CGColor] {
        return [UIColor.black.withAlphaComponent(0.0).cgColor,
                UIColor.black.withAlphaComponent(0.1).cgColor,
                UIColor.black.withAlphaComponent(0.3).cgColor,
                UIColor.black.withAlphaComponent(0.6).cgColor,]
    }
    
    open class var CGBlackScaleTopDown: [CGColor] {
        return [UIColor.black.withAlphaComponent(0.6).cgColor,
                UIColor.black.withAlphaComponent(0.3).cgColor,
                UIColor.black.withAlphaComponent(0.1).cgColor,
                UIColor.black.withAlphaComponent(0.0).cgColor,]
    }
}

extension UIColor {
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex.replacingOccurrences(of: "#", with: ""))
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff
        self.init(
            red: CGFloat(red) / 0xff,
            green: CGFloat(green) / 0xff,
            blue: CGFloat(blue) / 0xff, alpha: 1
        )
    }
}
