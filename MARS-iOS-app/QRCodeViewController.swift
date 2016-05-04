//
//  QRCodeViewController.swift
//  MARS-iOS-app
//
//  Created by William Thornton on 4/1/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader

class QRCodeViewController: UIViewController, UINavigationControllerDelegate, QRCodeReaderViewControllerDelegate {
    
    lazy var reader: QRCodeReaderViewController = {
        let builder = QRCodeViewControllerBuilder { builder in
            builder.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
            builder.showTorchButton = true
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    var onScanResult: ((uuid: String, compId: String) -> ())?

    @IBAction func scanAction(sender: AnyObject) {
        if QRCodeReader.supportsMetadataObjectTypes() {
            reader.modalPresentationStyle = .FormSheet
            reader.delegate = self
        
            presentViewController(reader, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            
            presentViewController(alert, animated: true, completion: nil)
        }

    }
    
    func reader(reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        let scannedValues = result.value.componentsSeparatedByString("\n")
        if (scannedValues.count == 2) {
            let uuid = scannedValues[0]
            let compId = scannedValues[1]
        
            reader.dismissViewControllerAnimated(true, completion: { _ in
                self.dismissViewControllerAnimated(true, completion: { _ in self.onScanResult?(uuid: uuid, compId: compId) })
            })
        } else {
            reader.dismissViewControllerAnimated(true, completion: { _ in
                showMsg(self, "Invalid QR code", "Try again.")
            })
        }
    }
    
    func readerDidCancel(reader: QRCodeReaderViewController) {
        reader.dismissViewControllerAnimated(true, completion: nil)
    }

}
