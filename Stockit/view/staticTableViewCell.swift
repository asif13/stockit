//
//  staticTableViewCell.swift
//  NewApp
//
//  Created by Venkatesh on 17/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

import UIKit

class staticTableViewCell: UITableViewCell {

    @IBOutlet weak var lable4: UILabel!
    @IBOutlet weak var lable3: UILabel!
    @IBOutlet weak var lable2: UILabel!
    @IBOutlet weak var lable1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
