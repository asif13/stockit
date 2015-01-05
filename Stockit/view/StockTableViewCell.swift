//
//  StockTableViewCell.swift
//  Stockit
//
//  Created by Nitesh Agarwal on 04/01/15.
//  Copyright (c) 2015 erudite. All rights reserved.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    @IBOutlet var stockSymbolLabel: UILabel!
    @IBOutlet var stockExchLabel: UILabel!
    @IBOutlet var stockPriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
