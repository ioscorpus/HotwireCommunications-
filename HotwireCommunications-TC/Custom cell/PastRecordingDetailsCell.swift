//
//  PastRecordingDetailIphoneCell.swift
//  HotwireCommunications
//
//  Created by Dev on 05/04/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class PastRecordingDetailsCell: UITableViewCell  {
    
    
    @IBOutlet weak var pastInnerCollectionView: UICollectionView!

    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var characterName: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //self.pastInnerCollectionView.register(UINib(nibName: "PastRecdInnerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PastRecdInnerCollectionViewCell")
//        let nib = UINib(nibName: "PastRecdInnerCollectionViewCell", bundle: nil)
//        
//        self.pastInnerCollectionView.register(nib, forCellWithReuseIdentifier: "PastRecdInnerCollectionViewCell")
//        print("Colloction intilized")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
//    
//    /*** Collection View ***/
//    
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1;
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 20;
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
//    {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PastRecdInnerCollectionViewCell", for: indexPath)
//        cell.layer.borderColor = UIColor.lightGray.cgColor
//        cell.layer.borderWidth = 0.5
//        return cell
//    }
//    
//    /*********************/ 
//
    
}
