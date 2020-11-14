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
    var time: String
    var name: String
    var dictionary:[String:Any] {
        return [
            "day"  : day,
            "time" : time,
            "name" : name
        ]
    }
}


extension Schedule : DocumentSerializable {
    init?(dictionary: [String:Any]){
        guard let day = dictionary["day"] as? String,
              let name = dictionary["name"] as? String,
              let time = dictionary["time"] as? String else {return nil}
        self.init(day: day, time: time, name: name)
    }
}
