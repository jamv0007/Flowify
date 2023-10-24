//
//  FlowerData.swift
//  Flowify
//
//  Created by Jose Antonio on 24/10/23.
//

import Foundation

class FlowerData{
    var image: String
    var name: String
    var haveAlarm: Bool
    
    init(image: String, name: String, haveAlarm: Bool) {
        self.image = image
        self.name = name
        self.haveAlarm = haveAlarm
    }
}
