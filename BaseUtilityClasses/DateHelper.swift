//
//  DateHelper.swift
//  BaseUtilityClasses
//
//  Created by Etienne Goulet-Lang on 8/19/16.
//  Copyright © 2016 Etienne Goulet-Lang. All rights reserved.
//

import Foundation

private var dateObjs: [String: DateFormatter] = [:]
public class DateHelper {
    
    // Data formatter Methods
    public enum DateComparison {
        case sameDay
        case dayBefore
        case sameWeek
        case sameYear
        case differentYear
        case na
    }
    
    public class func isLater(later: Date?, earlier: Date?) -> Bool {
        if let l = later, let e = earlier {
            return l.compare(e) == .orderedDescending
        } else if later == nil {
            return false
        } else if earlier == nil {
            return true
        }
        return false
    }
    
    public class func compareDates(day1: Date!, day2: Date!) -> DateComparison {
        if day1 == nil || day2 == nil {
            return .na
        }
        
        let calendar = Calendar.current
        let components: NSCalendar.Unit = [NSCalendar.Unit.year, NSCalendar.Unit.weekOfYear, NSCalendar.Unit.day, NSCalendar.Unit.hour, NSCalendar.Unit.minute]
        
        let comp1 = (calendar as NSCalendar).components(components, from: day1)
        let comp2 = (calendar as NSCalendar).components(components, from: day2)
        
        if (comp1.year != comp2.year) {
            return .differentYear
        } else if (comp1.weekOfYear != comp2.weekOfYear) {
            return .sameYear
        } else if (comp1.day != comp2.day) {
            if abs(comp1.day! - comp2.day!) == 1 {
                return .dayBefore
            }
            return .sameWeek
        } else {
            return .sameDay
        }
    }
    
    public class func isWithin(curr: Date, prev: Date!, within: Int) -> Bool {
        if prev == nil { return false }
        let diff = Int(abs(curr.timeIntervalSince(prev)))
        return (diff < within)
    }
    
    public class func formatDate(_ format: String, date: Date) -> String {
        var formatter = dateObjs[format]
        if formatter == nil {
            formatter = DateFormatter()
            formatter!.dateFormat = format
            dateObjs[format] = formatter
        }
        return formatter!.string(from: date)
    }
    
}
