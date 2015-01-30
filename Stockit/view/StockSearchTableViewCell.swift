//
//  StockSearchTableViewCell.swift
//  NewApp
//
//  Created by Nitesh Agarwal on 02/01/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class StockSearchTableViewCell: UITableViewCell {

    @IBOutlet var stockNameLabel: UILabel!
    @IBOutlet var stockExchLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
