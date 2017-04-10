//
//  AccountSetupViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 03/11/16.
//  Copyright © 2016 chetu. All rights reserved.
//

import UIKit

class AccountSetupViewController: BaseViewController ,UITextFieldDelegate{
  var languageCode:String!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var contentView: UIView!
  
  @IBOutlet var lblPageTitle: UILabel!
  @IBOutlet var txfldEnterYourMobileNumber : UITextField!
  @IBOutlet var lblAboutNameInfo: UILabel!
  @IBOutlet weak var btnContinue: UIButton!
  @IBOutlet var tappedGesture: UITapGestureRecognizer!
  // Toolbar variable declaration
  var toolBar:UIToolbar!
  var continueButton:UIButton!
  // login or signup flag
  var login:Bool = false
  //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 03/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewProperty()
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = false
    self.navigationItem.setHidesBackButton(true, animated: false)
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
   <Date>  03/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    self.navigationItem.title =  "AccountSetup".localized(lang: languageCode, comment: "")
    lblPageTitle.text = "VerifyMobileNumber".localized(lang: languageCode, comment: "")
    btnContinue.setTitle("Continue".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    txfldEnterYourMobileNumber.placeholder = "EnterYourMobileNumber".localized(lang: languageCode, comment: "")
    lblAboutNameInfo.text = "VerifyMobileNumberInfoText".localized(lang: languageCode, comment: "")
    
    toolBar = addDoneButton( selector: #selector(SignUpEnterMobNoViewController.toolBarContinueButtonAction(_:)))
    txfldEnterYourMobileNumber.inputAccessoryView = toolBar
      addBarButtonOnNavigationBar()
      tappedGesture.isEnabled = true
  }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  03/11/16 </Date>
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
    let phoneNumberCode = UILabel.init(frame: CGRect.init(0, 0, 70, txfldEnterYourMobileNumber.bounds.height))
    phoneNumberCode.text = "  US  +1"
    if txfldEnterYourMobileNumber.bounds.height <= 35{
      phoneNumberCode.font = kFontStyleSemiBold18
    }else{
      phoneNumberCode.font = kFontStyleSemiBold18
    }
    phoneNumberCode.textColor = UIColor.black
    txfldEnterYourMobileNumber.leftView = phoneNumberCode
    txfldEnterYourMobileNumber.leftViewMode = .always
    
    lblAboutNameInfo.isHidden = false
    btnContinue.isHidden = true
    btnContinue.backgroundColor = kColor_ContinuteUnselected
    btnContinue.isSelected = false
  }
  /***********************************************************************************************************
   <Name> addDoneButton </Name>
   <Input Type>  Selector  </Input Type>
   <Return> UIToolbar </Return>
   <Purpose> method to set the toolbar on keyboard </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  03/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  func addDoneButton(selector:Selector) -> UIToolbar {
    let toolbar = UIToolbar()
    let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    continueButton = UIButton()
    continueButton.frame = KFrame_Toolbar
    continueButton.setTitle("SendCode".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
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
   <Date>  03/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
      if (textField.text?.characters.count)! < 6{
        toolBar.barTintColor = kColor_ToolBarUnselected
        continueButton.isSelected = false
        btnContinue.backgroundColor = kColor_ContinuteUnselected
        btnContinue.isSelected = false
        btnContinue.isHidden = true
        lblAboutNameInfo.isHidden = false
        
      }else{
        continueButton.isSelected = true
        toolBar.barTintColor = kColor_continueSelected
        btnContinue.backgroundColor = kColor_continueSelected
        btnContinue.isSelected = true
        btnContinue.isHidden = true
        lblAboutNameInfo.isHidden = false
      }
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
    lblAboutNameInfo.isHidden = true
    btnContinue.isHidden = false
    
  }
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    toolBar.barTintColor = kColor_ToolBarUnselected
    return true
  }
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    
    let components = textField.text!.components(separatedBy:NSCharacterSet.decimalDigits.inverted)
    
    let decimalString = components.joined(separator: "") as NSString
    let length = decimalString.length
    if length == 10{
      self.view.endEditing(true)
      lblAboutNameInfo.isHidden = true
      btnContinue.isHidden = false
      btnContinue.backgroundColor = kColor_continueSelected
      btnContinue.isSelected = true
    }else{
      lblAboutNameInfo.isHidden = true
      btnContinue.isHidden = false
      btnContinue.backgroundColor = kColor_ContinuteUnselected
      btnContinue.isSelected = false
    }
    
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
      let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
      
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
   <Date>  03/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func continueButtonTappedAction(_ sender: AnyObject) {
    // EnterMobNumber
    if btnContinue.isSelected{
     self.performSegue(withIdentifier:kSegue_VerifyMobileNumber, sender: self)
    }
  }
  /***********************************************************************************************************
   <Name> continueButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on Already have account button tapped</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  03/11/16 </Date>
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
   <Date>  03/11/16 </Date>
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
   <Date>  03/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  func toolBarContinueButtonAction(_ sender: AnyObject) {
      if continueButton.isSelected{
        self.view.endEditing(true)
        btnContinue.isHidden = false
        lblAboutNameInfo.isHidden = true
        btnContinue.backgroundColor = kColor_continueSelected
        btnContinue.isSelected = true
        self.performSegue(withIdentifier: kSegue_VerifyMobileNumber, sender: self)
      }
  }
  /***********************************************************************************************************
   <Name> addBarButtonOnNavigationBar </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to add cancel bar button on navigation bar</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  03/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  func addBarButtonOnNavigationBar(){
    let btn1 = UIButton(frame:KFrame_CancelBarbutton )
    btn1.setTitle("Skip".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btn1.titleLabel?.font = kFontStyleSemiBold18
    btn1.addTarget(self, action: #selector(AccountSetupViewController.skipBarButtonTappedAction(_:)), for: .touchUpInside)
    self.navigationItem.setRightBarButton(UIBarButtonItem(customView: btn1), animated: true)
  }
  /***********************************************************************************************************
   <Name> cancelBarButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on cancel button action </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  03/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  func skipBarButtonTappedAction(_ sender : UIButton){
  self.performSegue(withIdentifier: kSegue_SetUpEmail, sender: self)
  }
  // MARK: - Navigation
  
  /***********************************************************************************************************
   <Name> prepareForSegue </Name>
   <Input Type> UIStoryboardSegue,AnyObject </Input Type>
   <Return> void </Return>
   <Purpose> method call when segue called  </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  03/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    self.title = "Back"
    if segue.identifier == kSegue_VerifyMobileNumber{
      if let nextViewController = segue.destination as? VerifyPhoneNoViewController {
        nextViewController.login = login
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
   <Date>  03/11/16 </Date>
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
