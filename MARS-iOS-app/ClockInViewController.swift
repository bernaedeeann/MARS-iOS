//
//  ClockInViewController.swift
//  MARS-iOS-app
//
//  Created by William Thornton on 4/27/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit

class ClockInViewController: UIViewController {

    @IBOutlet weak var instructions: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if grader do not go to homescreen
        //save photo for facial recognition and then go to QR
        MarsApi.assistant().map { asst in
            if(asst.job == "grading") {
                self.instructions.text = "To clock in/out as a teaching assistant, you are required the following:\n\n1. Verify identity by facial recognition."
            } else {
                self.instructions.text = "To clock in/out as a teaching assistant, you are required the following:\n\n1. Verify identity by facial recognition.\n\n2. Verify location by scanning a provided QR code."
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
