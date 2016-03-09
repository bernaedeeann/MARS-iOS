//
//  ViewController.swift
//  Login Controller
//  MARS-iOS-app
//
//  Created by William Thornton on 2/26/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit

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
        var username:NSString = usernameTxt.text!
        var password:NSString = pswdTxt.text!
    }

    @IBAction func passwordNext(sender: AnyObject) {
        self.usernameTxt.resignFirstResponder()
        self.pswdTxt.becomeFirstResponder()
    }
    
    @IBAction func editingComplete(sender: AnyObject) {
        self.pswdTxt.resignFirstResponder()
    }
    
}

