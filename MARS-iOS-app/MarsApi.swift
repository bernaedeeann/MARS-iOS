//
//  MarsApi.swift
//  MARS-iOS-app
//
//  Created by Thang Le on 3/31/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireJsonToObjects
import EVReflection
import PromiseKit

class MarsApi {
    private static var credential: [String: String] = ["Authorization": ""]
    
    static func setCredential(user: String, passwd: String) -> Void {
        let credentialData = "\(user):\(passwd)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credential = credentialData.base64EncodedStringWithOptions([])
        credential = ["Authorization": "Basic \(base64Credential)"]
    }
    
    static func clearCredential() -> Void {
        credential = ["": ""]
    }
    
    static func account() -> PromiseOr<Err, Account> {
        return call(GET("/account")).map { json in Account(json: json) }
    }
    
    static func assistant() -> PromiseOr<Err, Assistant> {
        return call(GET("/assistant")).map { json in Assistant(json: json) }
    }

    static func recordsFromThisPayPeriod() -> PromiseOr<Err, [Record]> {
        return call(GET("/records?filter=pay-period")).map { json in
            [Record](json: JSON(string: json)["records"].toString())
        }
    }
    
    static func verifyUUID(uuid: String) -> PromiseOr<Err, Void> {
        return call(GET("/register-uuid/verify/"+uuid)).map { _ in Void() }
    }
    
    static func faceImages() -> PromiseOr<Err, [FaceImage]> {
        return call(GET("/face")).map { json in
            [FaceImage](json: JSON(string: json)["images"].toString())
        }
    }
    
    static func updateAssistant(dept: String, _ title: String, _ code: String) -> PromiseOr<Err, Void> {
        let params = ["dept": dept, "title": title, "title_code": code]
        return call(POST("/assistant", params)).map { _ in }
    }

    static func clockIn(compId: String) -> PromiseOr<Err, Void> {
        let params = ["computer_id": compId]
        return call(POST("/records/clock-in", params)).map { _ in }
    }

    static func clockOut(compId: String) -> PromiseOr<Err, Void> {
        let params = ["computer_id": compId]
        return call(POST("/records/clock-out", params)).map { _ in }
    }

//    static func facialRecognition todo

//    static func addFaceForRecognition todo

    static func createAcc(user: String, passwd: String, asst: Assistant) -> PromiseOr<Err, Void> {
        let params = [
            "net_id": asst.netId,      "user":  user,              "pass":       passwd,
            "email":  asst.email,      "rate":  String(asst.rate), "job":        asst.job,
            "dept":   asst.department, "first": asst.firstName,    "last":       asst.lastName,
            "emp_id": asst.employeeId, "title": asst.title,        "title_code": asst.titleCode
        ]
        return call(POST("/account/assistant", params)).map { _ in }
    }

    static func emailTimeSheet() -> PromiseOr<Err, Void> {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let y =  components.year
        let m = components.month
        let d = components.day
        
        if (d <= 15) {
            return call(GET("/time-sheet/first-half-month?year=\(y)&month=\(m)")).map { _ in Void() }
        } else {
            return call(GET("/time-sheet/recond-half-month?year=\(y)&month=\(m)")).map { _ in Void() }
        }
    }
    
    private static func GET(route: String) -> Request {
        return Alamofire.request(.GET, "http://52.33.35.165:8080/api"+route, headers: credential)
    }
    
    private static func POST(route: String, _ params: [String: String]) -> Request {
        return Alamofire.request(.POST, "http://52.33.35.165:8080/api"+route, parameters: params, headers: credential)
    }
    
    private static func call(req: Request) -> PromiseOr<Err, String> {
        return PromiseOr(Promise { succ, fail in
            req.responseString { resp in
                switch resp.result {
                case .Success(let value):
                    switch resp.response!.statusCode {
                    case 200...299:
                        succ(Or.Right(value))
                    case let code:
                        succ(Or.Left(Err(code: code, msg: value)))
                    }
                case .Failure(let error):
                    print(error)
                    succ(Or.Left(Err(code: 500, msg: "Unexpected Error"))) // could be more detailed
                }
            }
        })
    }
}