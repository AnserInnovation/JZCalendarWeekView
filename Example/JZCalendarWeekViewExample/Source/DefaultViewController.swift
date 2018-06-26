//
//  DefaultViewController.swift
//  JZCalendarViewExample
//
//  Created by Jeff Zhang on 3/4/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit
import JZCalendarWeekView

class DefaultViewController: UIViewController, WeekViewDelegate, EventUpdateDelegate {
    
    
    func updateEvents(events: [DefaultEvent], date: Date) {
     
        self.viewModel.events = events
        setupBasic()
        setupCalendarView(date: date)
        setupNaviBar()
    }
    
    func eventPressed(event: DefaultEvent) {
        FirstLoad = false
        selectedEvent = event
        performSegue(withIdentifier: "EventSetting", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EventSetting") {
            if let viewController = segue.destination as? EventDetailViewController {
                viewController.event = selectedEvent
                viewController.delegate = self
            }
        }
    }
    
    func processJson() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        for e in AllEventsJson {
            allEventsArr.append(Events.init(eventsJson: e))
        }
        
        for e in allEventsArr {
            let startTimeArr = e.start.components(separatedBy: ":")
            let endTimeArr = e.end.components(separatedBy: ":")
            
            let year = Calendar.current.component(.year, from: matchWeekDayToDate(weekday: e.weekday))
            let month = Calendar.current.component(.month, from: matchWeekDayToDate(weekday: e.weekday))
            let day = Calendar.current.component(.day, from: matchWeekDayToDate(weekday: e.weekday))
            let startdateComp = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: year, month: month, day: day, hour: Int(startTimeArr[0]), minute: Int(startTimeArr[1]))
            let enddateComp = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: year, month: month, day: day, hour: Int(endTimeArr[0]), minute: Int(endTimeArr[1]))
        
            let startDate = Calendar.current.date(from: startdateComp)
            let endDate = Calendar.current.date(from: enddateComp)
            
            let firstDate = startDate?.add(component: .day, value: 1)
            let lastDate = endDate?.add(component: .day, value: 1)
            
            newEvent = DefaultEvent(id: e.id, type: e.type, startDate: firstDate!, endDate: lastDate!, duration: e.duration)
            NeweventList.append(newEvent!)
            viewModel.events.append(newEvent!)
        }
    }
 
    @IBOutlet weak var calendarWeekView: DefaultWeekView!
    
    var FirstLoad: Bool = true
    var updateEvents = [DefaultEvent]()
    var selectedEvent: DefaultEvent? = nil
    var viewModel = DefaultViewModel()
    var newEvent: DefaultEvent? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        processJson()
        calendarWeekView.WVdelegate = self
  
        viewModel.eventsByDate = JZWeekViewHelper.getIntraEventsByDate(originalEvents: eventList)
        
        setupBasic()
        setupCalendarView(date: Date())

        setupNaviBar()
        
    }
    
    // Support device orientation change
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        JZWeekViewHelper.viewTransitionHandler(to: size, weekView: calendarWeekView)
    }
    
    private func setupCalendarView(date: Date) {
        let weekday = Calendar.current.component(.weekday, from: date)
        let curdate = matchWeekDayToDate(weekday: weekday)
       
        calendarWeekView.baseDelegate = self
        print("Inside setCal", date, weekday)
        
        // For example only
        if viewModel.currentSelectedData != nil {
            
            setupCalendarViewWithSelectedData(date: date)
            return
        }
        // Basic setup
        viewModel.events = eventList
        if (!FirstLoad) {
            viewModel.eventsByDate = JZWeekViewHelper.getIntraEventsByDate(originalEvents: eventList)
        } else {
            viewModel.eventsByDate = JZWeekViewHelper.getIntraEventsByDate(originalEvents: viewModel.events)
        }
        calendarWeekView.setupCalendar(numOfDays: 1,
                                       setDate: curdate,
                                       allEvents: viewModel.eventsByDate,
                                       scrollType: .pageScroll)
        // Optional
        calendarWeekView.updateFlowLayout(JZWeekViewFlowLayout(hourGridDivision: JZHourGridDivision.noneDiv))
    }
    
    /// For example only
    private func setupCalendarViewWithSelectedData(date: Date) {
        
        if (!FirstLoad) {
            viewModel.eventsByDate = JZWeekViewHelper.getIntraEventsByDate(originalEvents: eventList)
        } else {
            viewModel.eventsByDate = JZWeekViewHelper.getIntraEventsByDate(originalEvents: viewModel.events)
        }
        let weekday = Calendar.current.component(.weekday, from: date) - 1
        let curdate = matchWeekDayToDate(weekday: weekday)
        guard let selectedData = viewModel.currentSelectedData else { return }
       
        calendarWeekView.setupCalendar(numOfDays: selectedData.numOfDays,
                                       setDate: curdate,
                                       allEvents: viewModel.eventsByDate,
                                       scrollType: selectedData.scrollType,
                                       firstDayOfWeek: selectedData.firstDayOfWeek)
        calendarWeekView.updateFlowLayout(JZWeekViewFlowLayout(hourGridDivision: selectedData.hourGridDivision))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DefaultViewController: JZBaseViewDelegate {
    func initDateDidChange(_ weekView: JZBaseWeekView, initDate: Date) {
        updateNaviBarTitle()
    }
}

// For example only
extension DefaultViewController: OptionsViewDelegate {
    
    func setupBasic() {
        // Add this to fix lower than iOS11 problems
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    private func setupNaviBar() {
        updateNaviBarTitle()
        let optionsButton = UIButton(type: .system)
        optionsButton.setImage(UIImage(named: "HumbergerIcon"), for: .normal)
        optionsButton.frame.size = CGSize(width: 25, height: 25)
        if #available(iOS 11.0, *) {
            optionsButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
            optionsButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        }
        optionsButton.addTarget(self, action: #selector(presentOptionsVC), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: optionsButton)
        
        let DeviceButton = UIButton(type: .system)
        DeviceButton.setImage(UIImage(named: "DeviceIcon1"), for: .normal)
        DeviceButton.frame.size = CGSize(width: 25, height: 25)
        if #available(iOS 11.0, *) {
            DeviceButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
            DeviceButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: DeviceButton)
    }
    
    @objc func presentOptionsVC() {
        let optionsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OptionsViewController") as! ExampleOptionsViewController
        let optionsViewModel = OptionsViewModel(selectedData: getSelectedData())
        optionsVC.viewModel = optionsViewModel
        optionsVC.delegate = self
        let navigationVC = UINavigationController(rootViewController: optionsVC)
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    private func getSelectedData() -> OptionsSelectedData {
        let numOfDays = calendarWeekView.numOfDays!
        let firstDayOfWeek = numOfDays == 7 ? calendarWeekView.firstDayOfWeek : nil
        viewModel.currentSelectedData = OptionsSelectedData(viewType: .defaultView,
                                                            date: calendarWeekView.initDate.add(component: .day, value: numOfDays),
                                                            numOfDays: numOfDays,
                                                            scrollType: calendarWeekView.scrollType,
                                                            firstDayOfWeek: firstDayOfWeek,
                                                            hourGridDivision: calendarWeekView.flowLayout.hourGridDivision)
        return viewModel.currentSelectedData
    }
    
    func finishUpdate(selectedData: OptionsSelectedData) {
        
        // Update numOfDays
        if selectedData.numOfDays != viewModel.currentSelectedData.numOfDays {
            calendarWeekView.numOfDays = selectedData.numOfDays
            calendarWeekView.refreshWeekView()
        }
        // Update Date
        if selectedData.date != viewModel.currentSelectedData.date {
            calendarWeekView.updateWeekView(to: selectedData.date)
        }
        // Update Scroll Type
        if selectedData.scrollType != viewModel.currentSelectedData.scrollType {
            calendarWeekView.scrollType = selectedData.scrollType
        }
        // Update FirstDayOfWeek
        if selectedData.firstDayOfWeek != viewModel.currentSelectedData.firstDayOfWeek {
            calendarWeekView.updateFirstDayOfWeek(setDate: selectedData.date, firstDayOfWeek: selectedData.firstDayOfWeek)
        }
        // Update hourGridDivision
        if selectedData.hourGridDivision != viewModel.currentSelectedData.hourGridDivision {
            calendarWeekView.updateFlowLayout(JZWeekViewFlowLayout(hourGridDivision: selectedData.hourGridDivision))
        }
        
    }
    
    private func updateNaviBarTitle() {
        self.navigationItem.title = "Schedule"
    }
}
