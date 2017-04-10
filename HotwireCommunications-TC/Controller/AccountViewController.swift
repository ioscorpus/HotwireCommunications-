//
//  WhatNewViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 16/11/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit
// import SynacorCloudId
protocol UserDetailsViewControllerDelegate: class {
    
  func userDetailsViewControllerDidRequestLogout(viewController: AccountViewController)
}

class AccountViewController: BaseViewController {
    
  var listArray:[AnyObject]?{
    didSet {
      self.tableView.reloadData()
    }
  }
 
  @IBOutlet var tableView: UITableView!
  // cell identifier
  var headerReuseIdentifier = "HeaderCell"
  var cellReuseIdentifier = "RegularCell"
  var cellwithStringReuseIdentifier = "stringWithRegularCell"
  var cellWithMessageNotification = "BillNotification"
  var cellWithProfilePicture =  "ProfilePicture"
  // user credential
  var userName:String = "John Smith"
  var userAddress:String = "BRICKED CITY CENTRE"
  var userProfilePicture:UIImage = UIImage(named:"Placeholder")!
  weak var delegate: UserDetailsViewControllerDelegate?
  var languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
  // picker controller
  let picker = UIImagePickerController()
  var profilePicture:UIImage?
  //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 17/11/16 </Date>
   </History>
   ***********************************************************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.navigationBar.isHidden = false
      setUpImageOnNavigationBarCenterTitle()
      tableView.delegate = self
      tableView.dataSource = self
      tableView.estimatedRowHeight = 50
      tableView.rowHeight = UITableViewAutomaticDimension
      picker.delegate = self
      // Do any additional setup after loading the view.
    }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
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
   <Date>  17/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
     methodToCreateViewList()
