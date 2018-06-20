//
//  global.swift
//  JZCalendarWeekViewExample
//
//  Created by DA SONG on 6/15/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import Foundation
import SwiftyJSON


let dateComponents = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: 2018, month: 6, day: 19, hour: 10, minute: 30)
let myDate = Calendar.current.date(from: dateComponents)

var DaEveList = [Events]()
var eventList = [DefaultEvent]()

var testEventsJson = Events(id: "10", type: "Dog_TV", weekday: 2, start: "21:15", end: "22:15", duration: 60).formatToJSON()
var testEventsJson2 = Events(id: "11", type: "Paw_Call_Call", weekday: 1, start: "21:15", end: "23:15", duration: 120).formatToJSON()
var testEventsJson3 = Events(id: "12", type: "Paw_Call_Game", weekday: 3, start: "20:15", end: "23:15", duration: 180).formatToJSON()

var AllJsonevents:JSON = [testEventsJson,testEventsJson2, testEventsJson3]

let SendedJson = PZEvent(Deviceid: 1, events: AllJsonevents).formatToJSON()

//let eventsDa: Events = try! JSONDecoder().decode(Events.self, from: pze.formatToJSON().rawData())

let PZSchedule = PZEvent.init(jsonPZE: SendedJson)


let AllEventsJson = PZSchedule.events.arrayValue

var allEventsArr = [Events]()



let testComp = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, hour: 10, minute: 30, weekday:3)




