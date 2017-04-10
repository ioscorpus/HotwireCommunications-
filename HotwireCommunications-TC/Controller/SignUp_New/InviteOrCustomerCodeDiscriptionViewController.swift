//
//  InviteOrCustomerCodeDiscriptionViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 05/10/16.
//  Copyright © 2016 chetu. All rights reserved.
//

import UIKit

class InviteOrCustomerCodeDiscriptionViewController: BaseViewController {
   var languageCode:String!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var contentView: UIView!
  @IBOutlet var lblPageTitle: UILabel!
  // signUpSelection type
  @IBOutlet var lblCustomerNoInfo: UILabel!
  @IBOutlet var imgViewCustomerNo: UIImageView!
  @IBOutlet var btnCalToHelpLine: UIButton!
  var customerNoSelection:Bool!
  //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  05/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    let fontFamily = UIFont.fontNamesForFamilyName("SF UI Display")
//    print(fontFamily)
//    let fontFamily2 = UIFont.fontNamesForFamilyName("SF UI Text")
//    var languageCode:String!
  
   
  }
  override func viewWillAppear(_ animated: Bool) {
    viewUpdateContentOnBasesOfLanguage()
    addNotificationObserver()
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
  //MARK:- IBoutlet action method
  /***********************************************************************************************************
   <Name> callToHelpLineIfNotGettingBill </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to action on call helpline number</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  05/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func callToHelpLineIfNotGettingBill(_ sender: AnyObject) {
    var activeSheetTitle:String!
    var activeSheetBody:String!
    if customerNoSelection as Bool{
      activeSheetTitle = "CustomerNumber".localized(lang: languageCode, comment: "")
      activeSheetBody = "activitySheetbodyCustomerNumber".localized(lang: languageCode, comment: "")
    }else{
      activeSheetTitle = "InvitationCode".localized(lang: languageCode, comment: "")
      activeSheetBody = "activitySheetboodyInviteCode".localized(lang: languageCode, comment: "")
    }
    
    let alert = UIAlertController(title: activeSheetTitle, message: activeSheetBody , preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "CallUsNow".localized(lang: languageCode, comment: "Call us Now"), style: .default , handler:{ (UIAlertAction)in
      if let url = NSURL(string: "tel://\(khelpLineNumber)") {
        UIApplication.shared.openURL(url as URL)
      }
    }))
    
    alert.addAction(UIAlertAction(title: "Cancel".localized(lang: languageCode, comment: "cancel button"), style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
      print("User click Dismiss button")
    }))
    self.present(alert, animated: true, completion: {
      print("completion block")
    })
    
  }
  
  //MARK:- Refresh view
  /***********************************************************************************************************
   <Name> viewUpdateContentOnBasesOfLanguage </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to update content on the bases of language</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  05/10/16 </Date>
   </History>
   ***********************************************************************************************************/

  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    self.title =  "Help".localized(lang: languageCode, comment: "")
    
   
    if customerNoSelection as Bool{
      lblPageTitle.text = "CustomerNumber".localized(lang: languageCode, comment: "")
      lblCustomerNoInfo.text = "Where_FoundCoustomerNumber".localized(lang: languageCode, comment: "")
      btnCalToHelpLine.setTitle("helpLineForCoustomerNo".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
      imgViewCustomerNo.image = UIImage(named:"Billing_Statement")
    }else{
       lblPageTitle.text = "InstallationCode".localized(lang: languageCode, comment: "")
      lblCustomerNoInfo.text = "WhereToFoundInviteCode".localized(lang: languageCode, comment: "")
      btnCalToHelpLine.setTitle("InviteCodeHelpLine".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
      imgViewCustomerNo.image = UIImage(named:"Invitation_Letter")
    }
    
   addBarButtonOnNavigationBar()
  }
  /***********************************************************************************************************
   <Name> addBarButtonOnNavigationBar </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to add Done button to dismiss view </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  05/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  func addBarButtonOnNavigationBar(){
    let btn1 = UIButton(frame:KFrame_CancelBarbutton )
    btn1.setTitle("Done", for: UIControlState.normal)
    btn1.addTarget(self, action: #selector(InviteOrCustomerCodeDiscriptionViewController.DoneButtonTappedAction(_:)), for: .touchUpInside)
    self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: btn1), animated: true);
    
  }
  /***********************************************************************************************************
   <Name> DoneButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose>action method click on done button </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  05/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  func DoneButtonTappedAction(_ sender : UIButton){
    self.dismiss(animated: true, completion: {});
  }
  //MARK:- ADD notification
  /***********************************************************************************************************
   <Name> addNotificationObserver </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call when aplication come to foreground and update selected languge </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  05/10/16 </Date>
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
