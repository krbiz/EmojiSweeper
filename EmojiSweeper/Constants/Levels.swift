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
            return "Beginner"
        case .intermediate:
            return "Intermediate"
        case .expert:
            return "Expert"
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
            return GameSettings(rows: 13, colums: 12, mineCount: 20)
        case .expert:
            return GameSettings(rows: 19, colums: 14, mineCount: 50)
        }
    }
    
}
