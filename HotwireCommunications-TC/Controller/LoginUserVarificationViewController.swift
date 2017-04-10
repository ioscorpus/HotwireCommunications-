//
//  LoginUserVarificationViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 02/11/16.
//   Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class LoginUserVarificationViewController: BaseViewController ,UITextViewDelegate{
  var languageCode:String!
  @IBOutlet weak var imageViewLogo: UIImageView!
  @IBOutlet var lblPageWelcomeHeader: UILabel!
  @IBOutlet var lblPageWelcomeInfo: UILabel!
  @IBOutlet weak var textViewTermsInfo: UITextView!
  @IBOutlet weak var btnGetStarted: UIButton!
  var userName:String = "John"
  //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 02/11/16</Date>
   </History>
   ***********************************************************************************************************/

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewProperty()
        // Do any additional setup after loading the view.
    }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = true
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
   <Date>  02/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    lblPageWelcomeHeader.text = "\("Hi".localized(lang: languageCode, comment: ""))  \(userName)."

    lblPageWelcomeInfo.text = "WelcomeInfoText".localized(lang: languageCode, comment: "")
    
    let signUpTermAndCondition = NSMutableAttributedString(string: "WelcomeTermAndCondition".localized(lang: languageCode, comment: ""))
    signUpTermAndCondition.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Regular",size: 18.0)!, range: NSMakeRange(0, signUpTermAndCondition.length))
    //  signUpTermAndCondition.addAttributes( [NSParagraphStyleAttributeName: paragraphStyle], range: NSRange)
    signUpTermAndCondition.setAsLink(textToFind: "Privacy Policy", linkURL: "PrivacyPolicy")
    //setAsLink(textToFind: "Privacy Policy", linkURL: "PrivacyPolicy")
    signUpTermAndCondition.setAsLink(textToFind: "Terms of Use", linkURL: "TermOfUse")
    textViewTermsInfo.attributedText = signUpTermAndCondition
    textViewTermsInfo.textAlignment = NSTextAlignment.center
    
    btnGetStarted.setTitle("GetStarted".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    self.automaticallyAdjustsScrollViewInsets = false
  }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  02/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  func configureViewProperty(){
    
    
  }
  //MARK:- IB button action
  /***********************************************************************************************************
   <Name> getStartedButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on started button</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  
  @IBAction func getStartedButtonTappedAction(_ sender: Any) {
    let storyboard = UIStoryboard(name:kStoryBoardSignUp, bundle: nil)
    let mainViewController = storyboard.instantiateViewController( withIdentifier: kStoryBoardID_PushNotification) as! ActivatePushNotificationViewController
    mainViewController.login = true
    self.navigationController?.pushViewController(mainViewController, animated: true)
  }
  //MARK:-Textview delegate method
  /***********************************************************************************************************
   <Name> shouldInteractWithURL </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Textfield delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
  
 func textView(_ textView: UITextView, shouldInteractWith url: URL, in characterRange: NSRange) -> Bool{
    var termAndCondition:Bool!
    if url == URL(string: "TermOfUse"){
      //      self.performSegueWithIdentifier(kSegue_TermAndConditon, sender: self)
      termAndCondition = true
    }else if url == URL(string: "PrivacyPolicy"){
      termAndCondition = false
      //   self.performSegueWithIdentifier(kSegue_TermAndConditon, sender: self)
    }
    print(termAndCondition)
//    let popUpView = self.storyboard?.instantiateViewControllerWithIdentifier("TermAndCondition") as! TermAndConditonPopUpViewController
//    popUpView.termAndCondition = termAndCondition
//    let navController = UINavigationController.init(rootViewController: popUpView)
//    self.navigationController?.presentViewController(navController, animated: true, completion: nil)
    return true
  }
  
  // MARK: - Navigation
  /***********************************************************************************************************
   <Name> prepareForSegue </Name>
   <Input Type> UIStoryboardSegue,AnyObject </Input Type>
   <Return> void </Return>
   <Purpose> method call when segue called  </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  02/11/16 </Date>
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
   <Date>  02/11/16 </Date>
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
