
//
//  ConfirmPhoneNumberViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 26/10/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class ConfirmPhoneNumberViewController: BaseViewController {
  var languageCode:String!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var contentView: UIView!

  @IBOutlet var lblWeAreCalling: UILabel!
  @IBOutlet var lblConfirmPhoNumberInfo: UILabel!
  @IBOutlet var lblSecurityCode: UILabel!
  @IBOutlet var btnCallMeAgain: UIButton!
  @IBOutlet var btnChangeMobileNumber: UIButton!
  @IBOutlet var btnTextMeInstead: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
       addNotificationObserver()
       configureViewProperty()
        // Do any additional setup after loading the view.
    }
  override func viewWillAppear(_ animated: Bool) {
     viewUpdateContentOnBasesOfLanguage()
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
   <Date>  26/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
  
      self.navigationItem.title =  "ConfirmPhoneNumber".localized(lang: languageCode, comment: "")
    
    lblWeAreCalling.text = "WeAreCalling".localized(lang: languageCode, comment: "")
    lblConfirmPhoNumberInfo.text = "EnterSecurityCode".localized(lang: languageCode, comment: "")
    lblSecurityCode.text = "700 943"
    
    btnCallMeAgain.setTitle("CallMeAgain".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btnChangeMobileNumber.setTitle("ChangeMobileNumber".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btnTextMeInstead.setTitle( "TextMeInstead".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    
  }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  26/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  
  func configureViewProperty(){
    btnCallMeAgain.layer.borderColor = kColor_SignUpbutton.cgColor
    btnCallMeAgain.setTitleColor(kColor_SignUpbutton, for: UIControlState.normal)
    btnChangeMobileNumber.layer.borderColor = kColor_SignUpbutton.cgColor
    btnChangeMobileNumber.setTitleColor(kColor_SignUpbutton, for: UIControlState.normal)
    btnTextMeInstead.layer.borderColor = kColor_SignUpbutton.cgColor
    btnTextMeInstead.setTitleColor(kColor_SignUpbutton, for: UIControlState.normal)
   
  }
  
   // MARK: - IBOutlet Action
  /***********************************************************************************************************
   <Name> callMeAgainButtoonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on CallMeAgain button</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 26/10/16. </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func callMeAgainButtoonTappedAction(_ sender: AnyObject) {
    
    
  }
  /***********************************************************************************************************
   <Name> changeMobileNumberButtoonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on changeMobileNumber button</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 26/10/16. </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func changeMobileNumberButtoonTappedAction(_ sender: AnyObject) {
    let popUpView = self.storyboard?.instantiateViewController(withIdentifier: kStoryBoardID_PhoneNoVarification) as! SignUpEnterMobNoViewController
   // popUpView.varificationMode = true
    popUpView.flowType = FlowType.Login
    let navController = UINavigationController.init(rootViewController: popUpView)
    self.navigationController?.present(navController, animated: true, completion: nil)
    
  }
  /***********************************************************************************************************
   <Name> textMeInsteadButtoonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on textMeInstead button</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 26/10/16. </Date>
   </History>
   ***********************************************************************************************************/
  @IBAction func textMeInsteadButtoonTappedAction(_ sender: AnyObject) {
    let alertTitle = "CodeSendTitle".localized(lang: languageCode, comment: "")
    let alertbody = "CodeSendOnMobileBody".localized(lang: languageCode, comment: "")
    let alert = UIAlertController(title: alertTitle, message: alertbody, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok".localized(lang: languageCode, comment: "Call us Now"), style: .default , handler:{ (UIAlertAction)in
      self.dismiss(animated: true, completion: {});
    }))
    self.present(alert, animated: true, completion: {
      print("completion block")
    })
    
  }

  
    // MARK: - Navigation
  /***********************************************************************************************************
   <Name> prepareForSegue </Name>
   <Input Type> UIStoryboardSegue,AnyObject </Input Type>
   <Return> void </Return>
   <Purpose> method call when segue called  </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  26/10/16 </Date>
   </History>
   ***********************************************************************************************************/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
   <Date>   26/10/16 </Date>
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
