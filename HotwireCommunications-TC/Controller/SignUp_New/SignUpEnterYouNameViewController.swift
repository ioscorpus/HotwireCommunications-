//
//  SignUpEnterYouNameViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 30/08/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class SignUpEnterYouNameViewController: BaseViewController,UITextFieldDelegate {
     var languageCode:String!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var lblPageTitle: UILabel!
    @IBOutlet var txfldFirstName : UITextField!
    @IBOutlet var txfldLastName: UITextField!
    @IBOutlet var lblAboutNameInfo: UILabel!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnAlreadyHaveAccount: UIButton!
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
    if  !btnContinue.isSelected{
      txfldFirstName.becomeFirstResponder()
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
        self.navigationItem.title =  "SignUp".localized(lang: languageCode, comment: "")
        lblPageTitle.text = "WhatYourName".localized(lang: languageCode, comment: "")
        btnAlreadyHaveAccount.setTitle("AlreadyHaveAccount".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
        btnContinue.setTitle("Continue".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
        txfldFirstName.placeholder = "FirstName".localized(lang: languageCode, comment: "")
        txfldLastName.placeholder = "LastName".localized(lang: languageCode, comment: "")
        lblAboutNameInfo.text = "NameInfoDetails".localized(lang: languageCode, comment: "")
         setUpBackButonOnLeft()
      if let invitationCodeObject = userDetails as? InvitationCode {
        // success
       txfldFirstName.text = invitationCodeObject.first_name!
       txfldLastName.text = invitationCodeObject.last_name!
      } else {
         print("failre")
      }
    
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
    
      
        txfldFirstName.layer.cornerRadius = 4.0
        txfldFirstName.leftViewMode = UITextFieldViewMode.always
        txfldFirstName.layer.masksToBounds = true
        txfldFirstName.layer.borderColor = kColor_SignUpbutton.cgColor
        txfldFirstName.layer.borderWidth = 1.0
        txfldFirstName.keyboardType = .default
        txfldFirstName.returnKeyType = .next
        txfldFirstName.enablesReturnKeyAutomatically = true
        txfldFirstName.autocorrectionType = UITextAutocorrectionType.no
        
        txfldLastName.layer.cornerRadius = 4.0
        txfldLastName.leftViewMode = UITextFieldViewMode.always
        txfldLastName.layer.masksToBounds = true
        txfldLastName.layer.borderColor = kColor_SignUpbutton.cgColor
        txfldLastName.layer.borderWidth = 1.0
        txfldFirstName.keyboardType = .default
        txfldLastName.returnKeyType = .go
        txfldLastName.enablesReturnKeyAutomatically = true
        txfldLastName.autocorrectionType = UITextAutocorrectionType.no
      btnContinue.backgroundColor = kColor_ContinuteUnselected
      btnContinue.isSelected = false
      lblAboutNameInfo.isHidden = false
      btnContinue.isHidden = true
      
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
    btn1.setTitle("Back", for: UIControlState.normal)
    btn1.imageEdgeInsets = imageEdgeInsets;
    btn1.titleEdgeInsets = titleEdgeInsets;
    btn1.setImage(UIImage(named: "RedBackBtn"), for: UIControlState.normal)
    btn1.addTarget(self, action: #selector(SignUpEnterYouNameViewController.backButtonTappedAction(_:)
      ), for: .touchUpInside)
    self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: btn1), animated: true);
  }
  
    //MARK: textField delegate method
  /***********************************************************************************************************
   <Name> textFieldShouldEndEditing, shouldChangeCharactersInRange ,textFieldDidBeginEditing, textFieldShouldClear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Textfield delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  func textFieldDidBeginEditing(_ textField: UITextField) {
        lblAboutNameInfo.isHidden = false
        btnContinue.isHidden = true
        btnContinue.backgroundColor = kColor_ContinuteUnselected
        btnContinue.isSelected = false
    }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txfldFirstName {
            self.txfldLastName.becomeFirstResponder()
        }else if textField == txfldLastName{
            if txfldFirstName.text != "" && txfldLastName.text != ""{
            btnContinue.isHidden = false
            lblAboutNameInfo.isHidden = true
            btnContinue.backgroundColor = kColor_continueSelected
            btnContinue.isSelected = true
              // signupdata entry
              signUpdetailsObject.firstName = txfldFirstName.text
              signUpdetailsObject.lastName = txfldLastName.text
            self.performSegue(withIdentifier: kSegue_EnterMobNumber, sender: self)
            }else{
              if txfldFirstName.text == ""{
                 txfldFirstName.becomeFirstResponder()
              }
          }
        }
        return true
    }
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
   
    return true
  }
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if txfldFirstName.text != "" && txfldLastName.text != "" {
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
        // EnterMobNumber
      self.view.endEditing(true)
        if btnContinue.isSelected{
          signUpdetailsObject.firstName = txfldFirstName.text
          signUpdetailsObject.lastName = txfldLastName.text
         self.performSegue(withIdentifier: kSegue_EnterMobNumber, sender: self)
        }
    }
  /***********************************************************************************************************
   <Name> alreadyHaveAccountButtonTapped </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on already have account button</Purpose>
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
   <Purpose> method execute when click on scrollview button to end editing</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func touchUpActionOnScrollview(_ sender: AnyObject){
     self.contentView.endEditing(true)
   
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
      if segue.identifier == kSegue_EnterMobNumber{
        if let nextViewController = segue.destination as? SignUpEnterMobNoViewController {
          nextViewController.flowType = FlowType.SignUp
          nextViewController.userDetails = userDetails
          nextViewController.signUpdetailsObject = signUpdetailsObject
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
}
