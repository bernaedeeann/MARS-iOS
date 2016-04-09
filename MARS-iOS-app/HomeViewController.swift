//
//  HomeViewController.swift
//  Home Controller
//  MARS-iOS-app
//
//  Created by William Thornton on 2/28/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
       let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("loginView", sender: self)
        } else {
            
        }
    }
    
    @IBAction func logoutAction(sender: UIBarButtonItem) {
        
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
            
            self.performSegueWithIdentifier("loginView", sender: self)
    }
    
    @IBAction func infoAction(sender: AnyObject) {
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "About"
        alertView.message = "This App was developed as part of a senior design project (Fall 2015 - Spring 2016) by Team Padawan-\n\nThang Le thangiee0@gmail.com\nBernae Tull bernaedeean@gmail.com\nCalvin Hovs. leadfarmer88@gmail.com\nMinglu Wang mingluswag@gmail.com\nBruce Derou brucederou@gmail.com"
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
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
