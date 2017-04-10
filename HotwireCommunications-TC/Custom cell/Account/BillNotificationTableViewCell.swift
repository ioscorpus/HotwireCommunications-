//
//  BillNotificationTableViewCell.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 03/01/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class BillNotificationTableViewCell: UITableViewCell {
  @IBOutlet weak var btnIndexOne: UIButton!
  @IBOutlet weak var lblIndexOneTitle: UILabel!
  @IBOutlet weak var btnIndexTwo: UIButton!
  @IBOutlet weak var lblIndexTwoTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  override func draw(_ rect: CGRect) {
    btnIndexOne.layer.cornerRadius = btnIndexOne.frame.size.height/2
    btnIndexOne.layer.masksToBounds = false
    btnIndexOne.clipsToBounds = true
    updateLayerProperties(button: btnIndexOne)
    btnIndexTwo.layer.cornerRadius = btnIndexOne.frame.size.height/2
    btnIndexTwo.layer.masksToBounds = false
    btnIndexTwo.clipsToBounds = true
    updateLayerProperties(button: btnIndexTwo)
    
  }
  func updateLayerProperties(button:UIButton) {
    button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45).cgColor
    button.layer.shadowOffset = CGSize(width: 0, height: 3)
    button.layer.shadowOpacity = 1.0
    button.layer.shadowRadius = 5.0
    button.layer.masksToBounds = false
  }
}
