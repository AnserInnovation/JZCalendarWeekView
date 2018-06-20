//
//  DefaultEvent.swift
//  JZCalendarWeekViewExample
//
//  Created by Jeff Zhang on 30/5/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation
import JZCalendarWeekView

class DefaultEvent: JZBaseEvent {
    
    var duration: Int
    var type: String
        
    init(id: String, type: String, startDate: Date, endDate: Date, duration: Int) {
        self.duration = duration
        self.type = type
        
        // If you want to have you custom uid, you can set the parent class's id with your uid or UUID().uuidString (In this case, we just use the base class id)
        super.init(id: id, startDate: startDate, endDate: endDate)
    }
    
    
    override func copy(with zone: NSZone?) -> Any {
        return DefaultEvent(id: id, type: type, startDate: startDate, endDate: endDate, duration: duration)
    }
}




