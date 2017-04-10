//
//  LoginEmailVerificationViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 03/11/16.
//  Copyright © 2016 chetu. All rights reserved.
//

import UIKit

class LoginEmailVerificationViewController: BaseViewController ,UITextFieldDelegate{
  var languageCode:String!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var contentView: UIView!
  @IBOutlet var lblPageTitle: UILabel!
  @IBOutlet var txfldEnterEmailAddress : UITextField!
  @IBOutlet var lblAboutEmailAddressInfo: UILabel!
  @IBOutlet weak var btnContinue: UIButton!
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
    viewUpdateContentOnBasesOfLanguage()
    addNotificationObserver()
    self.navigationController?.navigationBar.isHidden = false
    self.navigationItem.setHidesBackButton(true, animated: false)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    if !btnContinue.isSelected{
      txfldEnterEmailAddress.becomeFirstResponder()
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
    lblPageTitle.text = "VerifyEmailAddress".localized(lang: languageCode, comment: "")
    btnContinue.setTitle("Continue".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    txfldEnterEmailAddress.placeholder = "EnterEmailAddress".localized(lang: languageCode, comment: "")
    lblAboutEmailAddressInfo.text = "VerifyEmailAddressInfo".localized(lang: languageCode, comment: "")
    
    
    //addBarButtonOnNavigationBar()
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
    
    // txfldEnterEmailAddress.becomeFirstResponder()
    txfldEnterEmailAddress.layer.cornerRadius = 4.0
    txfldEnterEmailAddress.leftViewMode = UITextFieldViewMode.always
    txfldEnterEmailAddress.layer.masksToBounds = true
    txfldEnterEmailAddress.layer.borderColor = kColor_SignUpbutton.cgColor
    txfldEnterEmailAddress.layer.borderWidth = 1.0
    txfldEnterEmailAddress.returnKeyType = .go
    txfldEnterEmailAddress.keyboardType = .emailAddress
    txfldEnterEmailAddress.enablesReturnKeyAutomatically = true
    txfldEnterEmailAddress.autocorrectionType = UITextAutocorrectionType.no
    btnContinue.backgroundColor = kColor_ContinuteUnselected
    btnContinue.isSelected = false
    lblAboutEmailAddressInfo.isHidden = false
    btnContinue.isHidden = true
  }   //MARK: textField delegate method
  
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
    lblAboutEmailAddressInfo.isHidden = false
    btnContinue.isHidden = true
    btnContinue.backgroundColor = kColor_ContinuteUnselected
    btnContinue.isSelected = false
  }
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if isValidEmail(testStr: textField.text!){
      self.view.endEditing(true)
      btnContinue.backgroundColor = kColor_continueSelected
      btnContinue.isSelected = true
      lblAboutEmailAddressInfo.isHidden = true
      btnContinue.isHidden = false
      
    }else{
      btnContinue.backgroundColor = kColor_continueUnselected
      btnContinue.isSelected = false
      lblAboutEmailAddressInfo.isHidden = true
      btnContinue.isHidden = false
    }
    return true
  }
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    if isValidEmail(testStr: newString){
      //      btnContinue.backgroundColor = kColor_continueSelected
      //      btnContinue.selected = true
    }else{
      //      btnContinue.backgroundColor = kColor_continueUnselected
      //      btnContinue.selected = false
    }
    
    
    return true
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if isValidEmail(testStr: textField.text!){
      self.view.endEditing(true)
      btnContinue.backgroundColor = kColor_continueSelected
      btnContinue.isSelected = true
      self.performSegue(withIdentifier: kSegue_LoginEmailVarification, sender: self)
    }else{
      //       btnContinue.backgroundColor = kColor_continueUnselected
      //       btnContinue.selected = false
      showTheAlertViewWith(title: "Invalid EmailId", withMessage: "Please enter valid email address", languageCode: languageCode)
    }
    
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
   <Date>  03/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func continueButtonTappedAction(_ sender: AnyObject) {
    // EnterMobNumber
    if btnContinue.isSelected{
      self.performSegue(withIdentifier: kSegue_LoginEmailVarification, sender: self)
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
