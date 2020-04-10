//
//  UserResult+CoreDataProperties.swift
//  EmojiSweeper
//
//  Created by Dima Krupskyi on 09.04.2020.
//  Copyright © 2020 Dima Krupskyi. All rights reserved.
//
//

import Foundation
import CoreData


extension UserResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserResult> {
        return NSFetchRequest<UserResult>(entityName: "UserResult")
    }

    @NSManaged public var date: Date?
    @NSManaged public var level: Int16
    @NSManaged public var timeInSeconds: Int16
    
    var timeString: String? {
        return String(stopWatchFormat: TimeInterval(timeInSeconds))
    }
    
    var dateString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        guard let date = date else { return nil }
        return dateFormatter.string(from: date)
    }
    
}
