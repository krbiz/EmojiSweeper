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
    let mineCount: Int
    
    var grid: [Square]
    
    subscript(row: Int, column: Int) -> Square {
        return grid[row * columns + column]
    }
    
    // MARK: - Initializations
    
    init(rows: Int, columns: Int, mineCount: Int) {
        
        guard rows > 0 && columns > 0 else {
            fatalError("Invalid field size")
        }
        guard mineCount <= rows * columns else {
            fatalError("Invalid mines count")
        }
        
        self.rows = rows
        self.columns = columns
        self.mineCount = mineCount
        
        self.grid = Array(repeating: Square(), count: rows * columns)
        
        setupGrid()
    }
    
    // MARK: - Setup methods
    
    private mutating func setupGrid() {
        // Add mines to the grid
        var minesLeft = mineCount
        while minesLeft != 0 {
            let index = Int.random(in: 0..<grid.count)
            if grid[index].isMine { continue }
            grid[index].isMine = true
            minesLeft -= 1
        }
    }
    
    // MARK: - Public methods
    
    // Calculate number of mines around the square
    func numberOfMines(_ row: Int, _ column: Int) -> Int {
        var minesCount = 0
        
        if squareIsMine(row - 1, column - 1) {
            minesCount += 1
        }
        if squareIsMine(row - 1, column) {
            minesCount += 1
        }
        if squareIsMine(row - 1, column + 1) {
            minesCount += 1
        }
        if squareIsMine(row, column - 1) {
            minesCount += 1
        }
        if squareIsMine(row, column + 1) {
            minesCount += 1
        }
        if squareIsMine(row + 1, column - 1) {
            minesCount += 1
        }
        if squareIsMine(row + 1, column) {
            minesCount += 1
        }
        if squareIsMine(row + 1, column + 1) {
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
    
    private func indexOutOfRange(_ row: Int, _ column: Int) -> Bool {
        return row < 0 || column < 0 || row >= rows || column >= columns
    }
    
    private func squareIsMine(_ row: Int, _ column: Int) -> Bool {
        return !indexOutOfRange(row, column) && self[row, column].isMine
    }
    
}
