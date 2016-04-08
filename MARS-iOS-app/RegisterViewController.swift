//
//  RegisterViewController.swift
//  Register Controller
//  MARS-iOS-app
//
//  Created by William Thornton on 2/28/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController{
    
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var netIdTxt: UITextField!
    @IBOutlet weak var employeeIdTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var password2Txt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var departmentTxt: UITextField!
    @IBOutlet weak var payRateTxt: UITextField!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var titleCodeTxt: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var dataArray = ["", "Teaching", "Grading"]
    var jobType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func completeRegisterAction(sender: UIButton) {
    }
    
    @IBAction func firstnameDone(sender: AnyObject) {
        self.firstNameTxt.resignFirstResponder()
        self.lastNameTxt.becomeFirstResponder()
        
    }
    
    @IBAction func lastnameDone(sender: AnyObject) {
        self.lastNameTxt.resignFirstResponder()
        self.netIdTxt.becomeFirstResponder()
    }
    
    @IBAction func netidDone(sender: AnyObject) {
        self.netIdTxt.resignFirstResponder()
        self.employeeIdTxt.becomeFirstResponder()
    }
    
    
    @IBAction func employeeidDone(sender: AnyObject) {
        self.employeeIdTxt.resignFirstResponder()
        self.usernameTxt.becomeFirstResponder()
    }
    
    
    @IBAction func usernameDone(sender: AnyObject) {
        self.usernameTxt.resignFirstResponder()
        self.passwordTxt.becomeFirstResponder()
    }
    
    @IBAction func passwordDone(sender: AnyObject) {
        self.passwordTxt.resignFirstResponder()
        self.password2Txt.becomeFirstResponder()
    }
    
    @IBAction func password2Done(sender: AnyObject) {
        self.password2Txt.resignFirstResponder()
    }
    
    @IBAction func password2(sender: AnyObject) {
        if(self.password2Txt?.text != self.passwordTxt?.text)
        {
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Fail"
            alertView.message = "Passwords Do Not Match"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
    }
    @IBAction func emailDone(sender: AnyObject) {
        self.emailTxt.resignFirstResponder()
    }
    
    @IBAction func departmentDone(sender: AnyObject) {
        self.departmentTxt.resignFirstResponder()
        self.payRateTxt.becomeFirstResponder()
    }
    
    
    @IBAction func payDone(sender: AnyObject) {
        self.payRateTxt.resignFirstResponder()
        self.titleTxt.becomeFirstResponder()
    }
    
    
    @IBAction func titleDone(sender: AnyObject) {
        self.titleTxt.resignFirstResponder()
        self.titleCodeTxt.becomeFirstResponder()
    }
    
    
    @IBAction func titlecodeDone(sender: AnyObject) {
        self.titleCodeTxt.resignFirstResponder()
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
