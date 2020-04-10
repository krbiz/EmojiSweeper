//
//  Levels.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 07.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import Foundation

enum Level: Int, CaseIterable {
    
    case beginner
    case intermediate
    case expert
    
    var description: String {
        switch self {
        case .beginner:
            return NSLocalizedString("Beginner", comment: "")
        case .intermediate:
            return NSLocalizedString("Intermediate", comment: "")
        case .expert:
            return NSLocalizedString("Expert", comment: "")
        }
    }
    
}

struct GameSettings {
    
    let rows: Int
    let colums: Int
    let mineCount: Int
    
    static func settings(_ level: Level) -> GameSettings {
        switch level {
        case .beginner:
            return GameSettings(rows: 9, colums: 9, mineCount: 10)
        case .intermediate:
            return GameSettings(rows: 12, colums: 12, mineCount: 20)
        case .expert:
            return GameSettings(rows: 15, colums: 14, mineCount: 40)
        }
    }
    
}
