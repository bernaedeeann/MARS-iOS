//
//  Models.swift
//  MARS-iOS-app
//
//  Created by Thang Le on 3/31/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import Foundation
import EVReflection


struct Err {
    let code: Int
    let msg: String
}

class Account: EVObject {
    var approve: Bool = false
    var netId: String = ""
    var role: String = ""
    var username: String = ""
    var createTime: Double = 0
}


class AA: EVObject {
    
}