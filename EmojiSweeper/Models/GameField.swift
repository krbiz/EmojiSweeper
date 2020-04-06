//
//  GameField.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 05.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import Foundation

struct GameField {
    
    let rows: Int
    let columns: Int
    
    var grid = [Square]()
    let mineCount: Int
    
    subscript(row: Int, column: Int) -> Square {
        return grid[row * columns + column]
    }
    
    // MARK: - Initializations
    
    init(rows: Int, colums: Int, mineCount: Int) {
        self.rows = rows
        self.columns = colums
        self.mineCount = mineCount
        
        setupGrid()
    }
    
    // MARK: - Setup methods
    
    private mutating func setupGrid() {
        // Create elements of array
        for _ in 0..<(rows * columns) {
            grid.append(Square())
        }
        
        // Add mines to the game
        var minesLeft = mineCount
        while minesLeft != 0 {
            let index = Int.random(in: 0..<grid.count)
            if grid[index].isMine { continue }
            grid[index].isMine = true
            minesLeft -= 1
        }
    }
    
    // MARK:  - Public methods
    
    // Calculate number of mines in the square
    func numberOfMines(_ row: Int, _ column: Int) -> Int {
        var minesCount = 0
        
        if isMine(row - 1, column - 1) {
            minesCount += 1
        }
        if isMine(row - 1, column) {
            minesCount += 1
        }
        if isMine(row - 1, column + 1) {
            minesCount += 1
        }
        if isMine(row, column - 1) {
            minesCount += 1
        }
        if isMine(row, column + 1) {
            minesCount += 1
        }
        if isMine(row + 1, column - 1) {
            minesCount += 1
        }
        if isMine(row + 1, column) {
            minesCount += 1
        }
        if isMine(row + 1, column + 1) {
            minesCount += 1
        }
        
        return minesCount
    }
    
    // Calculate number of mines of squeare index
    func numberOfMines(index: Int) -> Int {
        let row = index / columns
        let column = index % columns
        return numberOfMines(row, column)
    }
    
    // MARK: - Private methods
    
    // Check if a square is mine
    private func isMine(_ row: Int, _ column: Int) -> Bool {
        if row < 0 || column < 0 || row >= rows || column >= columns {
            return false
        }
        return self[row, column].isMine
    }
    
}