//     lblTitle.text = "Account".localized(lang: languageCode, comment: "")

  }
  
 /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  17/11/16 </Date>
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
   <Date> 16/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  func methodToCreateViewList(){
//  let userAccountList = ["Log In & Security","Contact Info","Family Members"]
//  let serviceAccount = ["News & Messages","Pay Bill","Bill Details & History","Billing Preferences"]
//  let serviceLocationSubHeading = "Pelican Landing"
//  let serviceLocationDetail = " 1267 Blue Jay Way \n Naples, Fl 12345 \n Account #1765432"
//  let appSetting  = ["Language", "Notifications"]
//  let legalInfo = ["Privacy Policy", "Terms of Use","Log Out"]
    //
   let profile = ["ProfilePicture"]
   let billNotificatin = ["PayBill","Messages"]
   let billManagement = ["Billing Info"]
    
   let accountManagement = ["Account Info","Sign In & Security","Contact Info","Family Members"]
   let appSettingContent = ["Language","Notifications","Sign Out"]
    
    let billManagementIcons = ["billingInfoIcon"]
    let accountManagementIcons = ["acctNumIcon", "securityIcon", "infoIcon", "familyIcon"]
    let appSettingContentIcons = ["languageIcon", "notificationsIcon", "signOutIcon"]
    
  let listSection1 = listSection.init(sectionHeading:"USER PROFILE" , withList: profile, detailText:nil)
  let listSection2 = listSection.init(sectionHeading:"billNotificatin", detailText:(billNotificatin[0],billNotificatin[1]))
  let listSection3 = listSection.init(sectionHeading: "BILL MANAGEMENT", withList: billManagement, iconList: billManagementIcons)
  let listSection4 = listSection.init(sectionHeading: "ACCOUNT MANAGEMENT", withList: accountManagement, iconList: accountManagementIcons)
   let listSection5 = listSection.init(sectionHeading: "APP SETTINGS", withList: appSettingContent, iconList: appSettingContentIcons)
    listArray = [AnyObject]()
    listArray? = [listSection1, listSection2 ,listSection3, listSection4,listSection5]
  }

  // MARK: - Navigation
  /***********************************************************************************************************
   <Name> prepareForSegue </Name>
   <Input Type> UIStoryboardSegue,AnyObject </Input Type>
   <Return> void </Return>
   <Purpose> method call when segue called  </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  16/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
  }
  //MARK:- ADD notification
  /***********************************************************************************************************
   <Name> addNotificationObserver </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call when aplication come to foreground and update selected languge </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>   16/11/16 </Date>
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
extension AccountViewController: UITableViewDelegate,UITableViewDataSource {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let  headerCell = tableView.dequeueReusableCell(withIdentifier: headerReuseIdentifier) as! HeaderTableViewCell
    let listObject:listSection = listArray![section] as! listSection
    headerCell.lblHeaderTitle.text = listObject.header
      //headerTitle.localized(lang: languageCode, comment: "")
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
    let listObject:listSection = listArray![section] as! listSection
    if listObject.subList != nil{
      return (listObject.subList?.count)!
      }}
    return 1
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let listObject:listSection = listArray![indexPath.section] as! listSection
    if indexPath.section == 0{
    let cell = tableView.dequeueReusableCell(withIdentifier: cellWithProfilePicture) as! ProfilePictureTableViewCell
          cell.lblUserName.text = userName
          cell.lblUserAddress.text = userAddress
          cell.delegate = self
      if profilePicture != nil{
         cell.profilePicImgview.image = profilePicture
      }
      return cell
    }else if listObject.subList == nil{
    let cell = tableView.dequeueReusableCell(withIdentifier: cellWithMessageNotification) as! BillNotificationTableViewCell
      cell.lblIndexOneTitle.text = listObject.subStringHeaderOne
      cell.lblIndexTwoTitle.text = listObject.subStringHeaderTwo
      return cell
    }else{
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! HomeBasicTableViewCell
      if indexPath.section == 4 && indexPath.row == 2{
      cell.lblHeaderTitle.textColor = kColor_LogoutButton
      cell.accessoryType = .none
      }else{
      cell.lblHeaderTitle.textColor = UIColor.black
      cell.accessoryType = .disclosureIndicator
      }
       cell.lblHeaderTitle.text = listObject.subList![indexPath.row]
       cell.iconImageView.image = UIImage(named:listObject.subIconList![indexPath.row])!
       cell.lblDetailText?.text = ""
      return cell
    }
  }
 func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
  if section > 1{
    return 30
  }
    return 0
  }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let listObject:listSection = listArray![indexPath.section] as! listSection
    if indexPath.section == 0{
    return 200
    }else if listObject.subList == nil{
    return 113
    }
    return 52
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("No action on \(indexPath.section) section and \(indexPath.row) row")
    switch indexPath.section {
    case 2:
       self.performSegue(withIdentifier: kSegue_BillingInfo, sender: self)
    case 3:
      switch indexPath.row {
      case 0:
        self.performSegue(withIdentifier: kSegue_AccountInfoScreen, sender: self)
      case 1:
        self.performSegue(withIdentifier: kSegue_SignInAndSecurity, sender: self)
      case 2:
        self.performSegue(withIdentifier: kSegue_ContactInfo, sender: self)
      case 3:
        self.performSegue(withIdentifier: kSegue_FamilyMember, sender: self)

      default:
        print("No action on \(indexPath.section) section and \(indexPath.row) row")
      }
    case 4:
      switch indexPath.row {
       case 1:
        self.performSegue(withIdentifier: kSegue_Notification, sender: self)
       case 2:
        HotwireCommunicationApi.sharedInstance.cloudId?.clearKeychain()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard(name:kStoryBoardMain, bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: kStoryBoardID_LoginPage) as! LoginSynacoreViewController
        //  mainViewController.transitioningDelegate = self
        DispatchQueue.main.async() {
          self.delegate = mainViewController
          self.delegate?.userDetailsViewControllerDidRequestLogout(viewController: self)
          
          let nav:UINavigationController = UINavigationController(rootViewController:mainViewController)
          appDelegate.window?.rootViewController = nav
        }
      default:
        print("No action on \(indexPath.section) section and \(indexPath.row) row")
      }
    default:
       print("No action on \(indexPath.section) section and \(indexPath.row) row")
    }
  }
}
extension AccountViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
  {
    let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
    profilePicture = chosenImage //4
    tableView.reloadSections(IndexSet(integer: 0), with: .none)
    dismiss(animated:true, completion: nil) //5
    
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     dismiss(animated: true, completion: nil)
  }
}
extension AccountViewController:EditProfilePicture{
  func openActiveSheetChooseProfilePicture(){
    let actionSheetController: UIAlertController = UIAlertController(title: "Profile Picture", message: "Select option to edit profile", preferredStyle: .actionSheet)
    
    //Create and add the Cancel action
    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
      //Just dismiss the action sheet
    }
    actionSheetController.addAction(cancelAction)
    //Create and add first option action
    let takePictureAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in
      //Code for launching the camera goes here
      self.clickImageFromCamera()
    }
    actionSheetController.addAction(takePictureAction)
    //Create and add a second option action
    let choosePictureAction: UIAlertAction = UIAlertAction(title: "Gallery", style: .default) { action -> Void in
      //Code for picking from Gallery  goes here
      self.selectImagefromGallery()
    }
    actionSheetController.addAction(choosePictureAction)
    //Present the AlertController
    self.present(actionSheetController, animated: true, completion: nil)
  }
  func selectImagefromGallery(){
    picker.allowsEditing = false
    picker.sourceType = .photoLibrary
    picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
    present(picker, animated: true, completion: nil)
  }
  func clickImageFromCamera(){
    picker.allowsEditing = false
    picker.sourceType = UIImagePickerControllerSourceType.camera
    picker.cameraCaptureMode = .photo
    picker.modalPresentationStyle = .fullScreen
    present(picker,animated: true,completion: nil)
  }
  
  
}
