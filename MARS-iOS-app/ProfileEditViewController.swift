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

        MarsApi.assistant().map { asst in
            self.departmentField.text = asst.department
            self.titleField.text = asst.title
            self.titlecodeField.text = asst.titleCode
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveProfile(sender: UIBarButtonItem) {
        MarsApi.updateAssistant(self.departmentField.text!, self.titleField.text!, self.titlecodeField.text!).fold(
            { err in
                self.showMsg("Oops", err.msg)
            },
            { succ in
                self.showMsg("Updated", "", onClick: { _ in self.performSegueWithIdentifier("saveToHome", sender: self) })
            }
        )
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
    
    private func showMsg(title: String, _ msg: String, btn: String = "OK", onClick: Void -> Void = { _ in }) -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: btn, style: .Default) { _ in onClick() })
        self.presentViewController(alert, animated: true){}
    }

}
