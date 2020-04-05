//
//  GameField.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 05.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import Foundation

class GameField {
    
    let rows: Int
    let columns: Int
    
    var grid = [Square]()
    let mineCount: Int
    
    subscript(row: Int, column: Int) -> Square {
        return grid[row * column + column]
    }
    
    // MARK: - Initializations
    
    init(colums: Int, rows: Int, mineCount: Int) {
        self.columns = colums
        self.rows = rows
        self.mineCount = mineCount
        
        setupGrid()
    }
    
    // MARK: - Setup methods
    
    private func setupGrid() {
        
        // Create elements of array
        for _ in 0..<(columns * rows) {
            grid.append(Square())
        }
        
        // Add mines to array
        var minesLeft = mineCount
        while minesLeft != 0 {
            let index = Int.random(in: 0..<grid.count)
            if grid[index].isMine { continue }
            grid[index].isMine = true
            minesLeft -= 1
        }
    }
    
}
