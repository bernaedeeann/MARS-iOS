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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInAction(sender: UIButton) {

        let user = usernameTxt.text!
        let password = pswdTxt.text!
        
        if ( user == "" || password == "" ) { self.showMsg("Sign in Failed!", "Please enter Username and Password") }
        else {
            MarsApi.setCredential(user, passwd: password)
            MarsApi.account().fold(
                { err in
                    switch err.code {
                    case 401: self.showMsg("Sign in Failed!", "Wrong Username and/or Password")
                    case 403: self.showMsg("Forbidden", err.msg)
                    default: self.showMsg("Error!", err.msg)
                    }
                },
                { acc in
                    if (acc.role.lowercaseString == "assistant") { self.dismissViewControllerAnimated(true, completion: nil) }
                    else { self.showMsg("Invalid Role", "This app is only available to assistants.") }
                }
            )
        }
    }
    
    private func showMsg(title: String, _ msg: String, _ btn: String = "OK") -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: btn, style: .Default) { _ in })
        self.presentViewController(alert, animated: true){}
    }

    @IBAction func passwordNext(sender: AnyObject) {
        self.usernameTxt.resignFirstResponder()
        self.pswdTxt.becomeFirstResponder()
    }
    
    @IBAction func editingComplete(sender: AnyObject) {
        self.pswdTxt.resignFirstResponder()
    }
    
}

