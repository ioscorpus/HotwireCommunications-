//
//  ScheduledrecordTableCell.swift
//  HotwireCommunications
//
//  Created by Dev on 27/02/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class ScheduledrecordTableCell: UITableViewCell {
    
    
    @IBOutlet weak var schedProgNameLabel: UILabel!
    @IBOutlet weak var schedLabel: UIView!
    @IBOutlet weak var schedDateLabel: UILabel!
    @IBOutlet weak var schedStartTimeLabel: UILabel!
    @IBOutlet weak var schedTimeValLabel: UILabel!
    @IBOutlet weak var schedChannelLabel: UILabel!
    @IBOutlet weak var schedChannelNameLabel: UILabel!
    @IBOutlet weak var schedSynopsisLabel: UILabel!

    @IBOutlet weak var schedDeleteButton: UIButton!
    @IBOutlet weak var schedOptionButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        
        self.schedDeleteButton.layer.cornerRadius = self.schedDeleteButton.frame.size.height/2
        self.schedOptionButton.layer.cornerRadius = self.schedOptionButton.frame.size.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
