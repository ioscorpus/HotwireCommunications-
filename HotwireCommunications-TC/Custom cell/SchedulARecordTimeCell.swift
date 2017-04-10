//
//  SchedulARecordTimeCell.swift
//  HotwireCommunications
//
//  Created by Dev on 28/02/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class SchedulARecordTimeCell: UITableViewCell {
    
    
    @IBOutlet weak var timeScrolleView: UIScrollView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        
        self.timeScrolleView.isPagingEnabled = true
        self.timeScrolleView.bounces = false
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
