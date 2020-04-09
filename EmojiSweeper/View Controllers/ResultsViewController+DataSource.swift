//
//  ResultsViewController+DataSource.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 09.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import UIKit

extension ResultsViewController {
    
    func setupDataSource() {
        if let data = CoreDataManager.getResults() {
            results = data
        }
        for level in Level.allCases
            where quantity(forLevel: level) > 0 {
                levels.append(level)
        }
    }
    
    func quantity(forLevel level: Level) -> Int {
        var quantity = 0
        for result in results
            where result.level == level.rawValue {
                quantity += 1
        }
        return quantity
    }
    
    func result(forIndexPath indexPath: IndexPath) -> UserResult {
        let currentLevelIndex = levels[indexPath.section].rawValue
        let resultsForLevel = results.filter { Int($0.level) == currentLevelIndex }
        return resultsForLevel[indexPath.row]
    }
    
    func setupInputData() {
        CoreDataManager.saveResult(timeInSeconds: 10, level: .beginner)
        CoreDataManager.saveResult(timeInSeconds: 20, level: .beginner)
        CoreDataManager.saveResult(timeInSeconds: 30, level: .beginner)
        CoreDataManager.saveResult(timeInSeconds: 10, level: .beginner)
        CoreDataManager.saveResult(timeInSeconds: 20, level: .beginner)
        CoreDataManager.saveResult(timeInSeconds: 30, level: .beginner)
    }
    
    func removeAllData() {
        results = [UserResult]()
        levels = [Level]()
        CoreDataManager.removeAllResults()
    }
 
}


