//
//  HomeBasicTableViewCell.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 07/09/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class HomeBasicTableViewCell: UITableViewCell {
  @IBOutlet var iconImageView: UIImageView!
  @IBOutlet weak var lblHeaderTitle: UILabel!
  @IBOutlet weak var lblDetailText: UILabel!
  @IBOutlet weak var lblTwoDetailText: UILabel!
  @IBOutlet weak var rightButton: UIButton!
  @IBOutlet var CellSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//  override func draw(_ rect: CGRect) {
//    iconImageView.layer.cornerRadius = iconImageView.frame.size.height/2
//    iconImageView.layer.masksToBounds = false
//    iconImageView.clipsToBounds = true
//
//  }

}
