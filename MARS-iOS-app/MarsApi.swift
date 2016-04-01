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
        call(GET("/account"), { res in onComplete(res.map({ s in Account(json: s) })) })
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
                //print(resp.result.value!)
                //print(JSON(string: resp.result.value!)["records"].toString())
                //print(Account(json: resp.result.value!))
            case let code:
                onResult(Or.Left(Err(code: code, msg: resp.result.value!)))
            }
        }
    }
}