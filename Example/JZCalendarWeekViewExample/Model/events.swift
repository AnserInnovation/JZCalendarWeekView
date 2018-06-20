//
//  events.swift
//  JZCalendarWeekViewExample
//
//  Created by DA SONG on 6/11/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation
import SwiftyJSON

class Events : Codable {
    var id: String
    var type: String
    var weekday: Int
    var start: String
    var end: String
    var duration: Int
    

    init(eventsJson: JSON) {
        self.id = eventsJson["id"].stringValue
        self.type = eventsJson["type"].stringValue
        self.weekday = eventsJson["weekday"].intValue
        self.start = eventsJson["start"].stringValue
        self.end = eventsJson["end"].stringValue
        self.duration = eventsJson["duration"].intValue
    }
    
    init(id: String, type: String, weekday: Int, start: String, end: String, duration: Int) {
        self.id = id
        self.type = type
        self.weekday = weekday
        self.start = start
        self.duration = duration
        self.end = end
    }
    
    func formatToJSON () -> JSON {
        let dict = ["id":self.id, "type":self.type,
                    "weekday":self.weekday,
                    "start":self.start,
                    "end":self.end,
                    "duration":self.duration] as [String : Any]
        return JSON(dict)
    }
}
