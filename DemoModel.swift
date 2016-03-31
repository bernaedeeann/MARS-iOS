//
//  DemoModel.swift
//  MARS-iOS-app
//
//  Created by William Thornton on 3/23/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import Foundation
import UIKit

class DemoModel
{
    var title: String
    var subtitle: String
    var picture: UIImage
    
    init(titled: String, data: String, pic: UIImage)
    {
        self.title = titled
        self.subtitle = data
        self.picture = pic
    }
}
