//
//  AccountInfoViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 04/01/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class AccountInfoViewController: BaseViewController {
  var listArray:[AccountInfo]?{
    didSet {
      self.tableView.reloadData()
    }
  }
  var headerCellIdentier = "HeaderCell"
   // Iboutlet
  @IBOutlet var tableView: UITableView!
  //data variables
  var languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
  //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 04/01/17 </Date>
   </History>
   ***********************************************************************************************************/
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = 50
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.tableFooterView = UIView()
    configureViewProperty()
    addNotificationObserver()
    viewUpdateContentOnBasesOfLanguage()
    // Do any additional setup after loading the view.
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    DispatchQueue.main.async {
      self.configureViewProperty()
    }
  }
  //MARK:- Refresh view
  /***********************************************************************************************************
   <Name> viewUpdateContentOnBasesOfLanguage </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to update content on the bases of language</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 04/01/17 </Date>
   </History>
   ***********************************************************************************************************/
   func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    methodToCreateViewList()
    self.title = "Account Info"
   }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 04/01/17 </Date>
   </History>
   ***********************************************************************************************************/
  func configureViewProperty(){
    
    
  }
  /***********************************************************************************************************
   <Name> methodToCreateViewList </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to create a array list of object which is required to load the account list </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 04/01/17 </Date>
   </History>
   ***********************************************************************************************************/
  func methodToCreateViewList(){
    
    let accountInfo = AccountInfoCell.init(title:"Account Number", withSubText:"1234567890", cellIdentifier: cellIdentifier.HeaderWithDetailsRight)
    let accountService = AccountInfoCell.init(title:"My Current Services", withSubText:nil, cellIdentifier:cellIdentifier.HeaderWithRightButton)
    
    let serviceAddress = AccountInfoCell.init(title:"Brickell City Services", withSubText: "701 S Miami Ave Room 237 Miami 33131", cellIdentifier: cellIdentifier.HeaderWithDetailBotom)
    let phoneNumber = AccountInfoCell.init(title:"Primary Number", withSubText:"(305) 555-5555", cellIdentifier: .HeaderWithDetailsRight)
    let phoneNumber2 = AccountInfoCell.init(title:"Add a Second Number", withSubText:nil, cellIdentifier: .BlueColorHeader)
    let Email = AccountInfoCell.init(title:"PrimaryEmail", withSubText:"NyeGuy@hotwire.com", cellIdentifier: .HeaderWithDetailsRight)
    let Email2 = AccountInfoCell.init(title:"Add a Second Email", withSubText:nil, cellIdentifier: .BlueColorHeader)
    
    let listSection1 = AccountInfo.init(sectionHeading: "SectionOne", withList: [accountInfo!], iconList: nil)
    let listSection2 = AccountInfo.init(sectionHeading: "ACCOUNT SERVICES", withList: [accountService!], iconList: nil)
    let listSection3 = AccountInfo.init(sectionHeading: "SERVICE ADDRESS", withList: [serviceAddress!], iconList: nil)
    let listSection4 = AccountInfo.init(sectionHeading: "BILLING ADDRESS", withList: [serviceAddress!], iconList: nil)
    let listSection5 = AccountInfo.init(sectionHeading: "PHONE NUMBER", withList: [phoneNumber!,phoneNumber2!], iconList: nil)
    let listSection6 = AccountInfo.init(sectionHeading: "EMAIL", withList: [Email!,Email2!], iconList: nil)
    listArray = [AccountInfo]()
    listArray? = [listSection1!, listSection2! ,listSection3!, listSection4!,listSection5!, listSection6!]
  }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
   <Date>  04/01/17 </Date>
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
// MARK: - Tableview delegate and data source
extension AccountInfoViewController: UITableViewDelegate,UITableViewDataSource {
    
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let  headerCell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentier) as! HeaderTableViewCell
    let listObject:AccountInfo = listArray![section]
    headerCell.lblHeaderTitle.text = listObject.header
    return headerCell
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    if listArray == nil {
      return 0
    }
    return (listArray?.count)!
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (listArray?.count)! != 0{
      let listObject:AccountInfo = listArray![section]
      if listObject.subList != nil{
        return (listObject.subList?.count)!
      }}
    return 1
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let listObject:AccountInfo = listArray![indexPath.section]
    let sublistObject:AccountInfoCell = listObject.subList![indexPath.row]
    switch sublistObject.cellIdentifierType {
    case cellIdentifier.BlueColorHeader?:
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.BlueColorHeader.rawValue) as! HomeBasicTableViewCell
      cell.lblHeaderTitle.text = sublistObject.cellTitle
      return cell
    case cellIdentifier.HeaderWithDetailBotom?:
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.HeaderWithDetailBotom.rawValue) as! HomeBasicTableViewCell
      cell.lblHeaderTitle.text = sublistObject.cellTitle
      cell.lblDetailText.text = sublistObject.cellDetailTitle
      return cell
    case cellIdentifier.HeaderWithRightButton?:
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.HeaderWithRightButton.rawValue) as! HomeBasicTableViewCell
      cell.lblHeaderTitle.text = sublistObject.cellTitle
      return cell
    case cellIdentifier.HeaderWithDetailsRight?:
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.HeaderWithDetailsRight.rawValue) as! HomeBasicTableViewCell
      cell.lblHeaderTitle.text = sublistObject.cellTitle
      cell.lblDetailText.text = sublistObject.cellDetailTitle
      return cell
    default:
      return UITableViewCell()
    }
  }
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section > 0{
      return 30
    }
    return 0
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let listObject:AccountInfo = listArray![indexPath.section]
    let sublistObject:AccountInfoCell = listObject.subList![indexPath.row]
    switch sublistObject.cellIdentifierType {
    case cellIdentifier.BlueColorHeader?:
       return 46
    case cellIdentifier.HeaderWithDetailBotom?:
       return UITableViewAutomaticDimension
    case cellIdentifier.HeaderWithRightButton?:
       return 46
    case cellIdentifier.HeaderWithDetailsRight?:
       return 46
    default:
      return 0
    }
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

