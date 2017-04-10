//
//  SeriesRecordingCollectionCell.swift
//  HotwireCommunications
//
//  Created by Dev on 28/02/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class SeriesRecordingCollectionCell: UICollectionViewCell {
    
    
   
    @IBOutlet weak var seriesRecdCellImg: UIImageView!
    @IBOutlet weak var seriesRecdProgNameLabel: UILabel!
    @IBOutlet weak var seriesButtonsView: UIView!
    @IBOutlet weak var seriesDeleteButton: UIButton!
    @IBOutlet weak var seriesManageButton: UIButton!
    @IBOutlet weak var seriesCancelLabel: UILabel!
    @IBOutlet weak var seriesManageLabel: UILabel!
   
    
    override func draw(_ rect: CGRect) {
        
        self.seriesDeleteButton.layer.cornerRadius = self.seriesDeleteButton.frame.size.height/2
        self.seriesManageButton.layer.cornerRadius = self.seriesManageButton.frame.size.height/2
        
        self.seriesButtonsView.backgroundColor = UIColor.clear
        self.seriesCancelLabel.textColor = UIColor.white
        self.seriesManageLabel.textColor = UIColor.white
        
        self.seriesDeleteButton.layer.shadowColor = UIColor.black.cgColor
        self.seriesDeleteButton.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        
        self.seriesManageButton.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.seriesManageButton.layer.shadowColor = UIColor.black.cgColor
       
        
        //self.seriesRecdProgNameLabel.layer.borderWidth = 1.0
        //self.seriesRecdProgNameLabel.layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
