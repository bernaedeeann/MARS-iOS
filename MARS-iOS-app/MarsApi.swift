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

class MarsApi {
    private static var credential: [String: String] = ["Authorization": ""]
    
    static func setCredential(user: String, passwd: String) -> Void {
        let credentialData = "\(user):\(passwd)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credential = credentialData.base64EncodedStringWithOptions([])
        credential = ["Authorization": "Basic \(base64Credential)"]
    }
    
    static func clearCredential() -> Void {
        credential = ["Authorization": ""]
    }
    
    static func account(onComplete: Or<Err, Account> -> ()) {
        call(GET("/account"), { res in onComplete(res.map { s in Account(json: s) })})
    }
    
    static func assistant(onComplete: Or<Err, Assistant> -> ()) {
        call(GET("/assistant"), { res in onComplete(res.map { s in Assistant(json: s) })})
    }
    
    static func recordsFromThisPayPeriod(onComplete: Or<Err, [Record]> -> ()) {
        call(GET("/records?filter=pay-period"), { res in
            onComplete(res.map { s in [Record](json: JSON(string: s)["records"].toString())})
        })
    }
    
    static func verifyUUID(uuid: String, onComplete: Or<Err, Void> -> ()) {
        call(GET("/register-uuid/verify/"+uuid), { res in onComplete(res.map { _ in })})
    }
    
    static func faceImages(onComplete: Or<Err, [FaceImage]> -> ()) {
        call(GET("/face"), { res in
            onComplete(res.map { s in [FaceImage](json: JSON(string: s)["images"].toString())})
        })
    }
    
    static func emailTimeSheet(onComplete: Or<Err, Void> -> ()) {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let y =  components.year
        let m = components.month
        let d = components.day
        
        if (d <= 15) {
            call(GET("/time-sheet/first-half-month?year=\(y)&month=\(m)"), { res in onComplete(res.map { _ in })})
        } else {
            call(GET("/time-sheet/recond-half-month?year=\(y)&month=\(m)"), { res in onComplete(res.map { _ in })})
        }
        
    }
    
    private static func GET(route: String) -> Request {
        return Alamofire.request(.GET, "http://52.33.35.165:8080/api"+route, headers: credential)
    }
    
    private static func POST(route: String) -> Request {
        return Alamofire.request(.POST, "http://52.33.35.165:8080/api"+route, headers: credential)
    }
    
    private static func call(req: Request, _ onResult: (Or<Err, String>) -> ()) -> Void {
        req.responseString { resp in
            switch resp.response!.statusCode {
            case 200...299:
                onResult(Or.Right(resp.result.value!))
            case let code:
                onResult(Or.Left(Err(code: code, msg: resp.result.value!)))
            }
        }
    }
}