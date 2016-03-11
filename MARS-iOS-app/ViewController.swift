//
//  ViewController.swift
//  Login Controller
//  MARS-iOS-app
//
//  Created by William Thornton on 2/26/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var pswdTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInAction(sender: UIButton) {

        let user = usernameTxt.text!
        let password = pswdTxt.text!
        
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        let headers = ["Authorization": "Basic \(base64Credentials)"]

        Alamofire.request(.GET, "http://52.33.35.165:8080/api/assistant", headers: headers)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            }
//        Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
//            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
//                
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                }
//        }
    }

    @IBAction func passwordNext(sender: AnyObject) {
        self.usernameTxt.resignFirstResponder()
        self.pswdTxt.becomeFirstResponder()
    }
    
    @IBAction func editingComplete(sender: AnyObject) {
        self.pswdTxt.resignFirstResponder()
    }
    
}

