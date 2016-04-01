//
//  ProfileFacialViewController.swift
//  MARS-iOS-app
//
//  Created by William Thornton on 4/1/16.
//  Copyright © 2016 Padawan. All rights reserved.
//
import UIKit

class ProfileFacialViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePicker1: UIImagePickerController!
    var imagePicker2: UIImagePickerController!
    var imagePicker3: UIImagePickerController!
    
    @IBOutlet weak var imageview1: UIImageView!
    
    @IBOutlet weak var imageview2: UIImageView!
    
    @IBOutlet weak var imageview3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController1(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker1.dismissViewControllerAnimated(true, completion: nil)
        imageview1.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    func imagePickerController2(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker2.dismissViewControllerAnimated(true, completion: nil)
        imageview2.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    func imagePickerController3(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker3.dismissViewControllerAnimated(true, completion: nil)
        imageview3.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    @IBAction func completeRegistration(sender: UIButton) {
    }
    @IBAction func takePhoto1(sender: UIButton) {
        //Will not work on simulator because no camera
        //Ewing said we can assume they have a camera
        imagePicker1 =  UIImagePickerController()
        imagePicker1.delegate = self
        imagePicker1.sourceType = .Camera
        imagePicker1.cameraDevice = .Front
        presentViewController(imagePicker1, animated: true, completion: nil)
    }
    @IBAction func takePhoto2(sender: UIButton) {
        imagePicker2 =  UIImagePickerController()
        imagePicker2.delegate = self
        imagePicker2.sourceType = .Camera
        imagePicker2.cameraDevice = .Front
        presentViewController(imagePicker2, animated: true, completion: nil)
        
    }
    @IBAction func takephoto3(sender: UIButton) {
        imagePicker3 =  UIImagePickerController()
        imagePicker3.delegate = self
        imagePicker3.sourceType = .Camera
        imagePicker3.cameraDevice = .Front
        presentViewController(imagePicker3, animated: true, completion: nil)
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

