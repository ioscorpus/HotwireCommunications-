//
//  SchedulARecordingViewController.swift
//  HotwireCommunications
//
//  Created by Dev on 28/02/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class SchedulARecordingViewController: UIViewController , UITableViewDataSource , UITableViewDelegate , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UIScrollViewDelegate , UISearchBarDelegate {
    
    
    @IBOutlet weak var dVRSpaceSchedulARecdView: UIView!
    @IBOutlet weak var dVRScheduleARecdLabel: UILabel!
    @IBOutlet weak var dVRScheduleARecdProgress: UIProgressView!
    @IBOutlet weak var dVRScheduleARecdValueLabel: UILabel!

    @IBOutlet weak var searchSchduleARecording: UISearchBar!
    @IBOutlet weak var segmentSchedulARecdView: UIView!
    @IBOutlet weak var segmentSchedulARecd: UISegmentedControl!
    
    @IBOutlet weak var scheduleARecdTable: UITableView!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var postSearchTableView: UITableView!
    
    
    let timeList:[String] = ["8:00 PM","8:30 PM","9:00 PM","9:30 PM","10:00 PM"]
    let preSearchList:[String] = ["The Americans","Fargo","Survivor"]
    let postSearchList:[String] = ["America's Got Talent","Amercican Idol","The Americans"]
    
    
    @IBOutlet weak var calendraView: UIView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.title = "Schedule a Recording".localized(lang: LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String, comment: "")
       
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.dVRSpaceSchedulARecdView.backgroundColor = kColor_DVRSpacebackground
        self.dVRScheduleARecdProgress.transform = CGAffineTransform.init(scaleX: 1.0, y: 10.0)
        self.dVRScheduleARecdProgress.setProgress(0.70, animated:false)
        self.dVRScheduleARecdProgress.tintColor = kColor_TabBarSelected
        self.dVRScheduleARecdProgress.trackTintColor = kColor_NavigationBarColor
        
        self.segmentSchedulARecdView.backgroundColor = UIColor.white
        self.segmentSchedulARecd.tintColor = kColor_TabBarSelected
        
        self.searchTableView.isHidden = true
        self.searchTableView.tableFooterView = UIView()
        
        self.postSearchTableView.isHidden = true
        self.postSearchTableView.tableFooterView = UIView()
        
        
        self.navigationItem.hidesBackButton = true
        
        
        let newBackButton = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SchedulARecordingViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
    
    }
    
    
    func back(sender: UIBarButtonItem) {
        
        print("click Back Button")
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    // ***** UITableView Method ***** //
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == searchTableView {
            
            return preSearchList.count
            
        }else if tableView == postSearchTableView
        {
            return postSearchList.count
           
        }else
        {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == searchTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier:"scheduleARecordingSearchTableViewCell") as! ScheduleARecordingSearchTableViewCell
            cell.searchNameLabel.text = preSearchList[indexPath.row]
            print("Cell Print inside pre tabel data: \(preSearchList[indexPath.row])")
            
            return cell
            
        }else if tableView == postSearchTableView
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:"postSearchTableViewCell") as! PostSearchTableViewCell
            cell.nameLabelPostSearch.text = postSearchList[indexPath.row]
            print("Cell Print inside post tabel data: \(postSearchList[indexPath.row])")
            
            if indexPath.row == 2 {
                
                cell.addDeleteRecdButton.setImage(UIImage(named:"dVR_Delete_Recording"), for: .normal)
            }
            cell.addDeleteRecdButton.tag = indexPath.row
            return cell

        }else
        {
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier:"schedulARecordTimeCell") as! SchedulARecordTimeCell
                
                for (index, element) in timeList.enumerated() {
                    
                    // print(index, ":", element)
                    
                    let timeButton : UIButton = UIButton()
                    timeButton.frame = CGRect(x: 151*index+1, y: 0, width: 150, height:31)
                    cell.timeScrolleView.addSubview(timeButton)
                    timeButton.setTitle(element, for: .normal)
                    timeButton.setTitleColor(kColor_TabBarSelected, for: .normal)
                    timeButton.backgroundColor = UIColor.white
                
                }
                
                cell.timeScrolleView.contentSize = CGSize(width: 150*timeList.count, height: 0)
                
                return cell
                
            }else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier:"schedulARecordingTableCell") as! SchedulARecordingTableCell
                
                return cell
            }
        }
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == searchTableView {
            
            return 44
            
        }else if tableView == postSearchTableView
        {
            return 60
            
        }else
        {
            if indexPath.row == 0 {
                
                return 50
                
            }else
            {
                return 65
            }
        }
    
    }
    
    // *********************************** //
    
    
    
    
    // ***** UICollectionView Method ***** //
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "schedulARecdCollectionViewCell", for: indexPath) as! SchedulARecdCollectionViewCell
        return cell
    }
    
    


    // *********************************** //
    
    
    @IBAction func clickCalendarButton(_ sender: UIButton) {
        
       print("click on calendra button")
    }
    
    @IBAction func clickTimeButton(_ sender: UIButton) {
        
        
    }
    
    @IBAction func clickSearchAddDeleteRecdButton(_ sender: UIButton) {
        
        
        let imageName = sender.tag
        print("get Button Image : \(imageName)")
        
        if sender.tag == 2 {
            
            customAlertControllerRecordingDelete(alertTittle: "Delete Recording", alertMessage: "Are you sure you want to delete The Americans from your DVR recordings?")
            
        }else
        {
        
          customAlertController(alertTittle: "Add Recording", alertMessage: "America's Got Talent will air 05/03/2017 at 8 PM - 10 PM on NBC. Do you wish to add this to your Fision Home DVR?")
        }
    }
    
    
    // ***** UISearchBar Method ***** //
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       
        print("searchBarTextDidBeginEditing")
        self.searchTableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        print("searchBarTextDidEndEditing")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       
        print("searchBarCancelButtonClicked")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("searchBarSearchButtonClicked")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
       print("searchBar")
       self.searchTableView.isHidden = true
       self.postSearchTableView.isHidden = false
       self.segmentSchedulARecdView.isHidden = true
       self.scheduleARecdTable.isHidden = true
       self.postSearchTableView.reloadData()
        
    }
    
    // *********************************** //
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func customAlertController(alertTittle: NSString, alertMessage: NSString)  {
        
        
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height:40)
        
        let otherButton : UIButton = UIButton()
        otherButton.frame = CGRect(x: 0, y: 0, width: 250, height:30)
        otherButton.setTitle("View Other Showtimes", for: .normal)
        otherButton.setTitleColor(UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0), for: .normal)
        vc.view.addSubview(otherButton)
        
        let actionSheetController: UIAlertController = UIAlertController(title: alertTittle as String, message: alertMessage as String, preferredStyle: .alert)
            actionSheetController.setValue(vc, forKey: "contentViewController")
        
        
        let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
            //Just dismiss the action sheet
            
            self.customAlertControllerRecordingAdded(alertTittle: "Recording Added", alertMessage: "America's Got Talent  has been added in your Fision Home DVR. For more information , please visit the Scheduled Recordings tab.")
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
     
        actionSheetController.addAction(yesAction)
        actionSheetController.addAction(cancelAction)
        
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    
    func customAlertControllerRecordingAdded(alertTittle: NSString, alertMessage: NSString)  {
        
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: alertTittle as String, message: alertMessage as String, preferredStyle: .alert)
        
        
        
        let yesAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
            
           self.navigationController?.popViewController(animated:true)
            
        }
        
    
        actionSheetController.addAction(yesAction)
   
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    
    
    
    func customAlertControllerRecordingDelete(alertTittle: NSString, alertMessage: NSString)  {
        
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: alertTittle as String, message: alertMessage as String, preferredStyle: .actionSheet)
        
        let deleteAction: UIAlertAction = UIAlertAction(title: "Delete", style: .destructive) { action -> Void in
            
            self.customAlertControllerRecordingDeleteConfermation(alertTittle: "Recording Deleted", alertMessage: "The Americans was successfully deleted from your fision Home DVR.")
            
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
            
        }
        
        
        actionSheetController.addAction(deleteAction)
        actionSheetController.addAction(cancelAction)
        
        
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    
    func customAlertControllerRecordingDeleteConfermation(alertTittle: NSString, alertMessage: NSString)  {
        
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: alertTittle as String, message: alertMessage as String, preferredStyle: .alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .destructive) { action -> Void in
            
            self.postSearchTableView.isHidden = true
            self.searchTableView.isHidden = false
        }
        
    
        actionSheetController.addAction(okAction)

        self.present(actionSheetController, animated: true, completion: nil)
    }


    
}
