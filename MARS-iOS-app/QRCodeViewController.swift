//
//  QRCodeViewController.swift
//  MARS-iOS-app
//
//  Created by William Thornton on 4/1/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit
class QRCodeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    
    
    @IBOutlet weak var QRimage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        QRimage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    @IBAction func takeQR(sender: UIButton) {
        //Will not work on simulator because no camera
        //Ewing said we can assume they have a camera
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        imagePicker.cameraDevice = .Front
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func completeClockIn(sender: UIButton) {
        //save QR code finish clock in and go to home screen and start clock running
        self.performSegueWithIdentifier("toTabs", sender: self)
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
