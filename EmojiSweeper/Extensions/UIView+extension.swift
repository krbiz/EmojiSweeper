//
//  UIView+extension.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 08.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import UIKit

extension UIView {
    
    func setGradient(with color: UIColor, type: CAGradientLayerType, isSymmetricalEdges: Bool = true) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        var gradient = self.layer.sublayers?.first as? CAGradientLayer
        
        if gradient == nil {
            gradient = CAGradientLayer()
            gradient?.startPoint = CGPoint(x: 0, y: 0)
            gradient?.endPoint = CGPoint(x: 0, y: 1)
            self.layer.insertSublayer(gradient!, at: 0)
        }
        
        var colors = [UIColor.black.cgColor, color.cgColor]
        if isSymmetricalEdges {
            colors = colors.reversed() + [color.cgColor]
        }
        
        gradient?.frame = self.bounds
        gradient?.type = type
        gradient?.colors = colors
        
        CATransaction.commit()
    }
    
}
