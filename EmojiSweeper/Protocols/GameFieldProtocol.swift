//
//  GameFieldProtocol.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 06.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import Foundation

@objc protocol GameFieldDelegate {
    
    func startGame(_ fieldView: GameFieldView)
    func finishGame(_ fieldView: GameFieldView, isWinner: Bool)

    @objc optional func addFlag(_ fieldView: GameFieldView)
    @objc optional func removeFlag(_ fieldView: GameFieldView)
}
