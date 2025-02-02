//
//  User.swift
//  gameofchats
//
//  Created by Brian Voong on 6/29/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

class TzofimUser: NSObject {
    var id: String?
    var name: String?
    var email: String?
//    var profileImageUrl: String?
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
//        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
}
