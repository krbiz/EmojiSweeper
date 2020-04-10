//
//  ViewController.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 05.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    var level = Level.beginner
    
    var levelSettings: GameSettings {
        return GameSettings.settings(level)
    }
    
    var mineCountLeft = 0 {
        didSet {
            let mines = mineCountLeft > 0 ? mineCountLeft : 0
            minesLeftCountLabel.text = "\(mines)"
        }
    }
    
    var secondsInGame = 0 {
        didSet {
            timerLabel.text = String(stopWatchFormat: TimeInterval(secondsInGame))
        }
    }
    
    var timer: Timer?
    var isGameFinished = false
    
    @IBOutlet weak var fieldView: GameFieldView!
    @IBOutlet weak var minesLeftInfoLabel: UILabel!
    @IBOutlet weak var minesLeftCountLabel: UILabel!
    @IBOutlet weak var timerInfoLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup methods
    
    func setupUI() {
        mineCountLeft = levelSettings.mineCount
        
        // Setup fieldView
        fieldView.setupView(with: levelSettings.rows,
                            columns: levelSettings.colums,
                            mineCount: levelSettings.mineCount)
        fieldView.delegate = self
        
        // Add background gradient
        view.setGradient(with: .bgGrayColor, type: .axial, isSymmetricalEdges: false)
        
        // Setup Segmented Control
        segmentedControl.removeAllSegments()
        for level in Level.allCases.reversed() {
            segmentedControl.insertSegment(withTitle: level.description, at: 0, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        
        // Add TapGestureRecognizer to restart game by tap when game is finished
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(tapViewGestureRecognizer(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func restartGame() {
        navigationItem.title = Emoji.cool.rawValue
        mineCountLeft = levelSettings.mineCount
        secondsInGame = 0
        view.setGradient(with: .bgGrayColor, type: .axial, isSymmetricalEdges: false)
        timer?.invalidate()
        fieldView.reloadView(with: levelSettings.rows,
                             columns: levelSettings.colums,
                             mineCount: levelSettings.mineCount)
    }
    
    
    // MARK: - Actions
    
    @objc func tapViewGestureRecognizer(_ sender: UITapGestureRecognizer) {
        if isGameFinished {
            restartGame()
        }
    }
    
    @IBAction func actionRestartGame(_ sender: UIBarButtonItem) {
        restartGame()
    }
    
    @IBAction func actionChangeGameLevel(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        level = Level(rawValue: index)!
        restartGame()
    }
    
}

// MARK: - GameFieldDelegate

extension GameViewController: GameFieldDelegate {
    
    func startGame(_ fieldView: GameFieldView) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.secondsInGame += 1
        })
    }
    
    func finishGame(_ fieldView: GameFieldView, isWinner: Bool) {
        
        timer?.invalidate()
        isGameFinished = true
        
        if isWinner {
            navigationItem.title = Emoji.party.rawValue
            view.setGradient(with: .bgGreenColor, type: .axial)
            CoreDataManager.saveResult(timeInSeconds: secondsInGame, level: level)
        } else {
            navigationItem.title = Emoji.dizzy.rawValue
            view.setGradient(with: .bgRedColor, type: .axial)
        }
    }
    
    func addFlag(_ fieldView: GameFieldView) {
        mineCountLeft -= 1
    }
    
    func removeFlag(_ fieldView: GameFieldView) {
        mineCountLeft += 1
    }
    
}
