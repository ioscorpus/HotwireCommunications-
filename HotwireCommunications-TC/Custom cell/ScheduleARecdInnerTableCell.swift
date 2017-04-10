//
//  ScheduleARecdInnerTableCell.swift
//  HotwireCommunications
//
//  Created by Dev on 17/03/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class ScheduleARecdInnerTableCell: UITableViewCell {
    
    
    @IBOutlet weak var schedulARecdInnerImage: UIImageView!
    @IBOutlet weak var schedulARecdInnerNameLabel: UILabel!
    @IBOutlet weak var schedulARecdInnerEpisdoeName: UILabel!
    
    @IBOutlet weak var airDateLabel: UILabel!
    @IBOutlet weak var airdDateValueLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeValueLabel: UILabel!
    
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var chnnaelNameLabel: UILabel!
    
    @IBOutlet weak var detailsValueLabel: UILabel!
    
    @IBOutlet weak var castCrewValueLabel: UILabel!
    @IBOutlet weak var schedulARecdInnerCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
