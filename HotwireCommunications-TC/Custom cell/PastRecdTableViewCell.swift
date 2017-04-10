//
//  PastRecdTableViewCell.swift
//  HotwireCommunications
//
//  Created by Dev on 07/04/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class PastRecdTableViewCell: UITableViewCell {
    
    var delegate: PastRecdTableViewCellDelegate?

    //@IBOutlet weak var deleteViewWidthConstraints: NSLayoutConstraint!
    //@IBOutlet weak var deleteViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var detailsView: UIView!
    
    @IBOutlet weak var topSpaceConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var recordedHeightCon: NSLayoutConstraint!
    @IBOutlet weak var recordWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var dateHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var detailBtnHeightConstr: NSLayoutConstraint!
    @IBOutlet weak var detailBtnConstr: NSLayoutConstraint!
    
    @IBOutlet weak var descrptionConstr: NSLayoutConstraint!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Adding tap gestures to images
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        firstImage.addGestureRecognizer(tapGesture)
        secondImage.addGestureRecognizer(tapGesture)
        thirdImage.addGestureRecognizer(tapGesture)

        
    }
    
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        
        if let imgTap = sender.view as? UIImageView {
            print("Tag Value == \(imgTap.tag)")
            delegate?.PastRecdTableViewCellDelegate(tagValue:  imgTap.tag)

        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
protocol PastRecdTableViewCellDelegate {
    func PastRecdTableViewCellDelegate(tagValue:Int)
}
