//
//  FlowerData.swift
//  Flowify
//
//  Created by Jose Antonio on 24/10/23.
//

import Foundation

enum IRRIGATION: Int{
    case LOW = 0,MODERATE = 1,HIGH = 2
}

enum LIGHT: Int{
    case SUN = 0, NOT_DIRECTED = 1
}

enum LOCATION: Int{
    case INDOOR = 0,OUTSIDE = 1
}


class FlowerData{
    var image: String
    var name: String
    var irrigation: IRRIGATION
    var light:LIGHT
    var location: LOCATION
    var haveAlarm: Bool
    
    init(image: String, name: String, irrigation: IRRIGATION, light: LIGHT, location: LOCATION, haveAlarm: Bool) {
        self.image = image
        self.name = name
        self.irrigation = irrigation
        self.light = light
        self.location = location
        self.haveAlarm = haveAlarm
    }
}
