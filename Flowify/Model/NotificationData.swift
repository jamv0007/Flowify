//
//  NotificationData.swift
//  Flowify
//
//  Created by Jose Antonio on 14/11/23.
//

import UIKit

enum Days: String{
    case MON = "Mon", TUE = "Tue", WED = "Wed", THU = "Thu", FRI = "Fri", SAT = "Sat", SUN = "Sun"
    
}

class NotificationData: NSObject{
    var days = [Days]()
    var currentHour: Int
    var currentMinutes: Int
    
    override init(){
        currentHour = Calendar.current.component(.hour, from: Date())
        currentMinutes = Calendar.current.component(.minute, from: Date())
        super.init()
    }
    
}
