//
//  Levels.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 07.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import Foundation

enum Level {
    case beginner
    case intermediate
    case expert
}

struct LevelSettings {
    let rows: Int
    let colums: Int
    let mineCount: Int
    
    static func settings(_ level: Level) -> LevelSettings {
        switch level {
        case .beginner:
            return LevelSettings(rows: 9, colums: 9, mineCount: 10)
        case .intermediate:
            return LevelSettings(rows: 13, colums: 12, mineCount: 20)
        case .expert:
            return LevelSettings(rows: 19, colums: 14, mineCount: 50)
        }
    }
    
}
