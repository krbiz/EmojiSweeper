//
//  ViewController.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 05.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var rows = 9
    var columns = 9
    var mineCount = 10
    
    var mineCountLeft = 0 {
        didSet {
            let mines = mineCountLeft > 0 ? mineCountLeft : 0
            minesLeftCountLabel.text = "\(mines)"
        }
    }
    
    var secondsInGame = 0 {
        didSet {
            let minutes = secondsInGame / 60
            let seconds = secondsInGame % 60
            timerLabel.text = String(format: "%01i:%02i", minutes, seconds)
        }
    }
    
    var timer: Timer?
    var gradientBG: CAGradientLayer?
    
    @IBOutlet weak var fieldView: GameFieldView!
    @IBOutlet weak var minesLeftInfoLabel: UILabel!
    @IBOutlet weak var minesLeftCountLabel: UILabel!
    @IBOutlet weak var timerInfoLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        fieldView.setupGame(rows: rows, columns: columns, mineCount: mineCount)
        fieldView.delegate = self
    }
    
    private func setupUI() {
        mineCountLeft = mineCount
        
        // Add background gradient
        gradientBG = CAGradientLayer()
        gradientBG?.startPoint = CGPoint(x: 0, y: 0)
        gradientBG?.endPoint = CGPoint(x: 0, y: 1)
        setGreyBackgroundGradient()
        
        self.view.layer.insertSublayer(gradientBG!, at: 0)
    }
    
    override func viewWillLayoutSubviews() {
        gradientBG?.frame = self.view.bounds
    }
    
    
    @IBAction func restartGame(_ sender: UIBarButtonItem) {
        navigationItem.title = Emoji.cool.rawValue
        mineCountLeft = mineCount
        secondsInGame = 0
        setGreyBackgroundGradient()
        fieldView.restartGame(rows: rows, columns: columns, mineCount: mineCount)
    }
    
    // MARK: - Gradient methods

    func setGreyBackgroundGradient() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        gradientBG?.colors = [UIColor.black.cgColor, UIColor.bgBaseColor.cgColor]
        
        CATransaction.commit()
    }
    
    func setRedBackgroundGradient() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        gradientBG?.colors = [UIColor.black.cgColor,
        UIColor.bgRedColor.cgColor,
        UIColor.black.cgColor]
        
        CATransaction.commit()
    }
    
}

// MARK:  - GameField Delegate

extension GameViewController: GameFieldDelegate {
    
    func startGame(_ veiw: GameFieldView) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.secondsInGame += 1
        })
    }
    
    func finishGame(_ view: GameFieldView) {
        timer?.invalidate()
        navigationItem.title = Emoji.dizzy.rawValue
        setRedBackgroundGradient()
    }
    
    func addFlag(_ view: GameFieldView) {
        mineCountLeft -= 1
    }
    
    func removeFlag(_ view: GameFieldView) {
        mineCountLeft += 1
    }
    
}
