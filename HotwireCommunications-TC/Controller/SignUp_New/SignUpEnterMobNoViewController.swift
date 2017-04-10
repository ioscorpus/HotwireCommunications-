//
//  SignUpEnterMobNoViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 30/08/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpEnterMobNoViewController: BaseViewController,UITextFieldDelegate {
    var languageCode:String!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var lblPageTitle: UILabel!
    @IBOutlet var txfldEnterYourMobileNumber : UITextField!
    @IBOutlet var lblAboutNameInfo: UILabel!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnAlreadyHaveAccount: UIButton!
    @IBOutlet var tappedGesture: UITapGestureRecognizer!
    @IBOutlet weak var btnNotHaveTextEnable: UIButton!
    @IBOutlet var lblBottomSeperater: UILabel!
    var flowType:FlowType = FlowType.SignUp
   // var varificationMode:Bool = false
  // Toolbar variable declaration
  var toolBar:UIToolbar!
  var continueButton:UIButton!
  
  // data objects
  var userDetails:AnyObject?
  var signUpdetailsObject:SignUpDetails!
  //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 30/08/16 </Date>
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
  override func viewDidAppear(_ animated: Bool) {
    if !btnContinue.isSelected{
      txfldEnterYourMobileNumber.becomeFirstResponder()
    }
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
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
 
    func viewUpdateContentOnBasesOfLanguage(){
        languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
      
      switch  flowType{
      case .SignUp:
         self.navigationItem.title =  "SignUp".localized(lang: languageCode, comment: "")
         lblPageTitle.text = "WhatIsYourMobNo".localized(lang: languageCode, comment: "")
         btnAlreadyHaveAccount.setTitle("AlreadyHaveAccount".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
         btnContinue.setTitle("Continue".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
         txfldEnterYourMobileNumber.placeholder = "EnterYourMobileNumber".localized(lang: languageCode, comment: "")
         lblAboutNameInfo.text = "MobileNumberInfoText".localized(lang: languageCode, comment: "")
         btnNotHaveTextEnable.setTitle( "DoNotHaveTextEnablePhone".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
         tappedGesture.isEnabled = true
         if let invitationCodeObject = userDetails as? InvitationCode {
          // success
           let phoneNumber = invitationCodeObject.phone!
            if phoneNumber > 0 {
           var userPhoneNumber = String(phoneNumber)
            let stringts: NSMutableString =  NSMutableString(string: userPhoneNumber)
            stringts.insert("(", at: 0)
            stringts.insert(")", at: 4)
          //  stringts.insertString("-", atIndex: 5)
            stringts.insert("-", at: 8)
            userPhoneNumber = stringts as String
            self.txfldEnterYourMobileNumber.text = userPhoneNumber
            }
          }else {
          print("failre")
        }
      case .SignUpPopup:
         self.navigationItem.title =  "ChangePhone".localized(lang: languageCode, comment: "")
         lblPageTitle.text = "WhatIsYourMobNo".localized(lang: languageCode, comment: "")
         txfldEnterYourMobileNumber.placeholder = "EnterYourMobileNumber".localized(lang: languageCode, comment: "")
         lblAboutNameInfo.isHidden = true
         btnContinue.isHidden = true
         btnNotHaveTextEnable.isHidden = true
         addBarButtonOnNavigationBar()
         tappedGesture.isEnabled = false
      case .ResetPassword:
          self.navigationItem.title =  "ResetPassword".localized(lang: languageCode, comment: "")
          lblPageTitle.text = "WhatIsYourMobNo".localized(lang: languageCode, comment: "")
          txfldEnterYourMobileNumber.placeholder = "EnterYourMobileNumber".localized(lang: languageCode, comment: "")
          lblAboutNameInfo.text = "ForgotLoginInfoText".localized(lang: languageCode, comment: "")
          btnContinue.setTitle("Continue".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
          tappedGesture.isEnabled = true
          btnNotHaveTextEnable.isHidden = true
          btnAlreadyHaveAccount.isHidden = true
          lblBottomSeperater.isHidden = true
          // from base view
          setUpCancelButonOnRightWithAnimation()
        
        
      case .Login:
         self.navigationItem.title =  "AccountSetup".localized(lang: languageCode, comment: "")
          lblPageTitle.text = "VerifyMobileNumber".localized(lang: languageCode, comment: "")
          btnContinue.setTitle("Continue".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
          txfldEnterYourMobileNumber.placeholder = "EnterYourMobileNumber".localized(lang: languageCode, comment: "")
          lblAboutNameInfo.text = "VerifyMobileNumberInfoText".localized(lang: languageCode, comment: "")
          lblBottomSeperater.isHidden = false
          btnAlreadyHaveAccount.isHidden = false
          setUpCancelButonOnRightWithAnimation()
      default:
        self.navigationItem.title =  "RecoverUsername".localized(lang: languageCode, comment: "")
        lblPageTitle.text = "WhatIsYourMobNo".localized(lang: languageCode, comment: "")
        txfldEnterYourMobileNumber.placeholder = "EnterYourMobileNumber".localized(lang: languageCode, comment: "")
        lblAboutNameInfo.text = "ForgotLoginInfoText".localized(lang: languageCode, comment: "")
        btnContinue.setTitle("Continue".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
        tappedGesture.isEnabled = true
        btnNotHaveTextEnable.isHidden = true
        btnAlreadyHaveAccount.isHidden = true
        lblBottomSeperater.isHidden = true
        setUpCancelButonOnRightWithAnimation()
        
        
        
      }
//      if varificationMode {
//        self.navigationItem.title =  "ChangePhone".localized(lang: languageCode, comment: "")
//      }else{
//        self.navigationItem.title =  "SignUp".localized(lang: languageCode, comment: "")
//      }
      
        toolBar = addDoneButton( selector: #selector(SignUpEnterMobNoViewController.toolBarContinueButtonAction(_:)))
        txfldEnterYourMobileNumber.inputAccessoryView = toolBar
        setUpBackButonOnLeft()
    }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  

    func configureViewProperty(){
       // txfldEnterYourMobileNumber.becomeFirstResponder()
        txfldEnterYourMobileNumber.layer.cornerRadius = 4.0
        txfldEnterYourMobileNumber.leftViewMode = UITextFieldViewMode.always
        txfldEnterYourMobileNumber.layer.masksToBounds = true
        txfldEnterYourMobileNumber.layer.borderColor = kColor_SignUpbutton.cgColor
        txfldEnterYourMobileNumber.layer.borderWidth = 1.0
        txfldEnterYourMobileNumber.returnKeyType = .next
        txfldEnterYourMobileNumber.enablesReturnKeyAutomatically = true
        txfldEnterYourMobileNumber.layer.masksToBounds = true
        txfldEnterYourMobileNumber.keyboardType = .numberPad
       txfldEnterYourMobileNumber.updateConstraints()
      let phoneNumberCode = UILabel.init(frame: CGRect.init(
        
        0, 0, 70, txfldEnterYourMobileNumber.bounds.height))
      phoneNumberCode.text = "  US  +1"
      if txfldEnterYourMobileNumber.bounds.height <= 35{
          phoneNumberCode.font = kFontStyleSemiBold18
      }else{
      phoneNumberCode.font = kFontStyleSemiBold18
      }
      phoneNumberCode.textColor = UIColor.black
      txfldEnterYourMobileNumber.leftView = phoneNumberCode
      txfldEnterYourMobileNumber.leftViewMode = .always
      
     // lblAboutNameInfo.isHidden = false
      btnContinue.isHidden = true
    //  btnNotHaveTextEnable.isHidden = false
      btnContinue.backgroundColor = kColor_ContinuteUnselected
      btnContinue.isSelected = false
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
    btn1.addTarget(self, action: #selector(SignUpEnterMobNoViewController.backButtonTappedAction(_:)), for: .touchUpInside)
    self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: btn1), animated: true);
  }
  /***********************************************************************************************************
   <Name> backButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on custom back button to navigate to next view</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  func backButtonTappedAction(_ sender : UIButton){
    self.navigationController!.popViewController(animated: true)
  }
  /***********************************************************************************************************
   <Name> addDoneButton </Name>
   <Input Type>  Selector  </Input Type>
   <Return> UIToolbar </Return>
   <Purpose> method to set the toolbar on keyboard </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  func addDoneButton(selector:Selector) -> UIToolbar {
    let toolbar = UIToolbar()
    let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    continueButton = UIButton()
    continueButton.frame = KFrame_Toolbar
    switch  flowType{
    case .SignUp:
        continueButton.setTitle("Continue".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    case .SignUpPopup:
        continueButton.setTitle("SubmitBtnTitle".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    case .ResetPassword:
        continueButton.setTitle("Continue".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    case .Login:
         continueButton.setTitle("SendCode".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    default:
       continueButton.setTitle("Continue".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    }
//    if varificationMode{
//    continueButton.setTitle("SubmitBtnTitle".localized(lang: languageCode, comment: ""), forState: UIControlState.Normal)
//    }else{
//    continueButton.setTitle("Continue".localized(lang: languageCode, comment: ""), forState: UIControlState.Normal)
//    }
    continueButton.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
    continueButton.setTitleColor(UIColor.white, for: UIControlState.selected)
    continueButton.addTarget(self, action: selector, for: .touchUpInside)
    continueButton.titleLabel!.font = kFontStyleSemiBold20
    
    let toolbarButton = UIBarButtonItem()
    toolbarButton.customView = continueButton
    toolbar.setItems([flexButton, toolbarButton], animated: true)
    toolbar.barTintColor = kColor_ToolBarUnselected
    toolbar.sizeToFit()
    return toolbar
  }
    //MARK: textField delegate method
  
  /***********************************************************************************************************
   <Name> textFieldShouldEndEditing, shouldChangeCharactersInRange ,textFieldDidBeginEditing, textFieldShouldClear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Textfield delegate methods to handel texfield status action</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
 
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
      let components = textField.text!.components(separatedBy: CharacterSet.decimalDigits.inverted)
      //componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
      let decimalString = components.joined(separator: "") as NSString
      let length = decimalString.length
      if flowType == FlowType.SignUp || flowType == FlowType.ResetPassword || flowType == FlowType.RecoverUsername{
        if length != 10{
          toolBar.barTintColor = kColor_ToolBarUnselected
          continueButton.isSelected = false
          btnContinue.backgroundColor = kColor_ContinuteUnselected
          btnContinue.isSelected = false
          btnContinue.isHidden = true
          lblAboutNameInfo.isHidden = false
          if flowType == FlowType.SignUp{
          btnNotHaveTextEnable.isHidden = false
          }
        }else{
          continueButton.isSelected = true
          toolBar.barTintColor = kColor_continueSelected
          btnContinue.backgroundColor = kColor_continueSelected
          btnContinue.isSelected = true
          btnContinue.isHidden = true
          lblAboutNameInfo.isHidden = false
          if flowType == FlowType.SignUp{
          btnNotHaveTextEnable.isHidden = false
          }
        }
      }
    }
  func textFieldDidEndEditing(_ textField: UITextField) {
        lblAboutNameInfo.isHidden = true
        btnContinue.isHidden = false
        btnNotHaveTextEnable.isHidden = true
    }
 func textFieldShouldClear(_ textField: UITextField) -> Bool {
      toolBar.barTintColor = kColor_ToolBarUnselected
    return true
  }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
      let components = textField.text!.components(separatedBy: CharacterSet.decimalDigits.inverted)
      let decimalString = components.joined(separator: "") as NSString
      let length = decimalString.length
      if length == 10{
        self.view.endEditing(true)
        btnContinue.backgroundColor = kColor_continueSelected
        btnContinue.isSelected = true
      }else{
        btnContinue.backgroundColor = kColor_ContinuteUnselected
        btnContinue.isSelected = false
      }
      lblAboutNameInfo.isHidden = true
      btnContinue.isHidden = false
      btnNotHaveTextEnable.isHidden = true
      return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       if textField == txfldEnterYourMobileNumber{
            if txfldEnterYourMobileNumber.text != ""{
                self.view.endEditing(true)
                btnContinue.backgroundColor = kColor_continueSelected
                btnContinue.isSelected = true
            }
        }
        return true
    }
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
  {
  if textField == txfldEnterYourMobileNumber
  {
  let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
  let components = newString.components(separatedBy: CharacterSet.decimalDigits.inverted)
    
    
  let decimalString = components.joined(separator: "") as NSString
  let length = decimalString.length
  let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
  
  if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
  {
  let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
  
  return (newLength > 10) ? false : true
  }
  var index = 0 as Int
  let formattedString = NSMutableString()
  
  if hasLeadingOne
  {
  formattedString.append("1 ")
  index += 1
  }
  if (length - index) > 3
  {
  let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
  formattedString.appendFormat("(%@)", areaCode)
  index += 3
  }
  if length - index > 3
  {
  let prefix = decimalString.substring(with: NSMakeRange(index, 3))
  formattedString.appendFormat("%@-", prefix)
  index += 3
  }
  
  let remainder = decimalString.substring(from: index)
  formattedString.append(remainder)
  textField.text = formattedString as String
    if length < 10{
      toolBar.barTintColor = kColor_ToolBarUnselected
      continueButton.isSelected = false
    }else{
      continueButton.isSelected = true
      toolBar.barTintColor = kColor_continueSelected
    }
  return false
  }
  else
  {
  return true
  }
  }
  
    //MARK:- IB button action
  /***********************************************************************************************************
   <Name> continueButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on continue button</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
    @IBAction func continueButtonTappedAction(_ sender: AnyObject) {
        // EnterMobNumber //
      toolBarContinueButtonAction(self)
    }
  /***********************************************************************************************************
   <Name> continueButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on Already have account button tapped</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
    @IBAction func alreadyHaveAccountButtonTapped(_ sender: AnyObject) {
        cancelButtonTappedAction(sender as! UIButton)
    }
  /***********************************************************************************************************
   <Name> touchUpActionOnScrollview </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on Scroll view to handle end editing</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
    @IBAction func touchUpActionOnScrollview(_ sender: AnyObject){
        self.contentView.endEditing(true)
      
    }
  /***********************************************************************************************************
   <Name> toolBarContinueButtonAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on contine button on tool bar on above keyboard</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/

    func toolBarContinueButtonAction(_ sender: AnyObject) {
      switch  flowType{
      case .SignUp:
        if continueButton.isSelected{
          self.view.endEditing(true)
          btnContinue.isHidden = false
          lblAboutNameInfo.isHidden = true
          btnContinue.backgroundColor = kColor_continueSelected
          btnContinue.isSelected = true
          btnNotHaveTextEnable.isHidden = true
          let prameter = ["phone":txfldEnterYourMobileNumber.text! as String]
          webServiceCallingToValidatePhoneNumber(prameter: prameter as [String : AnyObject], withUrlType: kValidate_Phone_Number)
        //  self.performSegueWithIdentifier(kSegue_EnterEmailId, sender: self)
        }
      case .SignUpPopup:
        self.view.endEditing(true)
        let alertTitle = "CodeSendTitle".localized(lang: languageCode, comment: "")
        let alertbody = "CodeSendOnMobileBody".localized(lang: languageCode, comment: "")
        let alert = UIAlertController(title: alertTitle, message: alertbody, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok".localized(lang: languageCode, comment: "Call us Now"), style: .default , handler:{ (UIAlertAction)in
          self.dismiss(animated: true, completion: {});
        }))
        self.present(alert, animated: true, completion: {
          print("completion block")
        })
      case .ResetPassword:
        self.view.endEditing(true)
        btnContinue.isHidden = false
        lblAboutNameInfo.isHidden = true
        btnContinue.backgroundColor = kColor_continueSelected
        btnContinue.isSelected = true
        btnNotHaveTextEnable.isHidden = true
        
        let phoneNo = removeSpecialCharsFromString(text:txfldEnterYourMobileNumber.text!)
        let resetPram:[String:AnyObject] = ["mobile":phoneNo as AnyObject]
        webServiceCallingToResetPasswordByMobileNumber(prameter: resetPram, withUrlType: kPassword_reset_by_mobile)
        
      //  self.performSegue(withIdentifier: kSegue_VarificationPhoneNo, sender: self)
      case .RecoverUsername:
        self.view.endEditing(true)
        btnContinue.isHidden = false
        lblAboutNameInfo.isHidden = true
        btnContinue.backgroundColor = kColor_continueSelected
        btnContinue.isSelected = true
        btnNotHaveTextEnable.isHidden = true
        let phoneNo = removeSpecialCharsFromString(text:txfldEnterYourMobileNumber.text!)
        let recoverPram:[String:AnyObject] = ["mobile":phoneNo as AnyObject]
       webServiceCallingToRecoverUserNameByMobileNumber(prameter: recoverPram, withUrlType: kRecoverUserNameByPhoneNo)
      case .Login:
        continueButton.setTitle("SendCode".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
      default :
        let alertTitle = "RecoverUserNamePhoneNoTitle".localized(lang: languageCode, comment: "")
        let alertbody = "RecoverUserNamePhoneNoBody".localized(lang: languageCode, comment: "")
        let alert = UIAlertController(title: alertTitle, message: alertbody, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok".localized(lang: languageCode, comment: "Call us Now"), style: .default , handler:{ (UIAlertAction)in
         // self.performSegueWithIdentifier(kSegue_TabBarBaseView, sender: self)
          self.cancelButtonTappedActionWithAnimation()
        }))
        self.present(alert, animated: true, completion: {
          print("completion block")
        })
      }
      
      
//      if varificationMode {
//        self.view.endEditing(true)
//        let alertTitle = "CodeSendTitle".localized(lang: languageCode, comment: "")
//        let alertbody = "CodeSendOnMobileBody".localized(lang: languageCode, comment: "")
//        let alert = UIAlertController(title: alertTitle, message: alertbody, preferredStyle: .Alert)
//        alert.addAction(UIAlertAction(title: "Ok".localized(languageCode, comment: "Call us Now"), style: .Default , handler:{ (UIAlertAction)in
//          self.dismissViewControllerAnimated(true, completion: {});
//        }))
//        self.presentViewController(alert, animated: true, completion: {
//          print("completion block")
//        })
//      }else{
//      if continueButton.selected{
//        self.view.endEditing(true)
//        btnContinue.isHidden = false
//        lblAboutNameInfo.isHidden = true
//        btnContinue.backgroundColor = kColor_continueSelected
//        btnContinue.selected = true
//        btnNotHaveTextEnable.isHidden = true
//        self.performSegueWithIdentifier(kSegue_EnterEmailId, sender: self)
//      }
//      }
    }
  /***********************************************************************************************************
   <Name> addBarButtonOnNavigationBar </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to add cancel bar button on navigation bar</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  func addBarButtonOnNavigationBar(){
    let btn1 = UIButton(frame:KFrame_CancelBarbutton )
    btn1.setTitle("Cancel".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btn1.addTarget(self, action: #selector(SignUpEnterEmailViewController.cancelBarButtonTappedAction(_:)), for: .touchUpInside)
    self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: btn1), animated: true);
    
  }
  /***********************************************************************************************************
   <Name> cancelBarButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on cancel button action </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  func cancelBarButtonTappedAction(_ sender : UIButton){
    self.dismiss(animated: true, completion: {});
  }
  // MARK: - web service
  //to validate phone number
  /***********************************************************************************************************
   <Name> webServiceCallingToValidatePhoneNumber </Name>
   <Input Type> Url , and premeters </Input Type>
   <Return> void </Return>
   <Purpose> method to call a almofire web service method from alamofire connection class  </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  28/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  func webServiceCallingToValidatePhoneNumber(prameter:[String :AnyObject], withUrlType endPointUrl:String){
    let finalUrlToHit = "\(kBaseUrl)\(endPointUrl)"
    //\(Format.json.rawValue)"
   AlamoFireConnectivity.alamofirePostRequest(param: prameter, withUrlString: finalUrlToHit) { (data, error) in
          if data != nil{
            self.methodToHandelValidatePhoneNumberSuccess(data: data!)
          }else{
            self.methodToHandelValidatePhoneNumberfailure(error: error!)
          }
    
    }
    
//    AlamoFireConnectivity.alamofireGetRequest(finalUrlToHit) { (data, error) in
//      if data != nil{
//        self.methodToHandelValidatePhoneNumberSuccess(data!)
//      }else{
//        self.methodToHandelValidatePhoneNumberfailure(error!)
//      }
//    }
  }
  func methodToHandelValidatePhoneNumberSuccess(data:JSON) {
    //print(data)
    let status = data["Success"].stringValue
    if(status.lowercased() == "true"){
      let dataValue = data["Data"].dictionary
      let phoneNumber = dataValue!["Phone"]?.stringValue
      signUpdetailsObject.mobileNumber = phoneNumber
     self.performSegue(withIdentifier: kSegue_EnterEmailId, sender: self)
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
  func methodToHandelValidatePhoneNumberfailure(error:NSError?){
    if error != nil{
      if error?.code != 123{
        self.showTheAlertViewWith(title: "Alert".localized(lang: languageCode, comment: ""), withMessage:error!.description, languageCode: languageCode)
      }else{
        self.showTheAlertViewWith(title: (error?.localizedDescription)!, withMessage:(error?.localizedFailureReason)!, languageCode: languageCode)
      }
      
    }
  }
  
  //MARK: Recover User from mobile web services 
  /***********************************************************************************************************
   <Name> webServiceCallingToRecoverUserNameByMobileNumber </Name>
   <Input Type> Url , and premeters </Input Type>
   <Return> void </Return>
   <Purpose> method to call a almofire web service method from alamofire connection class to request post web service </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  18/01/17 </Date>
   </History>
   ***********************************************************************************************************/
  func webServiceCallingToRecoverUserNameByMobileNumber(prameter:[String :AnyObject], withUrlType endPointUrl:String){
    let finalUrlToHit = "\(kBaseUrl)\(UrlEndPoints.Login.rawValue)\(endPointUrl)"
    AlamoFireConnectivity.alamofirePostRequest(param: prameter, withUrlString: finalUrlToHit) { (data, error) in
      if data != nil{
        self.methodToHandelRecoverUserNameByMobileNumberSuccess(data: data!)
      }else{
        self.methodToHandelRecoverUserNameByMobileNumberfailure(error: error!)
      }
      
    }
  }
  func methodToHandelRecoverUserNameByMobileNumberSuccess(data:JSON) {
    //print(data)
    let status = data["Success"].stringValue
    if(status.lowercased() == "true"){
    print("sucess")
      let alertTitle = "RecoverUserNamePhoneNoTitle".localized(lang: languageCode, comment: "")
      let alertbody = "RecoverUserNamePhoneNoBody".localized(lang: languageCode, comment: "")
      let alert = UIAlertController(title: alertTitle, message: alertbody, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok".localized(lang: languageCode, comment: "Call us Now"), style: .default , handler:{ (UIAlertAction)in
        // self.performSegueWithIdentifier(kSegue_TabBarBaseView, sender: self)
        self.cancelButtonTappedActionWithAnimation()
      }))
      self.present(alert, animated: true, completion: {
        print("completion block")
      })
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
  func methodToHandelRecoverUserNameByMobileNumberfailure(error:NSError?){
    if error != nil{
      if error?.code != 123{
        self.showTheAlertViewWith(title: "Alert".localized(lang: languageCode, comment: ""), withMessage:error!.description, languageCode: languageCode)
      }else{
        self.showTheAlertViewWith(title: (error?.localizedDescription)!, withMessage:(error?.localizedFailureReason)!, languageCode: languageCode)
      }
      
    }
  }

  //MARK: Password Reset from mobile number
  /***********************************************************************************************************
   <Name> webServiceCallingToResetPasswordByMobileNumber </Name>
   <Input Type> Url , and premeters </Input Type>
   <Return> void </Return>
   <Purpose> method to call a almofire web service method from alamofire connection class to request post web service for reset password by mobile number </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  18/01/17 </Date>
   </History>
   ***********************************************************************************************************/
  func webServiceCallingToResetPasswordByMobileNumber(prameter:[String :AnyObject], withUrlType endPointUrl:String){
    let finalUrlToHit = "\(kBaseUrl)\(UrlEndPoints.Login.rawValue)\(endPointUrl)"
    AlamoFireConnectivity.alamofirePostRequest(param: prameter, withUrlString: finalUrlToHit) { (data, error) in
      if data != nil{
        self.methodToHandelResetPasswordByMobileNumberSuccess(data: data!)
      }else{
        self.methodToHandelResetPasswordByMobileNumberfailure(error: error!)
      }
      
    }
  }
  func methodToHandelResetPasswordByMobileNumberSuccess(data:JSON) {
    //print(data)
    let status = data["Success"].stringValue
    if(status.lowercased() == "true"){
      print("sucess")
      self.performSegue(withIdentifier: kSegue_VarificationPhoneNo, sender: self)
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
  func methodToHandelResetPasswordByMobileNumberfailure(error:NSError?){
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
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.title = "Back"
      switch segue.identifier! as String {
      case kSegue_TabBarBaseView:
        let destinationViewController = segue.destination as? TabBarBaseViewController
          destinationViewController?.transitioningDelegate = self
          swipeInteractionController.wireToViewController(viewController: destinationViewController)
      case kSegue_EnterEmailId:
          let destinationViewController = segue.destination as? SignUpEnterEmailViewController
            destinationViewController?.userDetails = userDetails
            destinationViewController?.signUpdetailsObject = signUpdetailsObject
      case kSegue_VarificationPhoneNo:
            let destinationViewController = segue.destination as? FLPhoneNoVerifyViewController
              destinationViewController?.phoneNumber = txfldEnterYourMobileNumber.text!
              destinationViewController?.flowType = flowType
      default:
        print("no segue selected")
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
   <Date>  30/08/16 </Date>
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
  /// remove extra characters
  func removeSpecialCharsFromString(text: String) -> String {
    let okayChars : Set<Character> =
      Set("1234567890".characters)
    return String(text.characters.filter {okayChars.contains($0) })
  }
}
