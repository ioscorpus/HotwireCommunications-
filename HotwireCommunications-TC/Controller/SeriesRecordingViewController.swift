
//  SeriesRecordingViewController.swift
//  HotwireCommunications
//
//  Created by Dev on 28/02/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class SeriesRecordingViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var dVRSpaceSeriesView: UIView!
    @IBOutlet weak var dVRSpaceSeriesLabel: UILabel!
    @IBOutlet weak var dVRSeriesProgressView: UIProgressView!
    @IBOutlet weak var dVRSpaceSeriesValueLabel: UILabel!
    
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var addSeriesRecordingButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Series Recordings".localized(lang: LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String, comment: "")
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.dVRSpaceSeriesView.backgroundColor = kColor_DVRSpacebackground
        self.dVRSeriesProgressView.transform = CGAffineTransform.init(scaleX: 1.0, y: 10.0)
        self.dVRSeriesProgressView.setProgress(0.70, animated:false)
        self.dVRSeriesProgressView.tintColor = kColor_TabBarSelected
        self.dVRSeriesProgressView.trackTintColor = kColor_NavigationBarColor
        
        self.addSeriesRecordingButton.backgroundColor = kColor_TabBarSelected
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1;
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seriesRecordingCollectionCell", for: indexPath) as! SeriesRecordingCollectionCell
        cell.contentView.layer.borderWidth = 0.3
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let screenWidth: CGFloat = UIScreen.main.bounds.width
//        
//        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
//        {
//            // Ipad
//            print("call layout Collection Method inside ipad")
//            let cellWidth:CGFloat = screenWidth/3.0 - 20
//            return CGSize(cellWidth-5,cellWidth*1.25)
//        }
//        else
//        {
//            // Iphone
//            //print("call layout Collection Method inside iPhone")
//           // let cellWidth:CGFloat = screenWidth/2.0 - 20
//            //return CGSize(cellWidth-5,cellWidth*1.25)
//        }
//        
//    }
    
    
    // when device is roated
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape {
            
            print("Landscape")
            
            
        } else {
            
            print("Portrait")
            
        }
        
        self.seriesCollectionView .reloadData();
    }
    
    
    
    @IBAction func clickSeriesAddRecordingButton(_ sender: UIButton) {
        
        
    }


    @IBAction func clickSeriesDeleteButton(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func clickSeriesManageButton(_ sender: UIButton) {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
