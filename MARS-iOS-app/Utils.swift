//
//  Utils.swift
//  MARS-iOS-app
//
//  Created by Thang Le on 4/21/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit

func showMsg(view: UIViewController, _ title: String, _ msg: String, btn: String = "OK", onClick: Void -> Void = { _ in }) -> Void {
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: btn, style: .Default) { _ in onClick() })
    view.presentViewController(alert, animated: true){}
}

func showConfirmDialog(view: UIViewController, _ title: String, _ msg: String, onConfirm: Void -> Void) -> Void {
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "Yes", style: .Default) { _ in onConfirm() })
    alert.addAction(UIAlertAction(title: "Cancel", style: .Default) { _ in })
    view.presentViewController(alert, animated: true){}
}