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
    var time: String
    var name: String
    var dictionary:[String:Any] {
        return [
            "time" : time,
            "name" : name
        ]
    }
}


extension Schedule : DocumentSerializable {
    init?(dictionary: [String:Any]){
        guard let name = dictionary["name"] as? String,
              let time = dictionary["time"] as? String else {return nil}
        self.init(time: time, name: name)
    }
}
