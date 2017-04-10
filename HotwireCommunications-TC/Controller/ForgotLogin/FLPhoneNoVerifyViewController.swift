//
//  FLPhoneNoVerifyViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 11/11/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit
import SwiftyJSON

class FLPhoneNoVerifyViewController: BaseViewController,UITextFieldDelegate {
  var languageCode:String!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var contentView: UIView!
  
  @IBOutlet var lblPageTitle: UILabel!
  @IBOutlet var txfldEnterVarificationCode : UITextField!
  @IBOutlet var lblAboutVarificationInfo: UILabel!
  @IBOutlet weak var btnSendCodeAgain: UIButton!
  @IBOutlet weak var btnCallMeInstead: UIButton!
  // Data values comming from previous Controller
  var phoneNumber:String!
  var flowType:FlowType!
  // Toolbar variable declaration
  var toolBar:UIToolbar!
  var submitButton:UIButton!
  //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 11/11/16. </Date>
   </History>
   ***********************************************************************************************************/
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewProperty()
    // Do any additional setup after loading the view.
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
   <Date>  11/11/16. </Date>
   </History>
   ***********************************************************************************************************/
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    self.navigationItem.title =  "ResetPassword".localized(lang: languageCode, comment: "")
    
    lblPageTitle.text = "ForgotLoginMobileHeaderText".localized(lang: languageCode, comment: "")
    btnSendCodeAgain.setTitle("SendCodeAgainBtnTitle".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btnCallMeInstead.setTitle("CallmeInsteadBtnTitle".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    txfldEnterVarificationCode.placeholder = "EnterVerificationCode".localized(lang: languageCode, comment: "")
    lblAboutVarificationInfo.text = "ForgotLoginMobileInfoText".localized(lang: languageCode, comment: "")
    toolBar = addDoneButton( selector: #selector(VerifyPhoneNoViewController.submitButtonAction(_:)))
    txfldEnterVarificationCode.inputAccessoryView = toolBar
    setUpCancelButonOnRightWithAnimation()
    setUpBackButonOnLeft()
  }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 11/11/16.</Date>
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
    btnCallMeInstead.layer.borderColor = kColor_SignUpbutton.cgColor
    btnCallMeInstead.setTitleColor(kColor_SignUpbutton, for: UIControlState.normal)
    setUpCancelButonOnRightWithAnimation()
   
  }
  /***********************************************************************************************************
   <Name> addDoneButton </Name>
   <Input Type>  Selector  </Input Type>
   <Return> UIToolbar </Return>
   <Purpose> method to set the toolbar on keyboard </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  11/11/16. </Date>
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
  /***********************************************************************************************************
   <Name> setUpBackButonOnLeft </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to set the custom back button </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  11/11/16. </Date>
   </History>
   ***********************************************************************************************************/
  
  func setUpBackButonOnLeft(){
    self.navigationItem.setHidesBackButton(true, animated:true);
    let btn1 = UIButton(frame:KFrame_CancelBarbutton )
    btn1.setTitle("Back".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btn1.imageEdgeInsets = imageEdgeInsets;
    btn1.titleEdgeInsets = titleEdgeInsets;
    btn1.setImage(UIImage(named: "RedBackBtn"), for: UIControlState.normal)
    btn1.addTarget(self, action: #selector(FLPhoneNoVerifyViewController.backButtonTappedAction(_:)), for: .touchUpInside)
    self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: btn1), animated: true);
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
   <Date>  11/11/16. </Date>
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
   <Date>  11/11/16. </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func callMeInsteadButtonTappedAction(_ sender: AnyObject) {
//    let popUpView = self.storyboard?.instantiateViewControllerWithIdentifier(kStoryBoardID_ConfirmPhoneNumber) as! ConfirmPhoneNumberViewController
//    let navController = UINavigationController.init(rootViewController: popUpView)
//    self.navigationController?.presentViewController(navController, animated: true, completion: nil)
    
  }
  @IBAction func sendCodeAgainButtonTappedAction(_ sender: AnyObject) {
    let alertTitle = "CodeResentTitle".localized(lang: languageCode, comment: "")
    let alertbody = "CodeResentBody".localized(lang: languageCode, comment: "")
    let alert = UIAlertController(title: alertTitle, message: alertbody, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok".localized(lang: languageCode, comment: "Call us Now"), style: .default , handler:{ (UIAlertAction)in
      //self.performSegueWithIdentifier(kSegue_VarificationEmailAddress, sender: self)
    }))
    self.present(alert, animated: true, completion: {
      print("completion block")
    })
    
  }
  /***********************************************************************************************************
   <Name> backButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on custom back  button tapped </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  11/11/16. </Date>
   </History>
   ***********************************************************************************************************/
  func backButtonTappedAction(_ sender : UIButton){
    self.navigationController!.popViewController(animated: true)
  }
  /***********************************************************************************************************
   <Name> touchUpActionOnScrollview </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on Scroll view to handle end editing</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  11/11/16. </Date>
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
   <Date> 11/11/16. </Date>
   </History>
   ***********************************************************************************************************/
  func submitButtonAction(_ sender: AnyObject) {
    if submitButton.isSelected{
    let dictionary :[String:AnyObject] = ["otp":txfldEnterVarificationCode.text as AnyObject,"phone":phoneNumber as AnyObject]
    webServiceCallingToSubmitOtp(prameter: dictionary, withUrlType:kVerify_phone_by_otp )
    }
  }
  
  
  //MARK: web service to send Otp with mobile number
  /***********************************************************************************************************
   <Name> webServiceCallingToSubmitOtp </Name>
   <Input Type> Url , and premeters </Input Type>
   <Return> void </Return>
   <Purpose> method to call a almofire web service method from alamofire connection class to request post web service to send otp with phone number </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  18/01/17 </Date>
   </History>
   ***********************************************************************************************************/
  func webServiceCallingToSubmitOtp(prameter:[String :AnyObject], withUrlType endPointUrl:String){
    let finalUrlToHit = "\(kBaseUrl)\(UrlEndPoints.Login.rawValue)\(endPointUrl)"
    AlamoFireConnectivity.alamofirePostRequest(param: prameter, withUrlString: finalUrlToHit) { (data, error) in
      if data != nil{
        self.methodToHandelSubmitOtpSuccess(data: data!)
      }else{
        self.methodToHandelSubmitOtpfailure(error: error!)
      }
      
    }
  }
  func methodToHandelSubmitOtpSuccess(data:JSON) {
    //print(data)
    let status = data["Success"].stringValue
    if(status.lowercased() == "true"){
      print("sucess")
       self.performSegue(withIdentifier: kSegue_EnterPassword, sender: self)
    }else{
      let errorcode = data["ErrorCode"].intValue
      switch errorcode {
      case ErrorCode.AlreadyUseCredential.rawValue:
        self.showTheAlertViewWithLoginButton(title: "Alert".localized(lang: languageCode, comment: ""), withMessage: data["Message"].stringValue, languageCode: languageCode)
      default:
        self.showTheAlertViewWith(title: "Alert".localized(lang: languageCode, comment: ""), withMessage:data["Message"].stringValue, languageCode: languageCode)
      }
    }
  }
  func methodToHandelSubmitOtpfailure(error:NSError?){
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
   <Date>  11/11/16. </Date>
   </History>
   ***********************************************************************************************************/
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    self.title = ""
    if segue.identifier == kSegue_EnterPassword{
      if let nextViewController = segue.destination as? SignUpPasswordViewController {
        nextViewController.flowType = FlowType.ResetPassword
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
   <Date> 11/11/16. </Date>
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
