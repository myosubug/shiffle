//
//  Schedule.swift
//  shiffle
//
//  Created by myosubug on 2020-11-09.
//

import Foundation
import FirebaseFirestore

protocol DocumentSerializable {
    init?(dictionary:[String:Any])
}


struct Schedule {
    var day: String
    var startTime: String
    var endTime: String
    var name: String
    var dictionary:[String:Any] {
        return [
            "day"  : day,
            "startTime" : startTime,
            "endTime" : endTime,
            "name" : name
        ]
    }
}


extension Schedule : DocumentSerializable {
    init?(dictionary: [String:Any]){
        guard let day = dictionary["day"] as? String,
              let name = dictionary["name"] as? String,
              let startTime = dictionary["startTime"] as? String,
              let endTime = dictionary["endTime"] as? String else {return nil}
        self.init(day: day, startTime: startTime, endTime: endTime, name: name)
    }
}
