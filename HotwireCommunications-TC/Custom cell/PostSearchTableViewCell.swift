//
//  PostSearchTableViewCell.swift
//  HotwireCommunications
//
//  Created by Dev on 28/03/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class PostSearchTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabelPostSearch: UILabel!
    @IBOutlet weak var addDeleteRecdButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
