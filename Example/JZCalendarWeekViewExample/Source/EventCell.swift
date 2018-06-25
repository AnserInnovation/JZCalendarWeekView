//
//  EventCell.swift
//  timegenii
//
//  Created by Jeff Zhang on 14/9/17.
//  Copyright © 2017 unimelb. All rights reserved.
//

import UIKit
import JZCalendarWeekView

class EventCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    var event: DefaultEvent!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupBasic()
    }
    
    func setupBasic() {
        self.clipsToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0
        locationLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.backgroundColor = UIColor(hex: 0xEEF7FF)
        borderView.backgroundColor = UIColor(hex: 0x0899FF)
    }
    

    func calculateTimeDifference(start: Date, end: Date) -> Int {
        let difference = end.timeIntervalSince(start)
        return (Int(difference / 60))
    }
    
    func configureCell(event: DefaultEvent) {
        self.event = event
        event.duration = calculateTimeDifference(start: event.startDate, end: event.endDate)
        locationLabel.text = String(event.duration)
        titleLabel.text = event.type
    }

}





