//
//  DefaultViewModel.swift
//  JZCalendarViewExample
//
//  Created by Jeff Zhang on 3/4/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit
import JZCalendarWeekView
import SwiftyJSON

class DefaultViewModel: NSObject {
    
    
    private let firstDate = myDate?.add(component: .day, value: 0)
    private let secondDate = myDate?.add(component: .day, value: 1)
    private let thirdDate = myDate?.add(component: .day, value: 2)
    
    

    
//    lazy var events = [DefaultEvent(id: "0", type: "dog_tv", startDate: firstDate!, endDate: firstDate!.add(component: .hour, value: 1), duration: 0),
//                       DefaultEvent(id: "1", type: "pawcall_game", startDate: secondDate!, endDate: secondDate!.add(component: .hour, value: 4), duration:0),
//                       DefaultEvent(id: "2", type: "pawcall_call", startDate: thirdDate!, endDate: thirdDate!.add(component: .hour, value: 2), duration: 0),
//                       DefaultEvent(id: "3", type: "petwatch", startDate: thirdDate!, endDate: thirdDate!.add(component: .hour, value: 3), duration: 0)]
    
    lazy var events = [
                       DefaultEvent(id: "3", type: "petwatch", startDate: thirdDate!, endDate: thirdDate!.add(component: .hour, value: 3), duration: 0)]
    
    lazy var eventsByDate = JZWeekViewHelper.getIntraEventsByDate(originalEvents: events)
    
    
    
    var currentSelectedData: OptionsSelectedData!

}
