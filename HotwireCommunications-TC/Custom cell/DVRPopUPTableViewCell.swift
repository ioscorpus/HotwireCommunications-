//
//  DVRPopUPTableViewCell.swift
//  HotwireCommunications
//
//  Created by Dev on 23/03/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class DVRPopUPTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dvrPopUPRadioImage: UIImageView!
    @IBOutlet weak var dvrPopUPNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
