//
//  NotificationData.swift
//  Flowify
//
//  Created by Jose Antonio on 14/11/23.
//

import UIKit
import Foundation
import RealmSwift

enum Days: Int{
    case MON = 0, TUE = 1, WED = 2, THU = 3, FRI = 4, SAT = 5, SUN = 6
    
}

class NotificationData: Object{
    dynamic var days: List<Days.RawValue> = List<Days.RawValue>()
    @objc dynamic var currentHour: Int = 0
    @objc dynamic var currentMinutes: Int = 0
    @objc dynamic var am: Int = 0
    
}
