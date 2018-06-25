//
//  global.swift
//  JZCalendarWeekViewExample
//
//  Created by DA SONG on 6/15/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation
import SwiftyJSON


let dateComponents = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: 2018, month: 6, day: 18, hour: 10, minute: 30)
let myDate = Calendar.current.date(from: dateComponents)

var DaEveList = [Events]()
var eventList = [DefaultEvent]()
var NeweventList = [DefaultEvent]()
let allEventTypes = ["Dog_TV", "Paw_Call_Call", "Paw_Call_Game", "Petwatch"]

// Backend start from 0
var testEventsJson = Events(id: "10", type: "Dog_TV", weekday: 2, start: "11:15", end: "13:15", duration: 60).formatToJSON()
var testEventsJson2 = Events(id: "11", type: "Paw_Call_Call", weekday: 1, start: "13:15", end: "12:15", duration: 120).formatToJSON()
var testEventsJson3 = Events(id: "12", type: "Paw_Call_Game", weekday: 3, start: "12:15", end: "15:15", duration: 180).formatToJSON()

var AllJsonevents:JSON = [testEventsJson,testEventsJson2, testEventsJson3]

let SendedJson = PZEvent(Deviceid: 1, events: AllJsonevents).formatToJSON()

let PZSchedule = PZEvent.init(jsonPZE: SendedJson)


let AllEventsJson = PZSchedule.events.arrayValue

var allEventsArr = [Events]()






