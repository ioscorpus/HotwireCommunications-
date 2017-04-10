//
//  HelpViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 05/09/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class TVViewController: BaseViewController {
    
    
  let headerList :[String] = ["MY_TV_SERVICE","FISION HOME DVR","MY_REMOTE_CONTROL","MY_CHANNEL_LINEUP"]
  let tvList:[String] = ["Video_On_Demand","TV_Network_Apps","Community_Video"]
  let dvrList:[String] = ["Past Recordings","Scheduled Recordings","Series Recordings","Schedule a Recording"]
  let remoteControllList:[String] = ["Remote_Control"]
  let channelLineupList:[String] =  ["TV_Listings","Channel_Lineup","Upgrade_TV_Service"]
  var languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    
  let dVRBoxList:[String] = ["Dad's DVR","Family Room DVR"]
  var dvrPopupTableView : UITableView = UITableView()
  var screenWidth : CGFloat!
  var screenHeight : CGFloat!
  
    @IBOutlet weak var rightNavigationButton: UIBarButtonItem!
    
    
  var listArray:[[String]]!
  @IBOutlet var topImageView: UIImageView!
  @IBOutlet var tableView: UITableView!
  var headerReuseIdentifier = "HeaderCell"
  var cellReuseIdentifier = "RegularCell"
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpLeftImageOnNavigationBar()
        listArray = [tvList,dvrList,remoteControllList,channelLineupList]
        tableView.delegate = self
        tableView.dataSource = self
        
        screenWidth = UIScreen.main.bounds.width
        screenHeight = UIScreen.main.bounds.height
        
    }
    
    
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.title = "TV".localized(lang: languageCode, comment: "")
      
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    @IBAction func clickRightNavigationButton(_ sender: UIBarButtonItem) {
        
         print("clickRightNavigationButton")
        
    }
    
    
    
}





