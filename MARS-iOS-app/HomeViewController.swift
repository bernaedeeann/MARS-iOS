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
    
    var currentlyClockIn = false
    var isTeachingJob = false
    
    @IBOutlet weak var displayTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        MarsApi.assistant()
            .map { asst in
                self.isTeachingJob = asst.job == "teaching"
            }
            .leftMap { err in
                self.performSegueWithIdentifier("loginView", sender: self)
            }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        func setUpViews() {
            MarsApi.recordsFromThisPayPeriod()
                .map { rec in
                    if (rec.isEmpty) {
                        self.currentlyClockIn = false
                        self.stopTimer()
                    } else {
                        print(rec[0].outTime)
                        if (rec[0].outTime != nil) {
                            self.stopTimer()
                            self.currentlyClockIn = false
                        } else {
                            self.startTimer(NSTimeInterval(rec[0].inTime / 1000))
                            self.currentlyClockIn = true
                        }
                    }
                
                }
                .leftMap { err in
                    switch err.code {
                    case 403:
                        showMsg(self, String(err.code), err.msg, btn: "Re-Login", onClick: { _ in self.performSegueWithIdentifier("loginView", sender: self) })
                    case _:
                        showMsg(self, String(err.code), err.msg, btn: "Retry", onClick: { _ in setUpViews() })
                    }
                }
        }
        
        setUpViews()
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
    

    func startTimer(setTime: NSTimeInterval? = nil) {
        self.startTime = setTime ?? NSDate().timeIntervalSince1970
        let aSelector : Selector = #selector(HomeViewController.updateTime)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        self.timer.invalidate()
    }
    
    func updateTime(){
        let currentTime = NSDate().timeIntervalSince1970
        
        var elapsedTime: NSTimeInterval = currentTime - self.startTime
        
        let hours = UInt32(elapsedTime/3600)
        elapsedTime -= (NSTimeInterval(hours) * 3600)
        
        let minutes = UInt32(elapsedTime/60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        let seconds = UInt32(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //let fraction = UInt8(elapsedTime * 100)
        
        let strHours = String(format: "%02d", hours)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        displayTimeLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let a = segue.destinationViewController as? UITabBarController {
            if a.viewControllers![0] is ClockInViewController {
                print("HELLLLLO")
            }
        }
        
        if let vc = segue.destinationViewController as? ClockInViewController {
            vc.isClockingIn = !self.currentlyClockIn
            vc.isTeachingJob = self.isTeachingJob
        }
    }

}
