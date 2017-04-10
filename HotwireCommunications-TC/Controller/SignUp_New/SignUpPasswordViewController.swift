//
//  SignUpPasswordViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 2/09/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class SignUpPasswordViewController: BaseViewController,UITextFieldDelegate {
  var languageCode:String!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var contentView: UIView!
  
  @IBOutlet var lblPageTitle: UILabel!
  @IBOutlet var txfldEnterPassword : UITextField!
  @IBOutlet var lblAboutPasswordInfo: UILabel!
  @IBOutlet weak var btnContinue: UIButton!
  @IBOutlet weak var btnAlreadyHaveAccount: UIButton!
  var ContinueButton:UIBarButtonItem!
  //validation
  @IBOutlet var lblPasswordStrength: UILabel!
  // validation button
  @IBOutlet var btnMinEightCharacters: UIButton!
  @IBOutlet var lblMinEightCharacters: UILabel!
  @IBOutlet var btnOneUpperCaseLetter: UIButton!
  @IBOutlet var lblOneUpperCaseLetter: UILabel!
  @IBOutlet var btnOneLowerCaseLetter: UIButton!
  @IBOutlet var lblOneLowerCaseLetter: UILabel!
  @IBOutlet var btnOneNumber: UIButton!
  @IBOutlet var lblOneNumber: UILabel!
  @IBOutlet var btnOneSpecialCharacter: UIButton!
  @IBOutlet var lblOneSpecialCharacter: UILabel!
  // flow type
  var flowType:FlowType = FlowType.SignUp
  // data object
  var signUpdetailsObject:SignUpDetails!
  
  //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear ,viewDidAppear</Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 2/09/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  override func viewDidLoad() {
    super.viewDidLoad()
    DispatchQueue.main.async{
     self.configureViewProperty()
    }
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = false
    viewUpdateContentOnBasesOfLanguage()
    addNotificationObserver()
    lblAboutPasswordInfo.isHidden = true
    methodToHideValidationUserInterface()
    btnContinue.isHidden = false
  }
  override func viewDidAppear(_ animated: Bool) {
    if !btnContinue.isSelected{
      txfldEnterPassword.becomeFirstResponder()
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
   <Date>  2/09/16 </Date>
   </History>
   ***********************************************************************************************************/

  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    
    btnAlreadyHaveAccount.setTitle("AlreadyHaveAccount".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btnContinue.setTitle("Continue".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    txfldEnterPassword.placeholder = "EnterPassword".localized(lang: languageCode, comment: "")
    lblAboutPasswordInfo.text = "PasswordInfoText".localized(lang: languageCode, comment: "")
   
    lblPasswordStrength.text =  "PasswordStrength".localized(lang: languageCode, comment: "")
    lblMinEightCharacters.text =  "MinimumEightCharacters".localized(lang: languageCode, comment: "")
    lblOneUpperCaseLetter.text =  "OneUpperCaseLetter".localized(lang: languageCode, comment: "")
     lblOneLowerCaseLetter.text =  "OneLowerCaseLetter".localized(lang: languageCode, comment: "")
     lblOneNumber.text =  "OneNumber".localized(lang: languageCode, comment: "")
     lblOneSpecialCharacter.text =  "OneSpecialCharacter".localized(lang: languageCode, comment: "")
    switch flowType {
    case .SignUp:
        setUpBackButonOnLeft()
        self.navigationItem.title =  "SignUp".localized(lang: languageCode, comment: "")
        lblPageTitle.text = "CreatePassword".localized(lang: languageCode, comment: "")
    case .ResetPassword:
       self.navigationItem.setHidesBackButton(true, animated:true);
       setUpCancelButonOnRightWithAnimation()
       self.navigationItem.title =  "NewPassword".localized(lang: languageCode, comment: "")
       lblPageTitle.text = "EnterNewPassword".localized(lang: languageCode, comment: "")
    default:
      print("another flow")
    }
    
  }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  2/09/16 </Date>
   </History>
   ***********************************************************************************************************/
  func configureViewProperty(){
  
  //  txfldEnterPassword.becomeFirstResponder()
    txfldEnterPassword.layer.cornerRadius = 4.0
    txfldEnterPassword.leftViewMode = UITextFieldViewMode.always
    txfldEnterPassword.layer.masksToBounds = true
    txfldEnterPassword.layer.borderColor = kColor_SignUpbutton.cgColor
    txfldEnterPassword.layer.borderWidth = 1.0
    txfldEnterPassword.returnKeyType = .go
    txfldEnterPassword.enablesReturnKeyAutomatically = true
    txfldEnterPassword.autocorrectionType = UITextAutocorrectionType.no
    // set button state default
    btnMinEightCharacters.isSelected = false
    btnOneUpperCaseLetter.isSelected = false
    btnOneLowerCaseLetter.isSelected = false
    btnOneNumber.isSelected = false
    btnOneSpecialCharacter.isSelected = false
    lblAboutPasswordInfo.isHidden = false
    methodToUnHideValidationUserInterface()
    btnContinue.isHidden = true
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
   <Date>  2/09/16 </Date>
   </History>
   ***********************************************************************************************************/
  func setUpBackButonOnLeft(){
    self.navigationItem.setHidesBackButton(true, animated:true);
    let btn1 = UIButton(frame:KFrame_CancelBarbutton )
    btn1.setTitle("Back".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btn1.imageEdgeInsets = imageEdgeInsets;
    btn1.titleEdgeInsets = titleEdgeInsets;
    btn1.setImage(UIImage(named: "RedBackBtn"), for: UIControlState.normal)
    btn1.addTarget(self, action: #selector(SignUpPasswordViewController.backButtonTappedAction(_:)), for: .touchUpInside)
    self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: btn1), animated: true);
  }
  /***********************************************************************************************************
   <Name> backButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on custom back button to navigate to next view</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  2/09/16 </Date>
   </History>
   ***********************************************************************************************************/
  func backButtonTappedAction(_ sender : UIButton){
    self.navigationController!.popViewController(animated: true)
  }
  func methodToHideValidationUserInterface(){
    btnMinEightCharacters.isHidden = true
    btnOneUpperCaseLetter.isHidden = true
    btnOneLowerCaseLetter.isHidden = true
    btnOneNumber.isHidden = true
    btnOneSpecialCharacter.isHidden = true
    lblPasswordStrength.isHidden =  true
    lblMinEightCharacters.isHidden = true
    lblOneUpperCaseLetter.isHidden = true
    lblOneLowerCaseLetter.isHidden =  true
    lblOneNumber.isHidden = true
    lblOneSpecialCharacter.isHidden = true
  }
  func methodToUnHideValidationUserInterface(){
    btnMinEightCharacters.isHidden = false
    btnOneUpperCaseLetter.isHidden = false
    btnOneLowerCaseLetter.isHidden = false
    btnOneNumber.isHidden = false
    btnOneSpecialCharacter.isHidden = false
    lblPasswordStrength.isHidden =  false
    lblMinEightCharacters.isHidden = false
    lblOneUpperCaseLetter.isHidden = false
    lblOneLowerCaseLetter.isHidden =  false
    lblOneNumber.isHidden = false
    lblOneSpecialCharacter.isHidden = false
  }
  //MARK: textField delegate method
  /***********************************************************************************************************
   <Name> textFieldShouldEndEditing, shouldChangeCharactersInRange ,textFieldDidBeginEditing,textFieldShouldEndEditing </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Textfield delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  2/09/16 </Date>
   </History>
   ***********************************************************************************************************/
  func textFieldDidBeginEditing(_ textField: UITextField) {
    lblAboutPasswordInfo.isHidden = false
    methodToUnHideValidationUserInterface()
    btnContinue.isHidden = true
    btnContinue.backgroundColor = kColor_ContinuteUnselected
    btnContinue.isSelected = false
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
    lblAboutPasswordInfo.isHidden = true
    btnContinue.isHidden = false
    
  }
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    btnMinEightCharacters.isSelected = newString.range(of: ".{8}", options: .regularExpression) != nil ? true :false
    btnOneUpperCaseLetter.isSelected = newString.range(of:"(.*[A-Z])", options: .regularExpression) != nil ? true :false
    btnOneLowerCaseLetter.isSelected = newString.range(of:"(.*[a-z])", options: .regularExpression) != nil ? true :false
    btnOneNumber.isSelected = newString.range(of:"(.*[0-9])", options: .regularExpression) != nil ? true :false
    btnOneSpecialCharacter.isSelected = newString.range(of:"(.*[!@#$&*])", options: .regularExpression) != nil ? true :false
    return true
  }
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text!.range(of:".{8}", options: .regularExpression) != nil &&  textField.text!.range(of:"(.*[A-Z])", options: .regularExpression) != nil && textField.text!.range(of:"(.*[a-z])", options: .regularExpression) != nil && textField.text!.range(of:"(.*[0-9])", options: .regularExpression) != nil && textField.text!.range(of:"(.*[!@#$&*])", options: .regularExpression) != nil{
      methodToHideValidationUserInterface()
      btnContinue.backgroundColor = kColor_continueSelected
      btnContinue.isSelected = true
      
    }else{
      methodToHideValidationUserInterface()
      btnContinue.backgroundColor = kColor_continueUnselected
      btnContinue.isSelected = false
    }
   
    return true
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
       if textField.text!.range(of:".{8}", options: .regularExpression) != nil &&  textField.text!.range(of:"(.*[A-Z])", options: .regularExpression) != nil && textField.text!.range(of:"(.*[a-z])", options: .regularExpression) != nil && textField.text!.range(of:"(.*[0-9])", options: .regularExpression) != nil && textField.text!.range(of:"(.*[!@#$&*])", options: .regularExpression) != nil{
        self.view.endEditing(true)
        btnContinue.backgroundColor = kColor_continueSelected
        btnContinue.isSelected = true
        switch flowType {
        case .ResetPassword:
             methodToMakeLoginScreenRoot()
        case .SignUp:
           signUpdetailsObject.password = txfldEnterPassword.text!
          self.performSegue(withIdentifier: kSegue_SecurityPin, sender: self)
        default:
          self.performSegue(withIdentifier: kSegue_TabBarBaseView, sender: self)
        }
        
       }else{
        // Show ERROR
    }
 
    return true
  }
  //MARK:- IB button action
  /***********************************************************************************************************
   <Name> continueButtonTappedAction </Name>
   <Input Type>  AnyObject  </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on continue button</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  2/09/16 </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func continueButtonTappedAction(_ sender: AnyObject) {
    // EnterMobNumber
    self.view.endEditing(true)
    if txfldEnterPassword.text!.range(of:".{8}", options: .regularExpression) != nil &&  txfldEnterPassword.text!.range(of:"(.*[A-Z])", options: .regularExpression) != nil && txfldEnterPassword.text!.range(of:"(.*[a-z])", options: .regularExpression) != nil && txfldEnterPassword.text!.range(of:"(.*[0-9])", options: .regularExpression) != nil && txfldEnterPassword.text!.range(of:"(.*[!@#$&*])", options: .regularExpression) != nil{
      switch flowType {
      case .ResetPassword:
          methodToMakeLoginScreenRoot()
      case .SignUp:
          signUpdetailsObject.password = txfldEnterPassword.text!
          self.performSegue(withIdentifier: kSegue_SecurityPin, sender: self)
      default:
          self.performSegue(withIdentifier: kSegue_TabBarBaseView, sender: self)
      }
    
    }else{
       // Show ERROR
    }
  }
  @IBAction func alreadyHaveAccountButtonTapped(_ sender: AnyObject) {
    cancelButtonTappedAction(sender as! UIButton)
    
  }
  /***********************************************************************************************************
   <Name> touchUpActionOnScrollview </Name>
   <Input Type> AnyObject   </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on Scroll view to end editing on view</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  2/09/16 </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func touchUpActionOnScrollview(_ sender: AnyObject){
    if txfldEnterPassword.text != ""{
      self.view.endEditing(true)
//       methodToHideValidationUserInterface()
//      btnContinue.backgroundColor = kColor_continueSelected
//      btnContinue.selected = true
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
   <Date>  2/09/16 </Date>
   </History>
   ***********************************************************************************************************/
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    self.title = "Back"
    if segue.identifier == kSegue_TabBarBaseView,
      let destinationViewController = segue.destination as? TabBarBaseViewController {
      destinationViewController.transitioningDelegate = self
      swipeInteractionController.wireToViewController(viewController: destinationViewController)
    }
    if segue.identifier == kSegue_SecurityPin,
      let destinationViewController = segue.destination as? SecurityPinSignUpViewController {
      destinationViewController.signUpdetailsObject = signUpdetailsObject
    }
  }
  func methodToMakeLoginScreenRoot(){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let storyboard = UIStoryboard(name:kStoryBoardMain, bundle: nil)
    let mainViewController = storyboard.instantiateViewController(withIdentifier: kStoryBoardID_LoginPage)
    let nav:UINavigationController = UINavigationController(rootViewController:mainViewController)
    appDelegate.window?.rootViewController = nav
  }
  
  //MARK:- ADD notification
  
  /***********************************************************************************************************
   <Name> addNotificationObserver </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call when aplication come to foreground and update selected languge </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  2/09/16 </Date>
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
