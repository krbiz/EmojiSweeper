//
//  String+extension.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 10.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import Foundation

extension String {
    init(stopWatchFormat timeInterval: TimeInterval) {
        self.init()
        let formatter = DateFormatter()
        formatter.dateFormat = timeInterval >= 3600 ? "H:mm:ss" : "m:ss"
        self = formatter.string(from: Date(timeIntervalSinceReferenceDate: timeInterval))
    }
}
