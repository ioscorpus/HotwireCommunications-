//
//  SchedulARecordingInnnerController.swift
//  HotwireCommunications
//
//  Created by Dev on 16/03/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class SchedulARecordingInnnerController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate , UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var dVRSpaceSchedulARecdInnerView: UIView!
    @IBOutlet weak var dVRSpaceSchedulARecdInnerLabel: UILabel!
    @IBOutlet weak var dVRprogressSchedulARecdInnerView: UIProgressView!
    @IBOutlet weak var dVRValueSchedulARecdInnerLabel: UILabel!
    
    @IBOutlet weak var addRecordingButton: UIButton!
    @IBOutlet weak var schedulARecdInnerTableView: UITableView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Schedule a Recording".localized(lang: LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String, comment: "")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dVRSpaceSchedulARecdInnerView.backgroundColor = kColor_DVRSpacebackground
        self.dVRprogressSchedulARecdInnerView.transform = CGAffineTransform.init(scaleX: 1.0, y: 10.0)
        self.dVRprogressSchedulARecdInnerView.setProgress(0.70, animated:false)
        self.dVRprogressSchedulARecdInnerView.tintColor = kColor_TabBarSelected
        self.dVRprogressSchedulARecdInnerView.trackTintColor = kColor_NavigationBarColor
        
        self.addRecordingButton.backgroundColor = kColor_TabBarSelected
        self.schedulARecdInnerTableView.separatorColor = UIColor.clear
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*** Table View ***/
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"scheduleARecdInnerTableCell") as! ScheduleARecdInnerTableCell
        cell.chnnaelNameLabel?.text = "Akash Kushwaha"
        cell.backgroundColor = UIColor.white
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            // Ipad
            
            return 800
        }
        else
        {
            // Iphone
            
            return 450
        }

    }
    

    /*** Table View ***/
    
    
    /*** Collection View ***/

    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scheduleARecdInnerCollectionCell", for: indexPath) as! ScheduleARecdInnerCollectionCell
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    
    
    /*** Collection View ***/
    

    @IBAction func clickAddRecordingButton(_ sender: UIButton) {
       
    
    }
    
   

}
