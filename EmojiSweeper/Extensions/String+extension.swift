//
//  String+extension.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 10.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import Foundation

extension String {
    init?(stopWatchFormat timeInterval: TimeInterval) {
        self.init()
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        guard let string = formatter.string(from: TimeInterval(timeInterval)) else { return }
        self = string
    }
}
