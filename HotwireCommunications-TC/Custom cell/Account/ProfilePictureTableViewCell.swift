//
//  ProfilePictureTableViewCell.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 03/01/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit
protocol EditProfilePicture {
  func openActiveSheetChooseProfilePicture()
}

class ProfilePictureTableViewCell: UITableViewCell {
  @IBOutlet var backgroundImageView: UIImageView!
  @IBOutlet var profilePicImgview: UIImageView!
  @IBOutlet weak var lblUserName: UILabel!
  @IBOutlet weak var lblUserAddress: UILabel!
  @IBOutlet weak var btnEditImage: UIButton!
  var delegate:EditProfilePicture!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  override func draw(_ rect: CGRect) {
    profilePicImgview.layer.borderColor = UIColor.white.cgColor
    profilePicImgview.layer.borderWidth = 2
    profilePicImgview.layer.cornerRadius = profilePicImgview.frame.size.height/2
    profilePicImgview.layer.masksToBounds = false
    profilePicImgview.clipsToBounds = true
    
    btnEditImage.layer.cornerRadius = btnEditImage.frame.size.height/2
    btnEditImage.layer.masksToBounds = false
    btnEditImage.clipsToBounds = true
    
  }
  @IBAction func editProfilePictureButtonTappedAction(_ sender: Any) {
    delegate.openActiveSheetChooseProfilePicture()
  }
  
}
