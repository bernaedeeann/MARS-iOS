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
    
    var onPhotoTakenResult: ((img: UIImage) -> ())?

    @IBOutlet weak var ndbutton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ndbutton.enabled = false
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = img
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        ndbutton.enabled = true
    }
    
    @IBAction func onConfirmPhoto(sender: UIButton) {
        self.onPhotoTakenResult?(img: self.fixOrientation(imageView.image!))
        self.dismissViewControllerAnimated(true, completion: nil)
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
    
    func fixOrientation(img:UIImage) -> UIImage {
        if (img.imageOrientation == UIImageOrientation.Up) {
            return img;
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale);
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.drawInRect(rect)
        
        let normalizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return normalizedImage;
    }
}
