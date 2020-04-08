//
//  SquareButton.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 05.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import UIKit

class SquareButton: UIButton {
    
    // State of squareButton
    enum Condition {
        case close
        case open
        case flag
    }
    
    var condition: Condition = .close
    let gradient = CAGradientLayer()
    
    // Gradient color of squareButton
    var gradientColor = UIColor.baseColor {
        didSet {
            let colors = [gradientColor.cgColor,
                          UIColor.black.cgColor,
                          gradientColor.cgColor]
            gradient.updateColorsWithoutAnimation(colors)
        }
    }
    
    // MARK: - Initializations
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK - Setup methods
    
    private func setup() {
        self.backgroundColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.type = .conic
        gradientColor = .baseColor
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel?.font = UIFont.systemFont(ofSize: bounds.size.width / 1.5)
        gradient.frame = self.bounds
    }

}
