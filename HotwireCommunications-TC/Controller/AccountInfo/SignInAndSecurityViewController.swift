//
//  SignInAndSecurityViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 04/01/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class SignInAndSecurityViewController: BaseViewController {
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
   <Date>  04/01/17 </Date>
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
    self.title = "Sign In & Security"
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
    let logIn = AccountInfoCell.init(title:"Username", withSubText:"Nyeguy@hotwiremail.com", cellIdentifier: cellIdentifier.HeaderWithDetailBotom)
    let password = AccountInfoCell.init(title:"Password", withSubText:"LastChanged 7/12/16", cellIdentifier: .HeaderWithDetailBotom)
    
    let recoveryEmail  = AccountInfoCell.init(title:"Recovery Email", withSubText: "NyeGuy@gmail.com", cellIdentifier: .HeaderWithDetailBotom)
    let recoveryNumber = AccountInfoCell.init(title:"Recovery Number", withSubText:"(305) 555-5555", cellIdentifier: .HeaderWithDetailBotom)
    let recoveryText = AccountInfoCell.init(title:nil, withSubText:"if your forget your password or cannot access your account, we will use this information to help you to log back in.", cellIdentifier: .PragraphCellIdentifier)
    
    let securityPin = AccountInfoCell.init(title:"PIN", withSubText:"LastChanged 7/12/16", cellIdentifier: .HeaderWithDetailBotom)
    let securityText = AccountInfoCell.init(title:nil, withSubText:"If you call Customer Support, we will ask that you provide this personal identification number (PIN) to help protect you account from unauthorised individuals.", cellIdentifier: .PragraphCellIdentifier)
    
    let listSection1 = AccountInfo.init(sectionHeading: "LOG IN & PASSWORD", withList: [logIn!,password!], iconList: nil)
    let listSection2 = AccountInfo.init(sectionHeading: "RECOVERY OPTIONS", withList: [recoveryEmail!,recoveryNumber!,recoveryText!], iconList: nil)
    let listSection3 = AccountInfo.init(sectionHeading: "SECURITY", withList: [securityPin!,securityText!], iconList: nil)
    listArray = [AccountInfo]()
    listArray? = [listSection1!, listSection2! ,listSection3!]
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
  extension SignInAndSecurityViewController: UITableViewDelegate,UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.PragraphCellIdentifier.rawValue) as! HomeBasicTableViewCell
        cell.lblDetailText.text = sublistObject.cellDetailTitle
        return cell

      }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
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
        return UITableViewAutomaticDimension
      }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
}
