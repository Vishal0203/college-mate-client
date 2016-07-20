//
//  SideMenuCustomCell.swift
//  collegemate
//
//  Created by Vishal Sharma on 10/07/16.
//  Copyright © 2016 ToDevs. All rights reserved.
//

import UIKit

class SideMenuCustomCell: UITableViewCell {

    @IBOutlet weak var navicon: UIImageView!
    
    @IBOutlet weak var navLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
