//
//  CATransaction+extension.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 08.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    func updateColorsWithoutAnimation(_ colors: [CGColor]) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.colors = colors
        CATransaction.commit()
    }
    
}
