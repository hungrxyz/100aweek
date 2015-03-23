//
//  DayInfo.swift
//  100aweek
//
//  Created by Zel Marko on 21/03/15.
//  Copyright (c) 2015 Zel Marko. All rights reserved.
//

import UIKit

class DayInfo: NSObject {
    
    var isOpen = false
    var timings = [TimeEntry]()
    var headerCell = DailyHeaderCell()
    
    func getPercentage(time: String) -> String {
        var interval: CGFloat = 0.0
        let timeArr = time.componentsSeparatedByString(" : ")
    
        let daily: CGFloat = (100 * 3600) / 7
    
        interval += CGFloat(timeArr[0].toInt()! * 3600)
        interval += CGFloat(timeArr[1].toInt()! * 60)
        interval += CGFloat(timeArr[2].toInt()!)
    
        let percentage = Int((interval / daily) * 100)
    
        return "\(percentage) %"
    }
}
