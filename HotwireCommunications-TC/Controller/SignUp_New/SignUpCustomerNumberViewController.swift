//
//  SignUpNameEntryViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 30/08/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

class SignUpCustomerNumberViewController: BaseViewController {
    var languageCode:String!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
  
    @IBOutlet var lblPageTitle: UILabel!
    @IBOutlet var txfldInviteCode : UITextField!
    @IBOutlet var lblCustomerNoInfo: UILabel!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnAlreadyHaveAccount: UIButton!
  // Toolbar variable declaration
  var toolBar:UIToolbar!
  var continueButton:UIButton!
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
        viewUpdateContentOnBasesOfLanguage()
        addNotificationObserver()
      
    }
  override func viewDidAppear(_ animated: Bool) {
    if !btnContinue.isSelected{
      txfldInviteCode.becomeFirstResponder()
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
    self.title =  "SignUp".localized(lang: languageCode, comment: "")
    lblPageTitle.text = "CustomerNumberTitle".localized(lang: languageCode, comment: "")
    lblCustomerNoInfo.text = "Where_FoundCoustomerNumber".localized(lang: languageCode, comment: "")
    btnAlreadyHaveAccount.setTitle("AlreadyHaveAccount".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    toolBar = addDoneButton(selector: #selector(SignUpCustomerNumberViewController.continueButtonAction(_:)))
    txfldInviteCode.inputAccessoryView = toolBar
    txfldInviteCode.placeholder = "CustomerNumber".localized(lang: languageCode, comment: "")
   btnContinue.setTitle("Continue".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
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
        let paddingView = UIView(frame:CGRect.init(0, 0,5,10))
        txfldInviteCode.layer.cornerRadius = 4.0
        txfldInviteCode.leftView = paddingView;
        txfldInviteCode.leftViewMode = UITextFieldViewMode.always
        txfldInviteCode.layer.masksToBounds = true
        txfldInviteCode.layer.borderColor = kColor_SignUpbutton.cgColor
        txfldInviteCode.layer.borderWidth = 1.0
      btnContinue.backgroundColor = kColor_ContinuteUnselected
      btnContinue.isSelected = false
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
    btn1.setTitle("Back".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btn1.imageEdgeInsets = imageEdgeInsets;
    btn1.titleEdgeInsets = titleEdgeInsets;
    btn1.setImage(UIImage(named: "RedBackBtn"), for: UIControlState.normal)
    btn1.addTarget(self, action: #selector(SignUpCustomerNumberViewController.backButtonTappedAction(_:)), for: .touchUpInside)
    self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: btn1), animated: true);
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
    continueButton.setTitle("Continue".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
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

     //MARK: Text field Delegate
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
      if (textField.text?.characters.count)! < 8{
        toolBar.barTintColor = kColor_ToolBarUnselected
        continueButton.isSelected = false
        btnContinue.isSelected = false
        btnContinue.isHidden = true
        lblCustomerNoInfo.isHidden = false
      }else{
        continueButton.isSelected = true
        toolBar.barTintColor = kColor_continueSelected
        btnContinue.isSelected = false
        btnContinue.isHidden = true
        lblCustomerNoInfo.isHidden = false
      }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
      guard let text = textField.text else {
        return true
      }
      let newLength = text.utf16.count + string.utf16.count - range.length
      if newLength <= 8{
        toolBar.barTintColor = kColor_ToolBarUnselected
        continueButton.isSelected = false
      }else{
        continueButton.isSelected = true
        toolBar.barTintColor = kColor_continueSelected
      }
      return newLength <= 8
    }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    toolBar.barTintColor = kColor_ToolBarUnselected
    continueButton.isSelected = false
    return true
  }
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text?.characters.count == 8{
      self.view.endEditing(true)
      lblCustomerNoInfo.isHidden = true
      btnContinue.isHidden = false
      btnContinue.backgroundColor = kColor_continueSelected
      btnContinue.isSelected = true
    }else{
      lblCustomerNoInfo.isHidden = true
      btnContinue.isHidden = false
      btnContinue.backgroundColor = kColor_ContinuteUnselected
      btnContinue.isSelected = false
    }
    return true
  }
    //MARK:- IBoutlet action method
  /***********************************************************************************************************
   <Name> continueButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on Continue button tapped </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func continueButtonTappedAction(_ sender: AnyObject) {
    // EnterMobNumber
    if btnContinue.isSelected{
      webServiceCallingToVerifyCustomerNumber(urlType: "12344567")
     // self.performSegueWithIdentifier(kSegue_SignUpNameEntry, sender: self)
    }else{
      showTheAlertViewWith(title: "CustomerNumberInvalidTitle".localized(lang: languageCode, comment: ""), withMessage: "CustomerNumberInvalidBody".localized(lang: languageCode, comment: ""), languageCode: languageCode)
    }
  }
  /***********************************************************************************************************
   <Name> continueButtonAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on tool bar Continue button tapped </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  
    func continueButtonAction(_ sender: AnyObject) {
      if continueButton.isSelected{
        self.view.endEditing(true)
        btnContinue.isHidden = false
        lblCustomerNoInfo.isHidden = true
        btnContinue.backgroundColor = kColor_continueSelected
        btnContinue.isSelected = true
        webServiceCallingToVerifyCustomerNumber(urlType: "12344567")
      }else{
        showTheAlertViewWith(title: "CustomerNumberInvalidTitle".localized(lang: languageCode, comment: ""), withMessage: "CustomerNumberInvalidBody".localized(lang: languageCode, comment: ""), languageCode: languageCode)
      }
    }
  /***********************************************************************************************************
   <Name> touchUpActionOnScrollview </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on scroll view to end editing </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
    @IBAction func touchUpActionOnScrollview(_ sender: AnyObject){
        txfldInviteCode.resignFirstResponder()
        self.contentView.endEditing(true)
    }
  /***********************************************************************************************************
   <Name> alreadyHaveAccountButtonTapped </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on already have account button tapped </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
    @IBAction func alreadyHaveAccountButtonTapped(_ sender: AnyObject) {
        cancelButtonTappedAction(sender as! UIButton)
        
    }
  /***********************************************************************************************************
   <Name> infoButtonTapped </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on info icon button tapped </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func infoButtonTapped(_ sender: AnyObject) {
    let popUpView = self.storyboard?.instantiateViewController(withIdentifier: "infoScreen") as! InviteOrCustomerCodeDiscriptionViewController
    popUpView.customerNoSelection = true
    let navController = UINavigationController.init(rootViewController: popUpView)
    self.navigationController?.present(navController, animated: true, completion: nil)
  }
  /***********************************************************************************************************
   <Name> backButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on custom back button tapped </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  func backButtonTappedAction(_ sender : UIButton){
    self.navigationController!.popViewController(animated: true)
  }
  // MARK: - web service
  //to validate Customer number
  /***********************************************************************************************************
   <Name> webServiceCallingToVerifyCustomerNumber </Name>
   <Input Type> Url , and premeters </Input Type>
   <Return> void </Return>
   <Purpose> method to call a almofire web service method from alamofire connection class   </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  23/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  func webServiceCallingToVerifyCustomerNumber(urlType:String){
    let finalUrlToHit = "\(kBaseUrl)\(kValidate_Customer_Number)\(urlType)"
    //\(Format.json.rawValue)"
    AlamoFireConnectivity.alamofireGetRequest(urlString: finalUrlToHit) { (data, error) in
      if data != nil{
        self.methodToHandelCustomerNumberSuccess(data: data!)
      }else{
        self.methodToHandelCustomerNumberfailure(error: error!)
      }
    }
  }
  func methodToHandelCustomerNumberSuccess(data:JSON) {
    //print(data)
    let status = data["Success"].stringValue
    if(status.lowercased() == "true"){
//      let data = data["data"].dictionary
//      let invitationCode = data!["InvitationCode"]?.dictionary
 //     let invitationCodeObject = InvitationCode.init(data: data)
 //     print(invitationCodeObject?.first_name)
      self.performSegue(withIdentifier: kSegue_SignUpNameEntry, sender: self)
    }else{
      self.showTheAlertViewWith(title: "Alert".localized(lang: languageCode, comment: ""), withMessage:data["Message"].stringValue, languageCode: languageCode)
    }
    
  }
  func methodToHandelCustomerNumberfailure(error:NSError?){
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

