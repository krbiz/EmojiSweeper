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
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.setGradient(with: .baseColor, type: .conic)
        self.titleLabel?.font = UIFont.systemFont(ofSize: bounds.size.width / 1.5)
    }

}
