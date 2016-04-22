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
    
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    
    
    
    @IBOutlet weak var displayTimeLabel: UILabel!
    
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
        
        MarsApi.account().leftMap { err in
            self.performSegueWithIdentifier("loginView", sender: self)
        }
    }
    
    func updateTime(){
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        var elapsedTime: NSTimeInterval = currentTime - self.startTime
        
        let hours = UInt8(elapsedTime/3600)
        elapsedTime -= (NSTimeInterval(hours) * 3600)
        
        let minutes = UInt8(elapsedTime/60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //let fraction = UInt8(elapsedTime * 100)
        
        let strHours = String(format: "%02d", hours)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        //let strFraction = String(format: "%02d", fraction)
        
        displayTimeLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
    }
    
    @IBAction func logoutAction(sender: UIBarButtonItem) {
        
        MarsApi.clearCredential()
        self.performSegueWithIdentifier("loginView", sender: self)
    }
    
    @IBAction func infoAction(sender: AnyObject) {
        let message = "This App was developed as part of a senior design project (Fall 2015 - Spring 2016) by Team Padawan-\n\nThang Le thangiee0@gmail.com\nBernae Tull bernaedeeann@gmail.com\nCalvin Hovs. leadfarmer88@gmail.com\nMinglu Wang mingluswag@gmail.com\nBruce Derou brucederou@gmail.com"

        showMsg(self, "About", message)
    }
    
    @IBAction func requestTimeSheet(sender: UIButton) {
        let title = "Time Sheet"
        let msg = "Do you want the current pay period time sheet to be sent to your email?"
        
        showConfirmDialog(self, title, msg, onConfirm: {
            MarsApi.emailTimeSheet().fold(
                { err in showMsg(self, "Error", err.msg) },
                { _   in showMsg(self, "Sent!", "It may take up to a few minutes to arrive.") }
            )
        })
    }
    

    @IBAction func start(sender: UIButton) {
        let aSelector : Selector = "updateTime"
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        self.startTime = NSDate.timeIntervalSinceReferenceDate()
    }
    
    @IBAction func stop(sender: UIButton) {
        //self.timer.invalidate()
        //self.timer == nil
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
