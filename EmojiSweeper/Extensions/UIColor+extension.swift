//
//  UIColor+extention.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 06.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import UIKit

extension UIColor {
    
    // Color of buttonSquares
    class var baseColor:   UIColor { return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) }
    class var mines1Color: UIColor { return #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1) }
    class var mines2Color: UIColor { return #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1) }
    class var mines3Color: UIColor { return #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1) }
    class var mines4Color: UIColor { return #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1) }
    class var mines5Color: UIColor { return #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1) }
    class var mines6Color: UIColor { return #colorLiteral(red: 0.2371136924, green: 0.1834465145, blue: 0.3019607961, alpha: 1) }
    class var mines7Color: UIColor { return #colorLiteral(red: 0.6131424492, green: 0.1845548218, blue: 0.4953712207, alpha: 1) }
    class var mines8Color: UIColor { return #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1) }
    
    // Color of background view
    class var bgBaseColor:  UIColor { return #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1) }
    class var bgRedColor:   UIColor { return #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1) }
    class var bgGreenColor: UIColor { return #colorLiteral(red: 0.1623920798, green: 0.6246709228, blue: 0.09199859947, alpha: 1) }
    
    // Get background color of square depends of mines count
    class func color(of mines: Int) -> UIColor {
        switch mines {
        case 0:
            return UIColor.baseColor
        case 1:
            return UIColor.mines1Color
        case 2:
            return UIColor.mines2Color
        case 3:
            return UIColor.mines3Color
        case 4:
            return UIColor.mines4Color
        case 5:
            return UIColor.mines5Color
        case 6:
            return UIColor.mines6Color
        case 7:
            return UIColor.mines7Color
        case 8:
            return UIColor.mines8Color
        default:
            return UIColor.baseColor
        }
    }
    
}
