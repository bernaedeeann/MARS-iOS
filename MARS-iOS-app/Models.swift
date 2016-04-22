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


class Record: EVObject {
    var inTime: Double = 0
    var inComputerId: String? = nil
    var netId: String = ""
    var id: Int = 0
    var outTime: Double? = nil
    var outComputerId: String? = nil
}

class Assistant: EVObject {
    var rate: Double = 0.0
    var netId: String = ""
    var email: String = ""
    var job: String = ""
    var department: String = ""
    var lastName: String = ""
    var firstName: String = ""
    var employeeId: String = ""
    var title: String = ""
    var titleCode: String = ""
    
    convenience init(rate: Double, netId: String, email: String, job: String, dept: String, lname: String, fname: String, empId: String, title: String, code: String) {
        
        self.init()
        self.rate = rate
        self.netId = netId
        self.email = email
        self.job = job
        self.department = dept
        self.lastName = lname
        self.firstName = fname
        self.employeeId = empId
        self.title = title
        self.titleCode = code
    }
}

class FaceImage: EVObject {
    var id: String = ""
    var url: String = ""
}

class RecognitionResult: EVObject {
    var confidence: Double = 0.0
    var threshold: Double = 0.4
}

