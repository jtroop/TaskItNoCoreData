//
//  Date.swift
//  Taskit
//
//  Created by DevStuff on 2016-08-25.
//  Copyright © 2016 DevStuff. All rights reserved.
//

import Foundation

class Date{
    class func from (year: Int, month: Int, day: Int) -> NSDate{
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        // We have to specify the type of calendar as there are many types 
        // of calendars in use today
        let gregorianCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        
        // Once the above line is set, in a sense we have selected the correct template
        // we now just have to put the data in and let the system assemble the date
        let date = gregorianCalendar?.dateFromComponents(components)
        
        return date!
    } // End from 
    
    class func toString(date: NSDate) -> String {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateStringFormatter.stringFromDate(date)

        return dateString
    }// End toString
}