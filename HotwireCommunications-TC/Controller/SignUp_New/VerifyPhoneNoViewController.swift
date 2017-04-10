//
//  VerifyPhoneNoViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 13/10/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit
import SwiftyJSON

class VerifyPhoneNoViewController:BaseViewController,UITextFieldDelegate {
  var languageCode:String!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var contentView: UIView!
  
  @IBOutlet var lblPageTitle: UILabel!
  @IBOutlet var txfldEnterVarificationCode : UITextField!
  @IBOutlet var lblAboutVarificationInfo: UILabel!
  @IBOutlet weak var btnSendCodeAgain: UIButton!
  @IBOutlet weak var btnChangeMobileNumber: UIButton!
  @IBOutlet weak var btnCallMeInstead: UIButton!
  var viewTitleKey:String!
  // Toolbar variable declaration
  var toolBar:UIToolbar!
  var submitButton:UIButton!
  // login signUp flag
   var login:Bool!
  // data object 
  var createUserObject :CreateUser?
  
  //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 13/10/16. </Date>
   </History>
   ***********************************************************************************************************/
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewProperty()
    // Do any additional setup after loading the view.
    if HotwireCommunicationApi.sharedInstance.createUserObject != nil{
      createUserObject = HotwireCommunicationApi.sharedInstance.createUserObject
      self.webServiceCallingToSendVarificationCode(urlType: String(self.createUserObject!.phone!))
    }
  }
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = false
    viewUpdateContentOnBasesOfLanguage()
    addNotificationObserver()
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
   <Date>  13/10/16. </Date>
   </History>
   ***********************************************************************************************************/
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    self.navigationItem.title =  "Verification".localized(lang: languageCode, comment: "")
    
    lblPageTitle.text = "VerifyYourPhoneNumberTitle".localized(lang: languageCode, comment: "")
    btnSendCodeAgain.setTitle("SendCodeAgainBtnTitle".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btnChangeMobileNumber.setTitle("ChangeMobileNumberBtnTitle".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btnCallMeInstead.setTitle("CallmeInsteadBtnTitle".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    txfldEnterVarificationCode.placeholder = "EnterVerificationCode".localized(lang: languageCode, comment: "")
    if !login{
    let aboutVarificationInfo = "\("EnterVerificationCodeInfo".localized(lang: languageCode, comment: "")) \(String(self.createUserObject!.phone!)) "
    lblAboutVarificationInfo.text = aboutVarificationInfo
    }else{
    lblAboutVarificationInfo.text = "\("EnterVerificationCodeInfo".localized(lang: languageCode, comment: ""))"
    }
    toolBar = addDoneButton( selector: #selector(VerifyPhoneNoViewController.submitButtonAction(_:)))
    txfldEnterVarificationCode.inputAccessoryView = toolBar
  }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 13/10/16.</Date>
   </History>
   ***********************************************************************************************************/
  func configureViewProperty(){
   self.navigationItem.setHidesBackButton(true, animated:true);
    txfldEnterVarificationCode.layer.cornerRadius = 4.0
    txfldEnterVarificationCode.leftViewMode = UITextFieldViewMode.always
    txfldEnterVarificationCode.layer.masksToBounds = true
    txfldEnterVarificationCode.layer.borderColor = kColor_SignUpbutton.cgColor
    txfldEnterVarificationCode.layer.borderWidth = 1.0
    txfldEnterVarificationCode.returnKeyType = .next
    txfldEnterVarificationCode.enablesReturnKeyAutomatically = true
    btnSendCodeAgain.layer.borderColor = kColor_SignUpbutton.cgColor
    btnSendCodeAgain.setTitleColor(kColor_SignUpbutton, for: UIControlState.normal)
    btnChangeMobileNumber.layer.borderColor = kColor_SignUpbutton.cgColor
    btnCallMeInstead.layer.borderColor = kColor_SignUpbutton.cgColor
    btnChangeMobileNumber.setTitleColor(kColor_SignUpbutton, for: UIControlState.normal)
    btnCallMeInstead.setTitleColor(kColor_SignUpbutton, for: UIControlState.normal)
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
  //(VerifyPhoneNoViewController.submitButtonAction(_:)))
   //MARK: textField delegate method
  /***********************************************************************************************************
   <Name> textFieldShouldEndEditing, textFieldShouldClear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Textfield delegate methods to handel texfield status action</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  13/10/16. </Date>
   </History>
   ***********************************************************************************************************/
  

  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    print("textFieldShouldEndEditing")
    return true
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
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    toolBar.barTintColor = kColor_ToolBarUnselected
    return true
  }
  //MARK:- IB button action
  /***********************************************************************************************************
   <Name> continueButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on continue button</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  13/10/16. </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func callMeInsteadButtonTappedAction(_ sender: AnyObject) {
    let popUpView = self.storyboard?.instantiateViewController(withIdentifier: kStoryBoardID_ConfirmPhoneNumber) as! ConfirmPhoneNumberViewController
    let navController = UINavigationController.init(rootViewController: popUpView)
    self.navigationController?.present(navController, animated: true, completion: nil)
    
  }
  @IBAction func changeMobileNumberButtonTappedAction(_ sender: AnyObject) {
    let popUpView = self.storyboard?.instantiateViewController(withIdentifier: kStoryBoardID_PhoneNoVarification) as! SignUpEnterMobNoViewController
   // popUpView.varificationMode = true
    popUpView.flowType = FlowType.SignUpPopup
    let navController = UINavigationController.init(rootViewController: popUpView)
    self.navigationController?.present(navController, animated: true, completion: nil)
    
  }
  @IBAction func sendCodeAgainButtonTappedAction(_ sender: AnyObject) {
    let alertTitle = "CodeResentTitle".localized(lang: languageCode, comment: "")
    let alertbody = "CodeResentBody".localized(lang: languageCode, comment: "")
    let alert = UIAlertController(title: alertTitle, message: alertbody, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok".localized(lang: languageCode, comment: "Call us Now"), style: .default , handler:{ (UIAlertAction)in
      //self.performSegueWithIdentifier(kSegue_VarificationEmailAddress, sender: self)
        self.webServiceCallingToSendVarificationCode(urlType: (self.createUserObject?.email)!)
    }))
    self.present(alert, animated: true, completion: {
      print("completion block")
    })
  
  }
  /***********************************************************************************************************
   <Name> touchUpActionOnScrollview </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on Scroll view to handle end editing</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  13/10/16. </Date>
   </History>
   ***********************************************************************************************************/

  @IBAction func touchUpActionOnScrollview(_ sender: AnyObject){
    self.contentView.endEditing(true)
    if txfldEnterVarificationCode.text != ""{
      self.view.endEditing(true)
    }
  }
  /***********************************************************************************************************
   <Name> submitButtonAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on submit button on tool bar tapped action</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 13/10/16. </Date>
   </History>
   ***********************************************************************************************************/
  func submitButtonAction(_ sender: AnyObject) {
    self.view.endEditing(true)
     if HotwireCommunicationApi.sharedInstance.createUserObject != nil{
     self.webServiceCallingToAuthenticateVarificationCode( otpCode: self.txfldEnterVarificationCode.text!, verifyPhoneNumberwith:String(self.createUserObject!.phone!) )
     }else{
      let alertTitle = "CodeConfirmedTitle".localized(lang: languageCode, comment: "")
      let alertbody = "CodeConfirmedMobileNumberBody".localized(lang: languageCode, comment: "")
      let alert = UIAlertController(title: alertTitle, message: alertbody, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok".localized(lang: languageCode, comment: "Call us Now"), style: .default , handler:{ (UIAlertAction)in
        if self.login as Bool{
          self.performSegue(withIdentifier: kSegue_SetUpEmail, sender: self)
        }else{
          self.performSegue(withIdentifier: kSegue_VarificationEmailAddress, sender: self)
        }
      }))
      self.present(alert, animated: true, completion: {
        print("completion block")
      })
    }
    
   // self.performSegueWithIdentifier(kSegue_EnterEmailId, sender: self)
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
  func webServiceCallingToSendVarificationCode(urlType:String){
    let finalUrlToHit = "\(kBaseUrl)\(kVerify_Phone_Number)\(urlType)"
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
     self.showTheAlertViewWith(title: "Alert Title", withMessage:message!, languageCode: languageCode)
    }else{
      self.showTheAlertViewWith(title: "Alert Title", withMessage:data["Message"].stringValue, languageCode: languageCode)
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
   func webServiceCallingToAuthenticateVarificationCode(otpCode:String, verifyPhoneNumberwith phoneNumber:String){
    let finalUrlToHit = "\(kBaseUrl)\(kVerify_Phone_Otp)\(phoneNumber)/code/\(otpCode)"
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
      let alertbody = "CodeConfirmedMobileNumberBody".localized(lang: languageCode, comment: "")
      let alert = UIAlertController(title: alertTitle, message: alertbody, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok".localized(lang: languageCode, comment: "Call us Now"), style: .default , handler:{ (UIAlertAction)in
        if self.login as Bool{
          self.performSegue(withIdentifier: kSegue_SetUpEmail, sender: self)
        }else{
          self.performSegue(withIdentifier: kSegue_VarificationEmailAddress, sender: self)
        }
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
   <Date>  13/10/16. </Date>
   </History>
   ***********************************************************************************************************/

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    self.title = "Back"
    if segue.identifier == kSegue_VarificationEmailAddress{
      if let nextViewController = segue.destination as? VerifyEmailAddressViewController {
        nextViewController.login = login
      }
    }else if segue.identifier == kSegue_SetUpEmail{
      if let nextViewController = segue.destination as? LoginEmailVerificationViewController {
        nextViewController.login = login
      }}
  }
  //MARK:- ADD notification
  /***********************************************************************************************************
   <Name> addNotificationObserver </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call when aplication come to foreground and update selected languge </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 13/10/16. </Date>
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
