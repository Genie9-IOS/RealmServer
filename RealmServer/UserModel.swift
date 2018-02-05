//
//  UserModel.swift
//  RealmServer
//
//  Created by Ahmad Almasri on 2/5/18.
//  Copyright © 2018 Ahmad Almasri. All rights reserved.
//

import Foundation
import RealmSwift
class UserModel: Object {
   @objc dynamic var text = ""
   @objc dynamic var id = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}



