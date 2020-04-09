//
//  CoreDataManager.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 09.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    private static var context =
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func getResults() -> [UserResult]? {
        let fetchRequest: NSFetchRequest<UserResult> = UserResult.fetchRequest()
        
        let timeSort = NSSortDescriptor(key: "timeInSeconds", ascending: true)
        let dateSort = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [timeSort, dateSort]
        
        do {
            let data = try context.fetch(fetchRequest)
            return data
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func saveResult(timeInSeconds: Int, level: Level) {
        let result = UserResult(context: context)
        result.level = Int16(level.rawValue)
        result.timeInSeconds = Int16(timeInSeconds)
        result.date = Date()
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    static func removeAllResults() {
        let deleteFetch: NSFetchRequest<NSFetchRequestResult> = UserResult.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
