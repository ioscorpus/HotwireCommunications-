//
//  BillingInfoViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 09/01/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class BillingInfoViewController: BaseViewController {
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
   <Date> 09/01/17 </Date>
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
   <Date> 09/01/17 </Date>
   </History>
   ***********************************************************************************************************/
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    methodToCreateViewList()
    self.title = "Billing Info"
  }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 09/01/17 </Date>
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
   <Date> 09/01/17 </Date>
   </History>
   ***********************************************************************************************************/
  func methodToCreateViewList(){
    let amountDue = BillingInfoCell.init(title: "Total Amount Due", withSubTextOne: "IncluingPastDueAmount", withSubTextTwo: "$29.38", cellIdentifier: cellIdentifier.RegularWithTwoDetailText)
    let paymentDueOn = BillingInfoCell.init(title: "Payment Due On", withSubTextOne: "11/11/16", cellIdentifier: cellIdentifier.HeaderWithDetailsRight)
    let payBill = BillingInfoCell.init(title: "Pay Bill", cellIdentifier:  cellIdentifier.BlueColorHeader)
    let payDifferentAmount = BillingInfoCell.init(title: "Pay Different Amount", cellIdentifier:  cellIdentifier.BlueColorHeader)
    let setupAutoPayment = BillingInfoCell.init(title: "Setup Auto Payment", cellIdentifier:  cellIdentifier.BlueColorHeader)
    let paperlessBilling = BillingInfoCell.init(title: "Paperless Billing", withSubTextOne: "Not Enrolled", cellIdentifier: cellIdentifier.BlueTextWithDetail)
   let BillHistory = BillingInfoCell.init(title: "Bill Statement History",cellIdentifier:cellIdentifier.CellWithoutDetail)
   let understandingYourBill = BillingInfoCell.init(title: "Understanding Your Bill", cellIdentifier:  cellIdentifier.BlueColorHeader)
    
    let listSection1 = BillingInfo.init(sectionHeading: "BALANCE SUMMARY", withList: [amountDue!,paymentDueOn!], iconList: nil)
    let listSection2 = BillingInfo.init(sectionHeading: "PAYMENT OPTIONS", withList: [payBill!,payDifferentAmount!,setupAutoPayment!], iconList: nil)
    let listSection3 = BillingInfo.init(sectionHeading: "BILLING OPTIONS", withList: [paperlessBilling!,BillHistory! ,understandingYourBill!], iconList: nil)
    
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
   <Date>  09/01/17 </Date>
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
extension BillingInfoViewController: UITableViewDelegate,UITableViewDataSource {
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
    case cellIdentifier.RegularWithTwoDetailText?:
      let cell = tableView.dequeueReusableCell(withIdentifier: sublistObject.cellIdentifierType!.rawValue) as! HomeBasicTableViewCell
      cell.lblHeaderTitle.text = sublistObject.cellTitle
      cell.lblDetailText.text = sublistObject.cellDetailTitleOne
      cell.lblTwoDetailText.text = sublistObject.cellDetailTitleTwo
      return cell
    case cellIdentifier.CellWithoutDetail?:
      let cell = tableView.dequeueReusableCell(withIdentifier: sublistObject.cellIdentifierType!.rawValue) as! HomeBasicTableViewCell
      cell.lblHeaderTitle.text = sublistObject.cellTitle
      return cell
    case cellIdentifier.BlueColorHeader?:
      let cell = tableView.dequeueReusableCell(withIdentifier: sublistObject.cellIdentifierType!.rawValue) as! HomeBasicTableViewCell
      cell.lblHeaderTitle.text = sublistObject.cellTitle
      return cell
    case cellIdentifier.BlueTextWithDetail?:
      let cell = tableView.dequeueReusableCell(withIdentifier: sublistObject.cellIdentifierType!.rawValue) as! HomeBasicTableViewCell
      cell.lblHeaderTitle.text = sublistObject.cellTitle
      cell.lblDetailText.text = sublistObject.cellDetailTitleOne
      return cell
    case cellIdentifier.HeaderWithDetailBotom?:
      let cell = tableView.dequeueReusableCell(withIdentifier: sublistObject.cellIdentifierType!.rawValue) as! HomeBasicTableViewCell
      cell.lblHeaderTitle.text = sublistObject.cellTitle
      cell.lblDetailText.text = sublistObject.cellDetailTitleOne
      return cell
    case cellIdentifier.HeaderWithRightButton?:
      let cell = tableView.dequeueReusableCell(withIdentifier: sublistObject.cellIdentifierType!.rawValue) as! HomeBasicTableViewCell
      cell.lblHeaderTitle.text = sublistObject.cellTitle
      return cell
    case cellIdentifier.HeaderWithDetailsRight?:
      let cell = tableView.dequeueReusableCell(withIdentifier: sublistObject.cellIdentifierType!.rawValue) as! HomeBasicTableViewCell
      cell.lblHeaderTitle.text = sublistObject.cellTitle
      cell.lblDetailText.text = sublistObject.cellDetailTitleOne
      return cell
    default:
      return UITableViewCell()
    }
  }
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return 30
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let listObject:BillingInfo = listArray![indexPath.section]
    let sublistObject:BillingInfoCell = listObject.subList![indexPath.row]
    switch sublistObject.cellIdentifierType {
    case cellIdentifier.BlueColorHeader?:
      return 46
    case cellIdentifier.HeaderWithDetailBotom?:
      return UITableViewAutomaticDimension
    case cellIdentifier.HeaderWithRightButton?:
      return 46
    case cellIdentifier.HeaderWithDetailsRight?:
      return 46
    case cellIdentifier.RegularWithTwoDetailText?:  
       return 65
    case cellIdentifier.CellWithoutDetail?:
      return 46
    case cellIdentifier.BlueTextWithDetail?:
       return 46
    default:
      return 0
    }
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section {
    case 0:
      if indexPath.row == 0{
        self.performSegue(withIdentifier: kSegue_CurrentBalance, sender: self)
      }else{
        
      }
    case 1:
      if indexPath.row == 0{
        self.performSegue(withIdentifier: kSegue_PayBill, sender: self)
      }else if indexPath.row == 1{
        self.performSegue(withIdentifier: kSegue_PayDiffrent, sender: self)
      }else{
        
      }
    default:
      print("No action on \(indexPath.section) section and \(indexPath.row) row")
    } 
  }
}

