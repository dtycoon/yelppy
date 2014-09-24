//
//  YelpTableViewCell.swift
//  yelppy
//
//  Created by Deepak Agarwal on 9/22/14.
//  Copyright (c) 2014 Deepak Agarwal. All rights reserved.
//

import UIKit

class YelpTableViewCell: UITableViewCell {

    @IBOutlet weak var businessImage: UIImageView!
    
    @IBOutlet weak var businessName: UILabel!
    
    @IBOutlet weak var businessDistance: UILabel!
    
    @IBOutlet weak var businessStars: UIImageView!
    
    @IBOutlet weak var businessReviews: UILabel!
    
    
    @IBOutlet weak var businessPric: UILabel!
    
    
    @IBOutlet weak var businessAddress: UILabel!
    
    
    @IBOutlet weak var businessCategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
