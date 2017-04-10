//
//  RecoveryOptionViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 09/11/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class RecoveryOptionViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
  var languageCode :String!
  @IBOutlet var tableView: UITableView!
  var optionList:[String]!
  //Content
  var viewTitle:String!
  var tableViewHeader:String!
  // flow
   var flowType:FlowType!
  
  //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 09/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewProperty()
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(_ animated: Bool) {
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
   <Date>  09/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    self.title =  viewTitle.localized(lang: languageCode, comment: "")
    setUpBackButonOnLeft()
  }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  09/11/16 </Date>
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
  /***********************************************************************************************************
   <Name> setUpBackButonOnLeft </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to set the custom back button </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  func setUpBackButonOnLeft(){
    self.navigationItem.setHidesBackButton(true, animated:true);
    let btn1 = UIButton(frame:KFrame_CancelBarbutton )
    btn1.setTitle("Back".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btn1.imageEdgeInsets = imageEdgeInsets;
    btn1.titleEdgeInsets = titleEdgeInsets;
    btn1.setImage(UIImage(named: "RedBackBtn"), for: UIControlState.normal)
    btn1.addTarget(self, action: #selector(RecoveryOptionViewController.backButtonTappedAction(_:)), for: .touchUpInside)
    self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: btn1), animated: true);
  }
  //MARK:- Tableview delegate and datasource
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier_ForgotLoginHeader) as! ForgotLoginHeaderTableViewCell
    headerView.headingLbl.text = tableViewHeader.localized(lang: languageCode, comment: "")
    return headerView
  }
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 60
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return optionList.count
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
    return 50
  }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name:kStoryBoardSignUp, bundle: nil)
    switch indexPath.row {
    case 0:
      let mainViewController = storyboard.instantiateViewController(withIdentifier: kStoryBoardID_PhoneNoVarification) as! SignUpEnterMobNoViewController
      mainViewController.flowType = flowType
      self.navigationController?.pushViewController(mainViewController, animated: true)
    case 1:
      let mainViewController = storyboard.instantiateViewController(withIdentifier: kStoryBoardID_EmailVarification) as! SignUpEnterEmailViewController
      mainViewController.flowType = flowType
      self.navigationController?.pushViewController(mainViewController, animated: true)
      //  self.performSegueWithIdentifier(kSegue_ResetEmail, sender: self)
    case 2:
       print("Show the customer number reset screen")
    default:
       print(" there is no selected item")
    }
  }
  //MARK:- IBoutlet
  /***********************************************************************************************************
   <Name> touchUpActionOnScrollview </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on scroll view tapped to end eaditing </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  09/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func touchUpActionOnScrollview(_ sender: AnyObject){
    self.view.endEditing(true)
  }
  /***********************************************************************************************************
   <Name> backButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on custom back  button tapped </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  func backButtonTappedAction(_ sender : UIButton){
    self.navigationController!.popViewController(animated: true)
  }

  // MARK: - Navigation
  /***********************************************************************************************************
   <Name> prepareForSegue </Name>
   <Input Type> UIStoryboardSegue,AnyObject </Input Type>
   <Return> void </Return>
   <Purpose> method call when segue called  </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  09/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    self.title = "Back"
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
  }
  //MARK:- ADD notification
  /***********************************************************************************************************
   <Name> addNotificationObserver </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call when aplication come to foreground and update selected languge </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  09/11/16 </Date>
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
