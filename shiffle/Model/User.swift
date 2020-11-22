//
//  User.swift
//  shiffle
//
//  Created by myosubug on 2020-11-21.
//

import Foundation

struct User {
    var email: String
    var manager: Bool
    var dictionary:[String:Any] {
        return [
            "email"  : email,
            "manager" : manager
        ]
    }
}


extension User : DocumentSerializable {
    init?(dictionary: [String:Any]){
        guard let email = dictionary["email"] as? String,
              let manager = dictionary["manager"] as? Bool else {return nil}
        self.init(email: email, manager: manager)
    }
}
