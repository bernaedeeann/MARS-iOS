//
//  ThirdViewController.swift
//  Home Controller
//  MARS-iOS-app
//
//  Created by William Thornton on 2/28/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController{

    
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
            self.usernameLabel.text = prefs.valueForKey("USERNAME") as! NSString as String
        }
    }
    
    @IBAction func logoutAction(sender: UIBarButtonItem) {
            
            self.performSegueWithIdentifier("loginView", sender: self)
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
