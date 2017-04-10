//
//  VerifyEmailAddressViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 13/10/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit
import SwiftyJSON

class VerifyEmailAddressViewController: BaseViewController,UITextFieldDelegate {
  var languageCode:String!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var contentView: UIView!
  
  @IBOutlet var lblPageTitle: UILabel!
  @IBOutlet var txfldEnterVarificationCode : UITextField!
  @IBOutlet var lblAboutVarificationInfo: UILabel!
  @IBOutlet weak var btnSendEmailAgain: UIButton!
  @IBOutlet weak var btnChangeEmailAddress: UIButton!
  // Toolbar variable declaration
  var toolBar:UIToolbar!
  var submitButton:UIButton!
  var mainStoryboard = "Main"
  // login signUp flag
  var login:Bool!
  // data object
  var createUserObject :CreateUser?

  @IBOutlet var tappedGusture: UITapGestureRecognizer!
  //MARK:- controller lyfecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewProperty()
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = false
    viewUpdateContentOnBasesOfLanguage()
    addNotificationObserver()
    if HotwireCommunicationApi.sharedInstance.createUserObject != nil{
    createUserObject = HotwireCommunicationApi.sharedInstance.createUserObject
    self.webServiceCallingToSendVarificationCode(email: String(self.createUserObject!.email!))
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  //MARK:- Refresh view
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    self.navigationItem.title =  "Verification".localized(lang: languageCode, comment: "")
    
    lblPageTitle.text = "VerifyYourEmailAddressTitle".localized(lang: languageCode, comment: "")
    btnSendEmailAgain.setTitle("SendEmailAgain".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btnChangeEmailAddress.setTitle("ChangeEmailAddress".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    txfldEnterVarificationCode.placeholder = "EnterVerificationCode".localized(lang: languageCode, comment: "")
    lblAboutVarificationInfo.text = "EnterVerificationCodeMailInfo".localized(lang: languageCode, comment: "")
    toolBar = addDoneButton(selector: #selector(VerifyEmailAddressViewController.submitButtonAction(_:)
      ))
    txfldEnterVarificationCode.inputAccessoryView = toolBar
  }
  func configureViewProperty(){
    self.navigationItem.setHidesBackButton(true, animated:true);
    txfldEnterVarificationCode.layer.cornerRadius = 4.0
    txfldEnterVarificationCode.leftViewMode = UITextFieldViewMode.always
    txfldEnterVarificationCode.layer.masksToBounds = true
    txfldEnterVarificationCode.layer.borderColor = kColor_SignUpbutton.cgColor
    txfldEnterVarificationCode.layer.borderWidth = 1.0
    txfldEnterVarificationCode.returnKeyType = .next
    txfldEnterVarificationCode.enablesReturnKeyAutomatically = true
    txfldEnterVarificationCode.autocorrectionType = UITextAutocorrectionType.no
  //  changeDoneButtonColorWhenKeyboardShows(self)
    btnSendEmailAgain.layer.borderColor = kColor_SignUpbutton.cgColor
    btnSendEmailAgain.setTitleColor(kColor_SignUpbutton, for: UIControlState.normal)
    btnChangeEmailAddress.layer.borderColor = kColor_SignUpbutton.cgColor
    btnChangeEmailAddress.setTitleColor(kColor_SignUpbutton, for: UIControlState.normal)
    
  }
  /***********************************************************************************************************
   <Name> addDoneButton </Name>
   <Input Type>  Selector  </Input Type>
   <Return> UIToolbar </Return>
   <Purpose> method to set the toolbar on keyboard </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  13/10/16. </Date>
   </History>
   ***********************************************************************************************************/
  func addDoneButton(selector:Selector) -> UIToolbar {
    let toolbar = UIToolbar()
    let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    submitButton = UIButton()
    submitButton.frame = KFrame_Toolbar
    submitButton.setTitle("SubmitBtnTitle".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    submitButton.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
    submitButton.setTitleColor(UIColor.white, for: UIControlState.selected)
    submitButton.addTarget(self, action: selector, for: .touchUpInside)
    submitButton.titleLabel!.font = kFontStyleSemiBold20
    
    let toolbarButton = UIBarButtonItem()
    toolbarButton.customView = submitButton
    toolbar.setItems([flexButton, toolbarButton], animated: true)
    toolbar.barTintColor = kColor_ToolBarUnselected
    toolbar.sizeToFit()
    return toolbar
  }

  //MARK: textField delegate method
   func textFieldDidBeginEditing(_ textField: UITextField) {
    
  }
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text else {
      return true
    }
    let newLength = text.utf16.count + string.utf16.count - range.length
    if newLength < 6{
      toolBar.barTintColor = kColor_ToolBarUnselected
      submitButton.isSelected = false
      
    }else{
      toolBar.barTintColor = kColor_continueSelected
      submitButton.isSelected = true
    }
    return newLength <= 6
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == txfldEnterVarificationCode{
      if txfldEnterVarificationCode.text != ""{
        self.view.endEditing(true)
      }
    }
    return true
  }

  //MARK:- IB button action
  @IBAction func sendEmailAgainButtonTappedAction(_ sender: AnyObject) {
    let alertTitle = "EmailSentTitle".localized(lang: languageCode, comment: "")
    let alertbody = "EmailSentBody".localized(lang: languageCode, comment: "")
    showTheAlertViewWith(title: alertTitle, withMessage: alertbody, languageCode: languageCode)
    
  }
  @IBAction func changeEmailAddressButtonTappedAction(_ sender: AnyObject) {
    
    let popUpView = self.storyboard?.instantiateViewController(withIdentifier: kStoryBoardID_EmailVarification) as! SignUpEnterEmailViewController
    popUpView.flowType = FlowType.SignUpPopup
    let navController = UINavigationController.init(rootViewController: popUpView)
    self.navigationController?.present(navController, animated: true, completion: nil)
    
  }
 
  @IBAction func touchUpActionOnScrollview(_ sender: AnyObject){
    self.contentView.endEditing(true)
    if txfldEnterVarificationCode.text != ""{
      self.view.endEditing(true)
    }
  }
  func submitButtonAction(_ sender: AnyObject) {
      self.view.endEditing(true)
     if HotwireCommunicationApi.sharedInstance.createUserObject != nil{
    webServiceCallingToAuthenticateVarificationCode(otpCode: txfldEnterVarificationCode.text!, verifyEmailwith: self.createUserObject!.email! )
     }else{
      let alertTitle = "CodeConfirmedTitle".localized(lang: languageCode, comment: "")
      let alertbody = "CodeConfirmedEmailBody".localized(lang: languageCode, comment: "")
      let alert = UIAlertController(title: alertTitle, message: alertbody, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok".localized(lang: languageCode, comment: "Call us Now"), style: .default , handler:{ (UIAlertAction)in
         let mainStoryboard = "Main"
         self.loadTabBarControllerPageSelectedByUserOnParticuralIndex(storyBoard: mainStoryboard, withStoryboardIdentifier: "TabBarController", onSelectedIndex: 0)
       // self.performSegue(withIdentifier: kSegue_TabBarBaseView, sender: self)
      }))
      self.present(alert, animated: true, completion: {
        print("completion block")
      })
    }
      // self.performSegueWithIdentifier(kSegue_EnterEmailId, sender: self)
  }
  
  func  loadTabBarControllerPageSelectedByUserOnParticuralIndex(storyBoard:String, withStoryboardIdentifier identifier:String, onSelectedIndex index:Int){
    let storyboard = UIStoryboard(name: storyBoard, bundle: nil)
    let appDelegate = UIApplication.shared.delegate! as! AppDelegate
    let initialViewController = storyboard.instantiateViewController(withIdentifier: identifier) as! TabBarViewController
    initialViewController.selectedIndex = index
    appDelegate.window?.rootViewController = initialViewController
    appDelegate.window?.makeKeyAndVisible()
  }
  // MARK: - web service
  //to send varification code on phone number
  /***********************************************************************************************************
   <Name> webServiceCallingToSendVarificationCode </Name>
   <Input Type> Url , and premeters </Input Type>
   <Return> void </Return>
   <Purpose> method to call a almofire web service method from alamofire connection class  </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  06/12/16 </Date>
   </History>
   ***********************************************************************************************************/
  func webServiceCallingToSendVarificationCode(email:String){
    let finalUrlToHit = "\(kBaseUrl)\(kVerify_Phone_Number)\(email)"
    //\(Format.json.rawValue)"
    AlamoFireConnectivity.alamofireGetRequest(urlString: finalUrlToHit) { (data, error) in
      if data != nil{
        self.methodToHandelSendVarificationCodeSuccess(data: data!)
      }else{
        self.methodToHandelSendVarificationCodefailure(error: error!)
      }
    }
  }
  func methodToHandelSendVarificationCodeSuccess(data:JSON) {
    //print(data)
    let status = data["Success"].stringValue
    if(status.lowercased() == "true"){
      let message = data["Message"].string
      self.showTheAlertViewWith(title: "Alert".localized(lang: languageCode, comment: ""), withMessage:message!, languageCode: languageCode)
    }else{
      self.showTheAlertViewWith(title: "Alert".localized(lang: languageCode, comment: ""), withMessage:data["Message"].stringValue, languageCode: languageCode)
    }
  }
  func methodToHandelSendVarificationCodefailure(error:NSError?){
    if error != nil{
      if error?.code != 123{
        self.showTheAlertViewWith(title: "Alert".localized(lang: languageCode, comment: ""), withMessage:error!.description, languageCode: languageCode)
      }else{
        self.showTheAlertViewWith(title: (error?.localizedDescription)!, withMessage:(error?.localizedFailureReason)!, languageCode: languageCode)
      }
      
    }
  }
  //to send Authanticate otp
  /***********************************************************************************************************
   <Name> webServiceCallingToAuthenticateVarificationCode </Name>
   <Input Type> Url , and premeters </Input Type>
   <Return> void </Return>
   <Purpose> method to call a almofire web service method from alamofire connection class  </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  06/12/16 </Date>
   </History>
   ***********************************************************************************************************/
  func webServiceCallingToAuthenticateVarificationCode(otpCode:String, verifyEmailwith email:String){
    let finalUrlToHit = "\(kBaseUrl)\(kVerify_Email_Otp)\(email)/code/\(otpCode)"
    //\(Format.json.rawValue)"
    AlamoFireConnectivity.alamofireGetRequest(urlString: finalUrlToHit) { (data, error) in
      if data != nil{
        self.methodToHandelAuthenticateVarificationCodeSuccess(data: data!)
      }else{
        self.methodToHandelAuthenticateVarificationCodefailure(error: error!)
      }
    }
  }
  func methodToHandelAuthenticateVarificationCodeSuccess(data:JSON) {
    //print(data)
    let status = data["Success"].stringValue
    if(status.lowercased() == "true"){
      let alertTitle = "CodeConfirmedTitle".localized(lang: languageCode, comment: "")
      let alertbody = "CodeConfirmedEmailBody".localized(lang: languageCode, comment: "")
      let alert = UIAlertController(title: alertTitle, message: alertbody, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok".localized(lang: languageCode, comment: "Call us Now"), style: .default , handler:{ (UIAlertAction)in
        self.performSegue(withIdentifier: kSegue_TabBarBaseView, sender: self)
      }))
      self.present(alert, animated: true, completion: {
        print("completion block")
      })
    }else{
      self.showTheAlertViewWith(title: "Alert".localized(lang: languageCode, comment: ""), withMessage:data["Message"].stringValue, languageCode: languageCode)
    }
  }
  func methodToHandelAuthenticateVarificationCodefailure(error:NSError?){
    if error != nil{
      if error?.code != 123{
        self.showTheAlertViewWith(title: "Alert".localized(lang: languageCode, comment: ""), withMessage:error!.description, languageCode: languageCode)
      }else{
        self.showTheAlertViewWith(title: (error?.localizedDescription)!, withMessage:(error?.localizedFailureReason)!, languageCode: languageCode)
      }
      
    }
  }
  // MARK: - Navigation
  /***********************************************************************************************************
   <Name> prepareForSegue </Name>
   <Input Type> UIStoryboardSegue,AnyObject </Input Type>
   <Return> void </Return>
   <Purpose> method call when segue called  </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  13/10/16 </Date>
   </History>
   ***********************************************************************************************************/
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    self.title = "Back"
    if segue.identifier == kSegue_TabBarBaseView,
      let destinationViewController = segue.destination as? TabBarBaseViewController {
      destinationViewController.transitioningDelegate = self
      swipeInteractionController.wireToViewController(viewController: destinationViewController)
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
   <Date>   13/10/16 </Date>
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
