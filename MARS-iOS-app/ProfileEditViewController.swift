//
//  ProfileEditViewController.swift
//  MARS-iOS-app
//
//  Created by William Thornton on 4/1/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit
import Alamofire

class ProfileEditViewController: UIViewController {

    @IBOutlet weak var departmentField: UITextField!
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var titlecodeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let department:String = prefs.valueForKey("DEPARTMENT") as! String
        departmentField.text? = department
        let jobtitle:String = prefs.valueForKey("TITLE") as! String
        titleField.text? = jobtitle
        let titleCode:String = prefs.valueForKey("TITLECODE") as! String
        titlecodeField.text? = titleCode

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveProfile(sender: UIBarButtonItem) {
        //save the information
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let usernameLoggedIn:String = prefs.valueForKey("USERNAME") as! String
        let password:String = prefs.valueForKey("PASSWORD") as! String
        
        let credentialData = "\(usernameLoggedIn):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        Alamofire.request(.PUT, "http://52.33.35.165:8080/api/assistant?dept="+departmentField.text!, headers: headers)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }
    
    @IBAction func departmentDone(sender: AnyObject) {
        self.departmentField.resignFirstResponder()
    }
    @IBAction func titleDone(sender: AnyObject) {
        self.titleField.resignFirstResponder()
    }
    @IBAction func titlecodeDone(sender: AnyObject) {
        self.titlecodeField.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
