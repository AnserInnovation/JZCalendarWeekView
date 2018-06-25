//
//  JZColumnHeader.swift
//  JZCalendarWeekView
//
//  Created by Jeff Zhang on 28/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

/// Header for each column (section, day) in collectionView (Supplementary View)
open class JZColumnHeader: UICollectionReusableView {
    
    public var lblDay = UILabel()
    public var lblWeekday = UILabel()
    let calendarCurrent = Calendar.current
    let dateFormatter = DateFormatter()
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        backgroundColor = .clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [lblWeekday, lblDay])
        stackView.axis = .vertical
        stackView.spacing = 2
        addSubview(stackView)
        stackView.setAnchorConstraintsEqualTo(centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor)
        lblDay.textAlignment = .center
        lblWeekday.textAlignment = .center
        lblDay.font = UIFont.systemFont(ofSize: 2)
        lblWeekday.font = UIFont.systemFont(ofSize: 12)
    }
    
    public func updateView(date: Date) {
        var weekday = calendarCurrent.component(.weekday, from: date) - 2
        
//        lblDay.text = String(calendarCurrent.component(.day, from: date))
        if (weekday == -1) {
            weekday = 6
        } else if (weekday == 7){
            weekday = 0
        }
        print("update view: ", weekday, date)
        lblWeekday.text = dateFormatter.shortWeekdaySymbols[weekday].uppercased()
        
        if date.isToday {
            lblDay.textColor = JZWeekViewColors.today
            lblWeekday.textColor = JZWeekViewColors.today
        } else {
            lblDay.textColor = JZWeekViewColors.columnHeaderDay
            lblWeekday.textColor = JZWeekViewColors.columnHeaderDay
        }
    }
    
}
