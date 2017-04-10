//
//  ScheduleARecordingSearchTableViewCell.swift
//  HotwireCommunications
//
//  Created by Dev on 27/03/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class ScheduleARecordingSearchTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var searchNameLabel: UILabel!
    @IBOutlet weak var preSearchImageView: UIImageView!
    @IBOutlet weak var searchAddDeleteRecdButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
