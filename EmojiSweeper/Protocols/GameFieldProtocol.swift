//
//  GameFieldProtocol.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 06.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import Foundation

@objc protocol GameFieldDelegate {
    
    func startGame(_ view: GameFieldView)
    func finishGame(_ view: GameFieldView)

    @objc optional func addFlag(_ view: GameFieldView)
    @objc optional func removeFlag(_ view: GameFieldView)
}
