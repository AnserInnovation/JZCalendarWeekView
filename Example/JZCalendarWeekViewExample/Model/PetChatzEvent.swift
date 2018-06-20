//
//  PetChatzEvent.swift
//  JZCalendarWeekViewExample
//
//  Created by DA SONG on 6/11/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation
import SwiftyJSON


class PZEvent : Codable{
    let Deviceid: Int
    var events: JSON
    
    init(jsonPZE:JSON) {
        self.Deviceid = jsonPZE["Deviceid"].intValue
        self.events = jsonPZE["events"]
        
    }
    
    init(Deviceid: Int, events: JSON) {
        self.Deviceid = Deviceid
        self.events = events
    }
    

    
    func formatToJSON () -> JSON {
        let dict = ["Deviceid": self.Deviceid,
                    "events": self.events] as [String : Any]
        return JSON(dict)
    }
}
