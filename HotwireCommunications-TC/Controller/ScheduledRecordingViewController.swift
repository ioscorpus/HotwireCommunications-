//
//  ScheduledRecordingViewController.swift
//  HotwireCommunications
//
//  Created by Dev on 27/02/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class ScheduledRecordingViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var dVRSpaceView: UIView!
    @IBOutlet weak var dVRSpaceSchedulLabel: UILabel!
    @IBOutlet weak var dVRSchedulProgressView: UIProgressView!
    @IBOutlet weak var dVRSchedulValueLabel: UILabel!
    
    @IBOutlet weak var schedulTableView: UITableView!
    @IBOutlet weak var schedulAddRecdButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.title = "Scheduled Recordings".localized(lang: LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String, comment: "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dVRSpaceView.backgroundColor = kColor_DVRSpacebackground
        self.dVRSchedulProgressView.transform = CGAffineTransform.init(scaleX: 1.0, y: 10.0)
        self.dVRSchedulProgressView.setProgress(0.70, animated:false)
        self.dVRSchedulProgressView.tintColor = kColor_TabBarSelected
        self.dVRSchedulProgressView.trackTintColor = kColor_NavigationBarColor
        
        self.schedulAddRecdButton.backgroundColor = kColor_TabBarSelected
        
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = tableView.dequeueReusableCell(withIdentifier:"scheduledRecordHeaderCell") as! ScheduledRecordHeaderCell
        headerCell.schedulHeaderLabel.text = "Today"
        return headerCell
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"scheduledrecordTableCell") as! ScheduledrecordTableCell
        cell.schedProgNameLabel.text = "The Americans"
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 155
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 38
    }



    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func clickSchedulAddRecdButton(_ sender: UIButton) {
        
        print("clickSchedulAddRecdButton")
        
        let scheduledRecordingController = self.storyboard?.instantiateViewController(withIdentifier: "schedulARecordingViewController") as! SchedulARecordingViewController
        self.navigationController?.pushViewController(scheduledRecordingController, animated: true)
        
    }
    
    @IBAction func clickSchedulDeleteButton(_ sender: UIButton) {
        
        print("clickSchedulDeleteButton")
        customAlertController(alertTittle: "Delete Recording", alertMessage: "Are you sure you want to delete 'The Americans' from your DVR recordings?")
        
    }
   
    
    @IBAction func clickSchedulOptionButton(_ sender: UIButton) {
        
        print("clickSchedulOptionButton")
    }
    
    
    
    // *** UIAlertController *** //
    
    func customAlertController(alertTittle: NSString, alertMessage: NSString)  {
        
        
        let actionSheetController: UIAlertController = UIAlertController(title: alertTittle as String, message: alertMessage as String, preferredStyle: .alert)
        
        let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .default) { action -> Void in
            //Just dismiss the action sheet
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
        actionSheetController.addAction(yesAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }

}