// MARK: - Tableview delegate and data source
extension TVViewController: UITableViewDelegate,UITableViewDataSource {
    
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        if tableView == dvrPopupTableView {
            
            let headerCell = UITableViewCell()
            return headerCell
            
        }else
        {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: headerReuseIdentifier) as! HeaderTableViewCell
            headerCell.lblHeaderTitle.text = headerList[section].localized(lang: languageCode, comment: "")
            return headerCell
        }
    

   }
    
   func numberOfSections(in tableView: UITableView) -> Int {
    
    if tableView == dvrPopupTableView {
        
        return 1;
    }else
    {
         return headerList.count
    }
    
   }
    
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if tableView == dvrPopupTableView {
            
            return dVRBoxList.count
        }else
        {
            
           return listArray[section].count
        }
    
   }
   
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if tableView == dvrPopupTableView
        {
        
           let cell = tableView.dequeueReusableCell(withIdentifier:"dVRPopUPTableViewCell") as! DVRPopUPTableViewCell
           cell.dvrPopUPNameLabel?.text = dVRBoxList[indexPath.row]
           cell.dvrPopUPRadioImage?.image = UIImage(named:"UnselectedRound")
           cell.selectionStyle = .none
           cell.backgroundColor = UIColor.clear
           return cell
            
        }else
        {
             let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! HomeBasicTableViewCell
             cell.lblHeaderTitle.text = listArray[indexPath.section][indexPath.row].localized(lang: languageCode, comment: "")
             cell.lblDetailText?.text = ""
             return cell
        }
   }
  
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if tableView == dvrPopupTableView {
            
             dvrPopupTableView.reloadData()
             let cell:DVRPopUPTableViewCell? = tableView.cellForRow(at: indexPath) as! DVRPopUPTableViewCell?
            
             if cell?.dvrPopUPRadioImage.image == UIImage(named:"SelectedRound") {
                
               cell?.dvrPopUPRadioImage.image = UIImage(named:"UnselectedRound")
             }else
             {
                cell?.dvrPopUPRadioImage.image = UIImage(named:"SelectedRound")
             }
         
            
        }else
        {
            if indexPath.section == 1{
                
                dvrPopupTableView.reloadData()
                
                if indexPath.row == 0 {
                    
                    
                    customAlertController(alertIndex: 0)
                    // performSegue(withIdentifier: "PostRecordingSegue", sender: self)
                    // dvrPopupTableView.isHidden = false
                    
                }else if indexPath.row == 1 {
                    
                     customAlertController(alertIndex: 1)
                   // performSegue(withIdentifier: "SchedulRecordingSegue", sender: self)
                    
                }else if indexPath.row == 2 {
                    
                     customAlertController(alertIndex: 2)
                    //performSegue(withIdentifier: "SeriesRecordingSegue", sender: self)
                    
                }else if indexPath.row == 3 {
                    
                     customAlertController(alertIndex: 3)
                    //performSegue(withIdentifier: "SchedulARecordingSegue", sender: self)
                }
                
            } else if indexPath.section == 2
            {
                let remoteController = self.storyboard?.instantiateViewController(withIdentifier: "remoteViewController") as!  RemoteViewController
                self.navigationController?.present(remoteController, animated: true, completion: nil)
            }
        }
    }
    
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
    if tableView == dvrPopupTableView {
        
         return 0
    }else
    {
         return 25
    }
    
   
   }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    if tableView == dvrPopupTableView {
        
        return 50
    }else
    {
        return 55
    }
   }
    
    
    
    // *** UIAlertController *** //

    func customAlertController(alertIndex: Int)  {
        
        
        
        let vc = UIViewController()
        
        let localHeight:CGFloat = CGFloat(50 * dVRBoxList.count)
        
        if localHeight > 250 {
            
            vc.preferredContentSize = CGSize(width: 250,height:200)
            dvrPopupTableView.frame = CGRect(x: 0, y: 0, width: 250, height:200)
            
        }else
        {
            vc.preferredContentSize = CGSize(width: 250,height:localHeight)
            dvrPopupTableView.frame = CGRect(x: 0, y: 0, width: 250, height:localHeight)
        }
        
        dvrPopupTableView.delegate = self
        dvrPopupTableView.dataSource = self
        dvrPopupTableView.bounces = false
        dvrPopupTableView.backgroundColor = UIColor.clear
        let nib = UINib(nibName: "DVRPopUPTableViewCell", bundle: nil)
        dvrPopupTableView.register(nib, forCellReuseIdentifier: "dVRPopUPTableViewCell")
        vc.view.addSubview(dvrPopupTableView)
        
        let editRadiusAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Select", style: .cancel, handler: { action in
            
            print("pressed")
            
            if alertIndex == 0
            {
                let scheduledRecordingController = self.storyboard?.instantiateViewController(withIdentifier: "pastRecordingsViewController") as!  PastRecordingsViewController
                self.navigationController?.pushViewController(scheduledRecordingController, animated: true)
                
            }else if alertIndex == 1
            {
                let scheduledRecordingController = self.storyboard?.instantiateViewController(withIdentifier: "scheduledRecordingViewController") as! ScheduledRecordingViewController
                self.navigationController?.pushViewController(scheduledRecordingController, animated: true)
                
            }else if alertIndex == 2
            {
                let scheduledRecordingController = self.storyboard?.instantiateViewController(withIdentifier: "seriesRecordingViewController") as! SeriesRecordingViewController
                self.navigationController?.pushViewController(scheduledRecordingController, animated: true)
                
            }else if alertIndex == 3
            {
                let scheduledRecordingController = self.storyboard?.instantiateViewController(withIdentifier: "schedulARecordingViewController") as! SchedulARecordingViewController
                self.navigationController?.pushViewController(scheduledRecordingController, animated: true)
            }
            
            
        }))
        self.present(editRadiusAlert, animated: true)
        
        
    }
    
   

  
}
