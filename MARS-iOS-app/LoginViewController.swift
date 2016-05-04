//
// LoginViewController.swift
//  Login Controller
//  MARS-iOS-app
//
//  Created by William Thornton on 2/26/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var pswdTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.usernameTxt.text = ""
        //self.pswdTxt.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInAction(sender: UIButton) {

        let user = usernameTxt.text!
        let password = pswdTxt.text!
        
        if ( user == "" || password == "" ) { showMsg(self, "Sign in Failed!", "Please enter Username and Password") }
        else {
            MarsApi.setCredential(user, passwd: password)
            MarsApi.account().fold(
                { err in
                    switch err.code {
                    case 401: showMsg(self, "Sign in Failed!", "Wrong Username and/or Password")
                    case 403: showMsg(self, "Forbidden", err.msg)
                    default:  showMsg(self, "Error!", err.msg)
                    }
                },
                { acc in
                    if (acc.role.lowercaseString == "assistant") { self.performSegueWithIdentifier("toMain", sender: self) }
                    else { showMsg(self, "Invalid Role", "This app is only available to assistants.") }
                }
            )
        }
    }

    @IBAction func passwordNext(sender: AnyObject) {
        self.usernameTxt.resignFirstResponder()
        self.pswdTxt.becomeFirstResponder()
    }
    
    @IBAction func editingComplete(sender: AnyObject) {
        self.pswdTxt.resignFirstResponder()
    }
    
}

