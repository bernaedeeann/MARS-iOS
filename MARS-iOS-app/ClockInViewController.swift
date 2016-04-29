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

    @IBOutlet weak var titlebar: UINavigationBar!
    @IBOutlet weak var instructions: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titlebar.topItem?.title = isClockingIn ? "Clock In" : "Clock Out"
        
        if (!isTeachingJob) {
            self.instructions.text = "To clock in/out as a grading assistant, you are required the following:\n\n1. Verify identity by facial recognition."
        } else {
            self.instructions.text = "To clock in/out as a teaching assistant, you are required the following:\n\n1. Verify identity by facial recognition.\n\n2. Verify location by scanning a provided QR code."
        }
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let vc = segue.destinationViewController as? FacialRecognitionViewController {
            vc.onPhotoTakenResult = { (img) in
                // toast: Analyzing...
                self.doFaceRecognition(img, onSucc: { _ in
                    if (self.isTeachingJob) {
                        self.performSegueWithIdentifier("toQR", sender: self)
                    } else { // grading job
                        self.doClockInOut("Undisclosed location")
                    }
                })
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
                        self.doClockInOut(compId)
                    }
                )
            }
        }
        
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
        res.fold({ err in showMsg(self, "Error!", err.msg) }, { _ in /* todo: finish() */ })
    }
}
