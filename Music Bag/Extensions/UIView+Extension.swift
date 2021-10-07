//
//  UIView+Extension.swift
//  Music Bag
//
//  Created by Premier on 04/10/21.
//

import UIKit

extension UIView {
    
    func addShadow(shadowOpacity: Float, shadowRadius: CGFloat, with bezierPath: UIBezierPath? = nil) {
        self.layer.shadowPath = bezierPath != nil ? bezierPath?.cgPath : self.layer.accessibilityPath?.cgPath
        self.layer.shouldRasterize = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = shadowRadius
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
