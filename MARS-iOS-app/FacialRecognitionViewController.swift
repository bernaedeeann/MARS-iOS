//
//  FacialRecognitionViewController.swift
//  MARS-iOS-app
//
//  Created by William Thornton on 3/27/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit

class FacialRecognitionViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePicker: UIImagePickerController!

    @IBOutlet weak var ndbutton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MarsApi.assistant().map { asst in
            if(asst.job == "grading")
            {
                self.ndbutton.setTitle("Complete", forState: UIControlState.Normal)
            }
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    @IBAction func toQR(sender: UIButton) {
        //if grader do not go to homescreen
        //save photo for facial recognition and then go to QR
        MarsApi.assistant().map { asst in
            if(asst.job != "grading")
            {
                self.performSegueWithIdentifier("toQRCode", sender: self)
            }
            else{
                self.performSegueWithIdentifier("facialtoHome", sender: self)
            }
        }
        
    }
    
    @IBAction func takePhoto(sender: UIButton) {
        
        //Will not work on simulator because no camera
        //Ewing said we can assume they have a camera
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera
            imagePicker.cameraDevice = .Front
            presentViewController(imagePicker, animated: true, completion: nil)
        
        
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
