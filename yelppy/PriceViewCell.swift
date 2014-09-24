//
//  PriceViewCell.swift
//  yelppy
//
//  Created by Deepak Agarwal on 9/23/14.
//  Copyright (c) 2014 Deepak Agarwal. All rights reserved.
//

import UIKit

class PriceViewCell: UITableViewCell {

    @IBOutlet weak var priceTags: UISegmentedControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
