//
//  AccountRecoveryViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 08/11/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class AccountRecoveryViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
  var languageCode :String!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var contentView: UIView!
  
  @IBOutlet var lblPageTitle: UILabel!
  @IBOutlet var imageViewSearch: UIImageView!
  @IBOutlet var tableView: UITableView!
  // array
  var optionList:[String] = ["ResetPassword","RecoverUsername"]
  var selectedIndex:Int!
  
  //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 08/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewProperty()
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(_ animated: Bool) {
  self.navigationItem.setHidesBackButton(true, animated:true);
    viewUpdateContentOnBasesOfLanguage()
    addNotificationObserver()
    
  }
  override func viewDidAppear(_ animated: Bool) {
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //MARK:- Refresh view
  /***********************************************************************************************************
   <Name> viewUpdateContentOnBasesOfLanguage </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to update content on the bases of language</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  08/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    self.title =  "AccountRecovery".localized(lang: languageCode, comment: "")
    lblPageTitle.text = "AccountRecoveryPageHeader".localized(lang: languageCode, comment: "")
    // "AccountRecovery"  -> page title
  }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  08/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  func configureViewProperty(){
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 40
    tableView.tableFooterView = UIView()
     setUpCancelButonOnRight()
//    tableView.sectionHeaderHeight = UITableViewAutomaticDimension
//    tableView.sectionFooterHeight = UITableViewAutomaticDimension
  }
  //MARK:- Tableview delegate and datasource
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier_ForgotLoginHeader) as! ForgotLoginHeaderTableViewCell
    headerView.headingLbl.text = "RecoveryOption".localized(lang: languageCode, comment: "")
    return headerView
  }
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30
  }
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier_ForgotLoginHeader) as! ForgotLoginHeaderTableViewCell
     footerView.headingLbl.text = "AccountRecoveryInfo".localized(lang: languageCode, comment: "")
     return footerView
  }
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 80
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let reuseIdentifier = "cell"
    var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as UITableViewCell?
    if (cell == nil) {
      cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
    }
    cell!.textLabel?.text = optionList[indexPath.row].localized(lang: languageCode, comment: "")
    cell!.textLabel?.font = kFontStyleSemiBold18
    cell!.accessoryType = .disclosureIndicator
    cell!.selectionStyle = .none
    return cell!
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 55
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
     selectedIndex = indexPath.row
      self.performSegue(withIdentifier: kSegue_RecoveryOption, sender: self)
    case 1:
      selectedIndex = indexPath.row
       self.performSegue(withIdentifier: kSegue_RecoveryOption, sender: self)
    default:
      selectedIndex = indexPath.row
    }
  }
  //MARK:- IBoutlet
  /***********************************************************************************************************
   <Name> continueButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on Continue button tapped </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  08/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func continueButtonTappedAction(_ sender: AnyObject) {
    
  }
 
  /***********************************************************************************************************
   <Name> touchUpActionOnScrollview </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on scroll view tapped to end eaditing </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  08/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func touchUpActionOnScrollview(_ sender: AnyObject){
    self.contentView.endEditing(true)
  }
 
  // MARK: - Navigation
  /***********************************************************************************************************
   <Name> prepareForSegue </Name>
   <Input Type> UIStoryboardSegue,AnyObject </Input Type>
   <Return> void </Return>
   <Purpose> method call when segue called  </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  08/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    self.title = "Back"
    if segue.identifier == kSegue_RecoveryOption{
      if let nextViewController = segue.destination as? RecoveryOptionViewController {
        switch selectedIndex {
        case 0:
          nextViewController.viewTitle = "ResetPassword"
          nextViewController.tableViewHeader = "ResetPasswordHeader"
          nextViewController.optionList = resetPassword
          nextViewController.flowType = FlowType.ResetPassword
        case 1:
          nextViewController.viewTitle = "RecoverUsername"
          nextViewController.tableViewHeader = "RecoverUsernameHeader"
          nextViewController.optionList = recoverUsername
           nextViewController.flowType = FlowType.RecoverUsername
        default:
          nextViewController.tableViewHeader = ""
          nextViewController.viewTitle = ""
          nextViewController.optionList = []
        }
      }
    }
    
  }
  
  //MARK:- ADD notification
  /***********************************************************************************************************
   <Name> addNotificationObserver </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call when aplication come to foreground and update selected languge </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  08/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  func addNotificationObserver(){
    NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillEnterForeground(application:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    
  }
  //notification method to update UI
  func applicationWillEnterForeground(application: UIApplication) {
    let languageIndex = UserDefaults.standard.integer(forKey: "language")
    LanguageManager.sharedInstance.GetSelectedlanguageFromApplicationSetting(LanguageIndex: languageIndex)
    print("applicationWillEnterForeground")
    viewUpdateContentOnBasesOfLanguage()
  }
  override func viewDidDisappear(_ animated: Bool) {
    NotificationCenter.default.removeObserver(self)
  }
}


