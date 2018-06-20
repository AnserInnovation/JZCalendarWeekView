//
//  EventDetailViewController.swift
//  JZCalendarWeekViewExample
//
//  Created by DA SONG on 6/12/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

protocol EventUpdateDelegate: class {
    func updateEvents(events: [DefaultEvent])
}

class EventDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var TypePickerView: UIPickerView!
    @IBOutlet weak var StartPickerView: UIDatePicker!
    @IBOutlet weak var EndPickerView: UIDatePicker!
    @IBOutlet weak var WeekdayLabel: UILabel!
    @IBOutlet weak var ConfirmButton: UIButton!
    
    weak var delegate: EventUpdateDelegate?
    var startString: String = ""
    var endString: String = ""
    var startTime: Date = Date()
    var endTime: Date = Date()
    var viewModel = DefaultViewModel()
    var NewEvent: DefaultEvent? = nil
    var event: DefaultEvent? = nil
    let calendarCurrent = Calendar.current
    let dateFormatter = DateFormatter()
    
    var AllEvents = DefaultViewModel().events
    var eventId = 0
    
    var DaEvents: Events!
    
    var newType: String = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TypePickerView.delegate = self
        TypePickerView.dataSource = self
        
        
        dateFormatter.timeZone = TimeZone(abbreviation: "CDT")
        let weekday = calendarCurrent.component(.weekday, from: (event?.startDate)!) - 1
        WeekdayLabel.text = dateFormatter.weekdaySymbols[weekday].uppercased()
        startTime = (event?.startDate)!
        endTime = (event?.endDate)!
        self.StartPickerView.setDate(startTime, animated: true)
        self.EndPickerView.setDate(endTime, animated: true)
        newType = (event?.type)!
        var count = 0
        for e in AllEvents {
            if (e.type == event?.type) {
                print(e.type, count)
                break
            }
            count += 1
        }
        self.TypePickerView.selectRow(count, inComponent: 0, animated: true)
        self.TypePickerView.reloadAllComponents()

        eventList = AllEvents
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AllEvents.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return AllEvents[row].type
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        index = row
    }
    
    func updateSettingEvent(events: [DefaultEvent], NeweventType: String, startDate: Date, endDate: Date) {
        if (event != nil) {
            
            
        } else {
            //create new event
            //add event to eventlist
        }
        
        for e in events {            
            //TODO: check for optional
            if e.id == event!.id {
                e.type = NeweventType
                if (startDate < endDate) {
                    e.startDate = startDate
                    e.endDate = endDate
                } else {
                    
                }
                continue
            }
        }
        delegate?.updateEvents(events: eventList)
    }
    

    func HandleCrossDayEvent(start: Date, end: Date) -> Date {
        if (start > end) {
            let newEnd = end.add(component: .hour, value: 24)
            return newEnd
        } else {
            return end
        }
    }
    
    
    @IBAction func GoBackToWeeView(_ sender: Any) {
//        endTime = HandleCrossDayEvent(start: startTime, end: endTime)
        updateSettingEvent(events: eventList, NeweventType: AllEvents[index].type, startDate: startTime, endDate: endTime)
        
        for e in eventList {
            print(e.startDate, e.type, e.endDate)
        }
        self.goBack()
    }
    @IBAction func StartTimePicker(_ sender: UIDatePicker) {
        let componenets = Calendar.current.dateComponents([.hour, .minute], from: sender.date)
        if let minute = componenets.minute, let hour = componenets.hour {
            
            print("start: ", calendarCurrent.component(.hour, from: (event?.startDate)!), hour)
            
            // Calculate the offset of eventcell
            let firstDate = (event?.startDate)!.add(component: .hour, value: hour - calendarCurrent.component(.hour, from: (event?.startDate)!)).add(component: .minute, value: minute - calendarCurrent.component(.minute, from: (event?.startDate)!))
//            let conv = dateFormatter.date(from: String(firstDate))
            startTime = firstDate
            startString = String(hour) + ":" + String(minute)
            print(startString)
        }
    }
    @IBAction func EndTimePicker(_ sender: UIDatePicker) {
        let componenets = Calendar.current.dateComponents([.hour, .minute], from: sender.date)
        
        if let minute = componenets.minute, let hour = componenets.hour {
            print("end: ", calendarCurrent.component(.hour, from: (event?.endDate)!), hour)
            let secDate = (event?.endDate)!.add(component: .hour, value: hour - calendarCurrent.component(.hour, from: (event?.endDate)!)).add(component: .minute, value: minute - calendarCurrent.component(.minute, from: (event?.endDate)!))
//            let conv =
            endTime = secDate
            print("EndDate: ", endTime)
            endString = String(hour) + ":" + String(minute)
            print(endString)
        }
    }
}
