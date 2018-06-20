//
//  SettingEvent.swift
//  JZCalendarWeekViewExample
//
//  Created by DA SONG on 6/13/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

class SettingEvent {

    static private var SettingView: UIView!
    static private var SettingLabel: UILabel!
    
    public static func showSettingView(event: DefaultEvent) {
        guard let currentWindow = UIApplication.shared.delegate?.window!, SettingView == nil else {return}
        
        SettingView = UIView(frame: CGRect(x: currentWindow.frame.origin.x, y: currentWindow.frame.origin.y, width: currentWindow.frame.width, height: currentWindow.frame.height))
        addLabel(message: event.type)
        print("Add label")
        SettingView.backgroundColor = UIColor(hex: 0x3a3a3a)
        currentWindow.addSubview(SettingView)
    }
    
    private static func addLabel(message: String) {
        SettingLabel = UILabel()
        SettingLabel.text = message
        SettingLabel.textColor = UIColor.white
        SettingLabel.textAlignment = .center
        SettingLabel.addSubview(SettingLabel)
    }
    
}
