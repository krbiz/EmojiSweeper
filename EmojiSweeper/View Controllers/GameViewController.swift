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
    
    var levelSettings = LevelSettings.settings(.beginner)
    
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
    var fartSoundEffect: AVAudioPlayer?
    
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
    
    override func viewWillLayoutSubviews() {
        gradientBG?.frame = self.view.bounds
    }
    
    func setupUI() {
        mineCountLeft = levelSettings.mineCount
        
        // Setup fieldView
        fieldView.setupView(with: levelSettings.rows,
                            columns: levelSettings.colums,
                            mineCount: levelSettings.mineCount)
        fieldView.delegate = self
        
        // Add background gradient
        gradientBG = CAGradientLayer()
        gradientBG?.startPoint = CGPoint(x: 0, y: 0)
        gradientBG?.endPoint = CGPoint(x: 0, y: 1)
        setGreyBackgroundGradient()
        self.view.layer.insertSublayer(gradientBG!, at: 0)
        
        // Setup Segmented Control
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        
        // Setup fart sound effect
        if let bundle = Bundle.main.path(forResource: "Fart", ofType: "m4a") {
            let url = URL(fileURLWithPath: bundle)
            fartSoundEffect = try? AVAudioPlayer(contentsOf: url)
        }
    }
    
    func restartGame() {
        navigationItem.title = Emoji.cool.rawValue
        mineCountLeft = levelSettings.mineCount
        secondsInGame = 0
        setGreyBackgroundGradient()
        timer?.invalidate()
        fieldView.reloadView(with: levelSettings.rows,
                             columns: levelSettings.colums,
                             mineCount: levelSettings.mineCount)
    }
    
    // MARK: - Gradient methods

    func setGreyBackgroundGradient() {
        let colors = [UIColor.black.cgColor,
                      UIColor.bgBaseColor.cgColor]
        gradientBG?.updateColorsWithoutAnimation(colors)
    }
    
    func setRedBackgroundGradient() {
        let colors = [UIColor.black.cgColor,
                      UIColor.bgRedColor.cgColor,
                      UIColor.black.cgColor]
        gradientBG?.updateColorsWithoutAnimation(colors)
    }
    
    func setGreenBackgroundGradient() {
        let colors = [UIColor.black.cgColor,
                      UIColor.bgGreenColor.cgColor,
                      UIColor.black.cgColor]
        gradientBG?.updateColorsWithoutAnimation(colors)
    }
    
    // MARK: - IB Actions
    
    @IBAction func actionRestartGame(_ sender: UIBarButtonItem) {
        restartGame()
    }
    
    @IBAction func actionChangeGameLevel(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            levelSettings = LevelSettings.settings(.beginner)
        case 1:
            levelSettings = LevelSettings.settings(.intermediate)
        case 2:
            levelSettings = LevelSettings.settings(.expert)
        default:
            return
        }
        
        restartGame()
    }
    
}

// MARK: - GameField Delegate

extension GameViewController: GameFieldDelegate {
    
    func startGame(_ fieldView: GameFieldView) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.secondsInGame += 1
        })
    }
    
    func finishGame(_ fieldView: GameFieldView, isWinner: Bool) {
        timer?.invalidate()
        if isWinner {
            navigationItem.title = Emoji.party.rawValue
            setGreenBackgroundGradient()
        } else {
            fartSoundEffect?.play()
            navigationItem.title = Emoji.dizzy.rawValue
            setRedBackgroundGradient()
        }
    }
    
    func addFlag(_ fieldView: GameFieldView) {
        mineCountLeft -= 1
    }
    
    func removeFlag(_ fieldView: GameFieldView) {
        mineCountLeft += 1
    }
    
}
