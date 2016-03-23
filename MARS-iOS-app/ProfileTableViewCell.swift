//
//  Profile.swift
//  MARS-iOS-app
//
//  Created by William Thornton on 3/23/16.
//  Copyright © 2016 Padawan. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var value: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: selected)
    }

}
