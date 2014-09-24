//
//  FilterCell.swift
//  yelppy
//
//  Created by Deepak Agarwal on 9/21/14.
//  Copyright (c) 2014 Deepak Agarwal. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {

    @IBOutlet weak var filterName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var filterValue: UISwitch!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
