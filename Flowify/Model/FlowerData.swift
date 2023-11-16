//
//  FlowerData.swift
//  Flowify
//
//  Created by Jose Antonio on 24/10/23.
//

import Foundation
import RealmSwift

enum IRRIGATION: Int{
    case LOW = 0,MODERATE = 1,HIGH = 2
}

enum LIGHT: Int{
    case SUN = 0, NOT_DIRECTED = 1
}

enum LOCATION: Int{
    case INDOOR = 0,OUTSIDE = 1,BOTH = 2
}


class FlowerData: Object{
    @objc dynamic var image: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var haveAlarm: Bool = false
    
    @objc dynamic private var irrigationValue: Int = 0
    @objc dynamic private var lightValue: Int = 0
    @objc dynamic private var locationValue: Int = 0
    var irrigation: IRRIGATION {
        get{
            return IRRIGATION(rawValue: irrigationValue)!
        }
        
        set{
            irrigationValue = newValue.rawValue
        }
    }
    var light:LIGHT {
        get{
            return LIGHT(rawValue: lightValue)!
        }
        
        set{
            lightValue = newValue.rawValue
        }
    }
    var location: LOCATION{
        get{
            return LOCATION(rawValue: locationValue)!
        }
        
        set{
            locationValue = newValue.rawValue
        }
    }
    
    @objc dynamic private var notification: NotificationData? = NotificationData()
    
    func setHour(hour: Int, minutes: Int){
        notification!.currentHour = hour
        notification!.currentMinutes = minutes
    }
    
    func getHour() -> Int{
        return notification!.currentHour
    }
    
    func getMinutes() -> Int {
        return notification!.currentMinutes
    }
    
    func getDay(ind: Int) -> Days{
        return Days(rawValue: notification!.days[ind]) ?? .MON
    }
    
    func addDays(d: Days){
        notification!.days.append(d.rawValue)
    }
    
    func removeAllDays(){
        notification!.days.removeAll()
    }
    
    func getDaysNumber() -> Int{
        return notification!.days.count
    }
    
    func getAM() -> Int{
        return notification!.am
    }
    
    func setAM(am: Bool){
        if(am){notification?.am = 0} else{ notification?.am = 1 }
    }
    
    func setData(image: String, name: String, irrigation_: IRRIGATION, light_: LIGHT, location_: LOCATION, haveAlarm: Bool) {
        self.image = image
        self.name = name
        self.irrigation = irrigation_
        self.light = light_
        self.location = location_
        self.haveAlarm = haveAlarm
    }
    
}
