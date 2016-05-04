//
//  ClockInViewController.swift
//  MARS-iOS-app
//
//  Created by William Thornton on 4/27/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit

class ClockInViewController: UIViewController {
    
    var isTeachingJob: Bool = true
    var isClockingIn: Bool = true
    var isRegistering: Bool = false

    @IBOutlet weak var titlebar: UINavigationBar!
    @IBOutlet weak var instructions: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prefs = NSUserDefaults.standardUserDefaults()
        isClockingIn = prefs.boolForKey("isClockingIn")
        isTeachingJob = prefs.boolForKey("isTeachingJob")
        
        self.titlebar.topItem?.title = isClockingIn ? "Clock In" : "Clock Out"
        
        if (!isTeachingJob) {
            self.instructions.text = "To clock in/out as a grading assistant, you are required the following:\n\n1. Verify identity by facial recognition."
        } else {
            self.instructions.text = "To clock in/out as a teaching assistant, you are required the following:\n\n1. Verify identity by facial recognition.\n\n2. Verify location by scanning a provided QR code."
        }
        
        MarsApi.faceImages()
            .map{ fac in
                if(fac.count < 5)
                {
                    self.isClockingIn = false
                    self.isRegistering = true
                    self.titlebar.topItem?.title = "Face Recognition Setup"
                    self.instructions.text = "Your account does not have enough face photos for facial recognition needed for clocking in and out."
                    var left = 5 - fac.count
                    var message = String(left) + " more photos"
                    let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: {_ in self.performSegueWithIdentifier("toHome", sender: self) })
                }
                
        }

    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let vc = segue.destinationViewController as? FacialRecognitionViewController {
            vc.onPhotoTakenResult = { (img) in
                // toast: Analyzing...
                if(self.isRegistering == true)
                {
                    self.doFaceRegistration(img, onSucc: { _ in
                        showMsg(self, "", "Photo Saved", onClick: { _ in self.performSegueWithIdentifier("toHome", sender: self) }) })
                    
                }
                else
                {
                    self.doFaceRecognition(img, onSucc: { _ in
                        if (self.isTeachingJob) {
                            self.performSegueWithIdentifier("toQR", sender: self)
                        } else { // grading job
                            self.doClockInOut("Undisclosed location")
                        }
                    })
                }
            }
        }

        if let vc = segue.destinationViewController as? QRCodeViewController {
            vc.onScanResult = { (uuid, compId) in
                MarsApi.verifyUUID(uuid).fold(
                    { err in
                        switch err.code {
                        case 410:
                            showMsg(self, "Verification failed", "The scanned QR code has already expired")
                        case _:
                            showMsg(self, "Error!", err.msg)
                        }
                    },
                    { _ in
                        print(">>>>. CLOCKING " + compId)
                        self.doClockInOut(compId)
                    }
                )
            }
        }
        
    }

    func doFaceRegistration(faceImg: UIImage, onSucc: Void -> Void) -> Void {
        MarsApi.addFaceForRecognition(faceImg).fold({ err in
                showMsg(self, "Error!", err.msg)
            }, { succ in
                    onSucc()
            }
        )
    }

    func doFaceRecognition(faceImg: UIImage, onSucc: Void -> Void) -> Void {
        MarsApi.facialRecognition(faceImg).fold(
            { err in
                showMsg(self, "Error!", err.msg)
            },
            { res in
                if (res.confidence >= res.threshold) {
                    onSucc()
                } else {
                    showMsg(self, "Verification failed", "You did not pass the facial recognition check. Please try again.")
                }
            }
        )
    }

    func doClockInOut(compId: String) -> Void {
        let res = isClockingIn ? MarsApi.clockIn(compId) : MarsApi.clockOut(compId)
        res.fold({ err in showMsg(self, "Error!", err.msg) },
                 { _ in self.performSegueWithIdentifier("toHome", sender: self) })
    }
}
