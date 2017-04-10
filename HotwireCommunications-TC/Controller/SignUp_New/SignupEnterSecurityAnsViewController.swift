//
//  SignupEnterSecurityAnsViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 04/10/16.
//  Copyright © 2016 chetu. All rights reserved.
//

import UIKit

class SignupEnterSecurityAnsViewController: BaseViewController,UITextFieldDelegate {
  var languageCode:String!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var contentView: UIView!
  
  @IBOutlet var lblPageTitle: UILabel!
  @IBOutlet var txfldEnterSecurityAnswer : UITextField!
  @IBOutlet var lblAboutSecurityAnswerInfo: UILabel!
  @IBOutlet weak var btnContinue: UIButton!
  @IBOutlet weak var btnAlreadyHaveAccount: UIButton!
  var ContinueButton:UIBarButtonItem!
  var viewTitleKey:String!
  //MARK:- controller lyfecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewProperty()
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBar.hidden = false
    viewUpdateContentOnBasesOfLanguage()
    addNotificationObserver()
    lblAboutSecurityAnswerInfo.hidden = true
    btnContinue.hidden = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  //MARK:- Refresh view
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    self.navigationItem.title =  "SignUp".localized(languageCode, comment: "")
    
    lblPageTitle.text = viewTitleKey.localized(languageCode, comment: "")
    btnAlreadyHaveAccount.setTitle("AlreadyHaveAccount".localized(languageCode, comment: ""), forState: UIControlState.Normal)
    btnContinue.setTitle("Continue".localized(languageCode, comment: ""), forState: UIControlState.Normal)
    btnContinue.backgroundColor = kColor_ContinuteUnselected
    btnContinue.selected = false
    txfldEnterSecurityAnswer.placeholder = "EnterSecurityAnswer".localized(languageCode, comment: "")
    lblAboutSecurityAnswerInfo.text = "SecurityAnswerInfoText".localized(languageCode, comment: "")

  }
  func configureViewProperty(){
    txfldEnterSecurityAnswer.layer.cornerRadius = 4.0
    txfldEnterSecurityAnswer.leftViewMode = UITextFieldViewMode.Always
    txfldEnterSecurityAnswer.layer.masksToBounds = true
    txfldEnterSecurityAnswer.layer.borderColor = kColor_SignUpbutton.CGColor
    txfldEnterSecurityAnswer.layer.borderWidth = 1.0
    txfldEnterSecurityAnswer.returnKeyType = .Next
    txfldEnterSecurityAnswer.enablesReturnKeyAutomatically = true
    
  }
  
  //MARK: textField delegate method
  func textFieldDidBeginEditing(textField: UITextField) {
    lblAboutSecurityAnswerInfo.hidden = false
    btnContinue.hidden = true
    btnContinue.backgroundColor = kColor_ContinuteUnselected
    btnContinue.selected = false
  }
  func textFieldDidEndEditing(textField: UITextField) {
    lblAboutSecurityAnswerInfo.hidden = true
    btnContinue.hidden = false
    
  }
  func textFieldShouldEndEditing(textField: UITextField) -> Bool {
    print("textFieldShouldEndEditing")
    return true
  }
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if textField == txfldEnterSecurityAnswer{
      if txfldEnterSecurityAnswer.text != ""{
        self.view.endEditing(true)
        btnContinue.backgroundColor = kColor_continueSelected
        btnContinue.selected = true
      }
    }
    return true
  }
  
  //MARK:- IB button action
  @IBAction func continueButtonTappedAction(sender: AnyObject) {
    // EnterMobNumber
    if btnContinue.selected{
      self.performSegueWithIdentifier(kSegue_PushNotificationActivation, sender: self)
    }
  }
  @IBAction func alreadyHaveAccountButtonTapped(sender: AnyObject) {
    cancelButtonTappedAction(sender as! UIButton)
    
  }
  @IBAction func touchUpActionOnScrollview(sender: AnyObject){
    self.contentView.endEditing(true)
    if txfldEnterSecurityAnswer.text != ""{
      self.view.endEditing(true)
      btnContinue.backgroundColor = kColor_continueSelected
      btnContinue.selected = true
    }
  }
  func continueButtonAction(sender: AnyObject) {
   
  }
  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    self.title = "Back"
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
  }
  //MARK:- ADD notification
  func addNotificationObserver(){
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.applicationWillEnterForeground(_:)), name: UIApplicationWillEnterForegroundNotification, object: nil)
    
  }
  //notification method to update UI
  func applicationWillEnterForeground(application: UIApplication) {
    let languageIndex = NSUserDefaults.standardUserDefaults().integerForKey("language")
    LanguageManager.sharedInstance.GetSelectedlanguageFromApplicationSetting(languageIndex)
    print("applicationWillEnterForeground")
    viewUpdateContentOnBasesOfLanguage()
  }
  override func viewDidDisappear(animated: Bool) {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
}
