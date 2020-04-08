//
//  GameFieldView.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 05.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import UIKit

class GameFieldView: UIView {
    
    private var gameField: GameField!
    private var squareButtons = [SquareButton]()
    private var gameIsStarted = false
    
    weak var delegate: GameFieldDelegate?
    
    // MARK: - Initializations
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Setup methods
    
    func setupView(with rows: Int, columns: Int, mineCount: Int) {
        
        gameField = GameField(rows: rows, columns: columns, mineCount: mineCount)
        
        let width = self.bounds.width
        let height = self.bounds.height

        let squareWidth = min(width / CGFloat(columns), height / CGFloat(rows))
        
        let leftInset = (width - squareWidth * CGFloat(columns)) / 2
        let topInset = (height - squareWidth * CGFloat(rows)) / 2
        
        // Add square buttons to the view
        for i in 0..<rows {
            for j in 0..<columns {
                let x = squareWidth * CGFloat(j) + leftInset
                let y = squareWidth * CGFloat(i) + topInset
                let frame = CGRect(x: x, y: y, width: squareWidth, height: squareWidth)
                
                let squareButton = SquareButton(frame: frame)
                squareButton.tag = i * columns + j
                
                squareButton.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
                let longPressGesture =
                    UILongPressGestureRecognizer(target: self, action: #selector(longPressButton(_:)))
                longPressGesture.minimumPressDuration = 0.2
                squareButton.addGestureRecognizer(longPressGesture)
                
                self.squareButtons.append(squareButton)
                self.addSubview(squareButton)
            }
        }
        
    }
    
    func reloadView(with rows: Int, columns: Int, mineCount: Int) {
        squareButtons.forEach { square in
            square.removeFromSuperview()
        }
        squareButtons.removeAll()
        isUserInteractionEnabled = true
        gameIsStarted = false
        setupView(with: rows, columns: columns, mineCount: mineCount)
    }
    
    // MARK: - Private methods
    
    private func checkVictory() -> Bool {
        var openButtonsCount = 0
        squareButtons.forEach { button in
            if button.condition == .open {
                openButtonsCount += 1
            }
        }
        let gameFieldSize = gameField.rows * gameField.columns
        return openButtonsCount + gameField.mineCount == gameFieldSize
    }
    
    // Check if square is empty and should be opened
    private func shouldOpenEmptySquare(_ row: Int, _ column: Int) -> Bool {
        let index = row * gameField.columns + column
        
        let indexOutOfRange = row < 0 || column < 0 ||
            row >= gameField.rows || column >= gameField.columns
        
        return !indexOutOfRange &&
               squareButtons[index].condition == .close &&
               !gameField[row, column].isMine
    }
    
    // Open all empty squares nearby
    private func openEmptySquares(_ row: Int, _ column: Int) {
        let index = row * gameField.columns + column
        squareButtons[index].condition = .open
        squareButtons[index].setGradient(with: .black, type: .conic)
        squareButtons[index].isEnabled = false
        
        if gameField.numberOfMines(row, column) > 0 {
            tapButton(squareButtons[index])
            return
        }
        
        squareButtons[index].alpha = 0.5
        
        if shouldOpenEmptySquare(row - 1, column - 1) {
            openEmptySquares(row - 1, column - 1)
        }
        if shouldOpenEmptySquare(row - 1, column) {
            openEmptySquares(row - 1, column)
        }
        if shouldOpenEmptySquare(row - 1, column + 1) {
            openEmptySquares(row - 1, column + 1)
        }
        if shouldOpenEmptySquare(row, column - 1) {
            openEmptySquares(row, column - 1)
        }
        if shouldOpenEmptySquare(row, column + 1) {
            openEmptySquares(row, column + 1)
        }
        if shouldOpenEmptySquare(row + 1, column - 1) {
            openEmptySquares(row + 1, column - 1)
        }
        if shouldOpenEmptySquare(row + 1, column) {
            openEmptySquares(row + 1, column)
        }
        if shouldOpenEmptySquare(row + 1, column + 1) {
            openEmptySquares(row + 1, column + 1)
        }
        
    }
    
    private func mineIsTapped(_ mine: SquareButton) {
        mine.setGradient(with: .red, type: .conic)
        mine.setTitle(Emoji.mine.rawValue, for: .normal)
        
        for (index, square) in gameField.grid.enumerated() {
            let squareButton = squareButtons[index]
            if square.isMine && squareButton !== mine {
                squareButton.setTitle(Emoji.mine.rawValue, for: .normal)
            }
        }
        
        isUserInteractionEnabled = false
        
        // Finish Game Delegate method is calling
        delegate?.finishGame(self, isWinner: false)
    }
    
    // MARK: - Button actions
    
    @objc private func tapButton(_ sender: SquareButton) {
        let square = sender
        
        // User can't open square accidentally if flag exists
        if square.condition == .flag { return }
        
        square.isEnabled = false
        let index = square.tag
        if gameField.grid[index].isMine {
            mineIsTapped(square)
            return
        }
        
        let numberOfMines = gameField.numberOfMines(index: index)
        
        if numberOfMines == 0 {
            let row = index / gameField.columns
            let column = index % gameField.columns
            openEmptySquares(row, column)
        } else {
            square.setGradient(with: .color(of: numberOfMines), type: .conic)
            square.setTitle("\(numberOfMines)", for: .normal)
            square.condition = .open
        }
        
        // Start Game Delegate method is calling
        if !gameIsStarted {
            gameIsStarted = true
            delegate?.startGame(self)
        }
        
        // Finish Game Delegate method is calling
        if checkVictory() {
            delegate?.finishGame(self, isWinner: true)
        }
    }
    
    @objc private func longPressButton(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began && gameIsStarted {
            
            // Taptic vibration feedback
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            
            guard let square = sender.view as? SquareButton else { return }
            if square.condition == .flag {
                square.setTitle(nil, for: .normal)
                square.condition = .close
                delegate?.removeFlag?(self)
            } else {
                square.setTitle(Emoji.flag.rawValue, for: .normal)
                square.condition = .flag
                delegate?.addFlag?(self)
            }
        }
    }
    
    deinit {
        print("deinit: \(type(of: self))")
    }
    
}
