//
//  PastRecordingDetailsController.swift
//  HotwireCommunications
//
//  Created by Dev on 15/03/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class PastRecordingDetailsController: UIViewController , UITableViewDelegate , UITableViewDataSource , UICollectionViewDataSource , UICollectionViewDelegate  {
    
    
    @IBOutlet weak var dVRSpacePastDetailView: UIView!
    @IBOutlet weak var dVRSpacePastDetailLabel: UILabel!
    @IBOutlet weak var dVRprogressPastDetailView: UIProgressView!
    @IBOutlet weak var dVRValuePastDetailLabel: UILabel!
    
    
    @IBOutlet weak var reviewsButton: UIButton!
    @IBOutlet weak var rightArrowImage: UIImageView!
    
    @IBOutlet weak var pastRecdInnerCollectionView: UICollectionView!
    @IBOutlet weak var pastRecdInnerImage: UIImageView!
    
    @IBOutlet weak var pastDetailsTableView: UITableView!
    
    var cell = PastRecordingDetailsCell()
   // var collectionItem = PastRecdInnerCollectionViewCell()
    
      var collectionIdentifier : String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Past Recordings Details".localized(lang: LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String, comment: "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.dVRSpacePastDetailView.backgroundColor = kColor_DVRSpacebackground
        self.dVRprogressPastDetailView.transform = CGAffineTransform.init(scaleX: 1.0, y: 10.0)
        self.dVRprogressPastDetailView.setProgress(0.70, animated:false)
        self.dVRprogressPastDetailView.tintColor = kColor_TabBarSelected
        self.dVRprogressPastDetailView.trackTintColor = kColor_NavigationBarColor
        
        self.pastDetailsTableView.separatorColor = UIColor.clear
        
       let cellnibArray = Bundle.main.loadNibNamed("PastRecordingDetailsCell", owner: self, options: nil)
    
        
      
   // let itemsArray = Bundle.main.loadNibNamed("PastRecdInnerCollectionViewCell", owner: self, options: nil)

//        
//        guard itemsArray != nil else {
//            print("Collection View not getting")
//            return
//        }
//        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            cell = cellnibArray?[1] as! PastRecordingDetailsCell
            
      //      collectionItem = itemsArray?[1] as! PastRecdInnerCollectionViewCell
      //      collectionIdentifier = "PastRecdInnerCollectionViewCellIpad"

        }else{
            cell = cellnibArray?[0] as! PastRecordingDetailsCell
        //    collectionItem = itemsArray?[0] as! PastRecdInnerCollectionViewCell
         //   collectionIdentifier = "PastRecdInnerCollectionViewCellIphone"


        }
        
       // let nib = UINib(nibName: "PastRecdInnerCollectionViewCell", bundle: nil)
       // cell.pastInnerCollectionView.register(nib, forCellWithReuseIdentifier: "PastRecdInnerCollectionViewCell")
    
      cell.pastInnerCollectionView.register(UINib(nibName: "PastRecdInnerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PastRecdInnerCollectionViewCell")
        
        print("Loaded View")
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
            return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.characterName.text = "Ramesh"
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
           return 800
        }else
        {
            return 480
            
        }
    }

    
    
    
    /*** Collection View ***/
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
//        let itemsArray = Bundle.main.loadNibNamed("PastRecdInnerCollectionViewCell", owner: self, options: nil)
// 
//        collectionItem = itemsArray?[1] as! PastRecdInnerCollectionViewCell
//        collectionIdentifier = "PastRecdInnerCollectionViewCellIpad"
         //collectionItem = collectionView.dequeueReusableCell(withReuseIdentifier: collectionIdentifier, for: indexPath) as! PastRecdInnerCollectionViewCell
        
         //let cell : PastRecdInnerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PastRecdInnerCollectionViewCell", for: indexPath) as! PastRecdInnerCollectionViewCell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PastRecdInnerCollectionViewCell", for: indexPath)
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    
//     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        return CGSize(300,400);
//    }
    
    /*********************/ 
    
    



}
