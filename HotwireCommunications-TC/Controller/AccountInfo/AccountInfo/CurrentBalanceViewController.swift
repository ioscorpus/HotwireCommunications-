//
//  CurrentBalanceViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 12/01/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class CurrentBalanceViewController: BaseViewController {
  var listArray:[BillingInfo]?{
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
   <Date> 12/01/17 </Date>
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
   <Date> 12/01/17 </Date>
   </History>
   ***********************************************************************************************************/
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    methodToCreateViewList()
    self.title = "Current Balance"
  }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 12/01/17 </Date>
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
   <Date> 12/01/17 </Date>
   </History>
   ***********************************************************************************************************/
  func methodToCreateViewList(){
//    section 1
     let pastPayment = BillingInfoCell.init(title: "Your Payment Is Past Due", cellIdentifier:  cellIdentifier.RedBgWithWhiteText)
    let statementDate = BillingInfoCell.init(title: "Statement Date", withSubTextOne: "11/01/16", cellIdentifier: .HeaderWithDetailsRight)
 // section 2
    let viewFullStatement = BillingInfoCell.init(title: "View FullStatement", cellIdentifier: .BlueCenterHeaderWithSmallFont)
    let cable = BillingInfoCell.init(title: "Cable", withSubTextOne: "Total Charges", withSubTextTwo: "$0.00", cellIdentifier: cellIdentifier.RegularWithTwoDetailText)
    let internet = BillingInfoCell.init(title: "Internet", withSubTextOne: "Total Charges", withSubTextTwo: "$0.00", cellIdentifier: cellIdentifier.RegularWithTwoDetailText)
    let plainTelephone1 = BillingInfoCell.init(title: "Plain telephone 555 555-5554", withSubTextOne: "Total Charges", withSubTextTwo: "$0.00", cellIdentifier: cellIdentifier.RegularWithTwoDetailText)
    let plainTelephone2 = BillingInfoCell.init(title: "Plain telephone 555 555-1234", withSubTextOne: "Total Charges", withSubTextTwo: "$4.38", cellIdentifier: cellIdentifier.RegularWithTwoDetailText)
    let alarmOrSecurity = BillingInfoCell.init(title: "Alarm/Security", withSubTextOne: "Total Charges", withSubTextTwo: "$0.00", cellIdentifier: cellIdentifier.RegularWithTwoDetailText)
    let currentCharges = BillingInfoCell.init(title: "Current Charges", withSubTextOne: "$4.38", cellIdentifier: .HeaderWithBlackDetailText)
    let dueDate = BillingInfoCell.init(title: "Due Date", withSubTextOne: "11/11/16", cellIdentifier: .HeaderWithBlackDetailText)
    let pastDueDate = BillingInfoCell.init(title: "Past Due Date", withSubTextOne: "$25.00", cellIdentifier: .HeaderWithBlackDetailTextGrayBg)
    let totalDue = BillingInfoCell.init(title: "Total Due on 11/11/16 ", withSubTextOne: "$29.38", cellIdentifier: .HeaderWithBlackDetailText)
    let payBillNow = BillingInfoCell.init(title: "Pay Bill Now", cellIdentifier:  .BlueCenterHeaderWithBigFont)
    // section 3
    let previousBalance = BillingInfoCell.init(title: "Previous Balance", withSubTextOne: "$45.83", cellIdentifier: .CellDetailLabelWithOutAccessory)
    let previousPayment = BillingInfoCell.init(title: "Previous Payment", withSubTextOne: "Credit card processed on 10/11/16", withSubTextTwo: "$45.83", cellIdentifier: cellIdentifier.RegularWithTwoDetailText)
    // list formation
    let listSection1 = BillingInfo.init(sectionHeading: "", withList: [pastPayment!,statementDate!], iconList: nil)
    let listSection2 = BillingInfo.init(sectionHeading: "STATEMENT", withList: [viewFullStatement!,cable!,internet!,plainTelephone1!,plainTelephone2!,alarmOrSecurity!,currentCharges!,dueDate!,pastDueDate!,totalDue!,payBillNow!], iconList: nil)
    let listSection3 = BillingInfo.init(sectionHeading: "PREVIOUS STATEMENT", withList: [previousBalance!,previousPayment!], iconList: nil)
    
    listArray = [BillingInfo]()
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
   <Date>  12/01/17 </Date>
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
extension CurrentBalanceViewController: UITableViewDelegate,UITableViewDataSource {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let  headerCell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentier) as! HeaderTableViewCell
    let listObject:BillingInfo = listArray![section]
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
      let listObject:BillingInfo = listArray![section]
      if listObject.subList != nil{
        return (listObject.subList?.count)!
      }}
    return 1
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let listObject:BillingInfo = listArray![indexPath.section]
    let sublistObject:BillingInfoCell = listObject.subList![indexPath.row]
    
    switch sublistObject.cellIdentifierType {
    case .RegularWithTwoDetailText?:
      let cell = tableView.dequeueReusableCell(withIdentifier: (sublistObject.cellIdentifierType?.rawValue)!) as! HomeBasicTableViewCell
      cell.lblHeaderTitle.text = sublistObject.cellTitle
      cell.lblDetailText.text = sublistObject.cellDetailTitleOne
      cell.lblTwoDetailText.text = sublistObject.cellDetailTitleTwo
      return cell
    case .BlueColorHeader?,.BlueCenterHeaderWithSmallFont?,.BlueCenterHeaderWithBigFont?,.RedBgWithWhiteText?,.HeaderWithRightButton?,.CellWithoutDetail?:
      let cell = tableView.dequeueReusableCell(withIdentifier: sublistObject.cellIdentifierType!.rawValue) as! HomeBasicTableViewCell
      cell.lblHeaderTitle.text = sublistObject.cellTitle
      return cell
    case .HeaderWithBlackDetailText?,.HeaderWithBlackDetailTextGrayBg?,.CellDetailLabelWithOutAccessory?,.HeaderWithDetailsRight?,.HeaderWithDetailBotom?,.BlueTextWithDetail?:
      let cell = tableView.dequeueReusableCell(withIdentifier: sublistObject.cellIdentifierType!.rawValue) as! HomeBasicTableViewCell
      cell.lblHeaderTitle.text = sublistObject.cellTitle
      cell.lblDetailText.text = sublistObject.cellDetailTitleOne
      return cell
    default:
      return UITableViewCell()
    }
  }
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 0 {
       return 0
    }
    return 30
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let listObject:BillingInfo = listArray![indexPath.section]
    let sublistObject:BillingInfoCell = listObject.subList![indexPath.row]
    switch sublistObject.cellIdentifierType {
    case cellIdentifier.BlueColorHeader?,.RedBgWithWhiteText?,.BlueCenterHeaderWithSmallFont?,.BlueCenterHeaderWithBigFont?,.HeaderWithRightButton?,.HeaderWithDetailsRight?,.CellWithoutDetail?,.BlueTextWithDetail?,.HeaderWithBlackDetailText?,.CellDetailLabelWithOutAccessory?:
      return 46
    case cellIdentifier.HeaderWithDetailBotom?:
      return UITableViewAutomaticDimension
    case cellIdentifier.RegularWithTwoDetailText?:
      return 65
    default:
      return 0
    }
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
}
