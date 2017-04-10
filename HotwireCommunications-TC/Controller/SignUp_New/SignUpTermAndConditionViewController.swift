//
//  SignUpTermAndConditionViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 30/08/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class SignUpTermAndConditionViewController: BaseViewController,UITextViewDelegate {
    var languageCode:String!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var textViewTermsInfo: UITextView!
    @IBOutlet weak var btnGetStarted: UIButton!
    @IBOutlet weak var btnAlreadyHaveAccount: UIButton!
    @IBOutlet var lblPageHeader: UILabel!
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
        //SignUpTermAndCondition
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
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
 
    func viewUpdateContentOnBasesOfLanguage(){
        languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
        btnGetStarted.setTitle("GetStarted".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
        btnAlreadyHaveAccount.setTitle("AlreadyHaveAccount".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
        let signUpTermAndCondition = NSMutableAttributedString(string: "SignUpTermAndCondition".localized(lang: languageCode, comment: ""))
        signUpTermAndCondition.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Regular",size: 20.0)!, range: NSMakeRange(0, signUpTermAndCondition.length))
      //  signUpTermAndCondition.addAttributes( [NSParagraphStyleAttributeName: paragraphStyle], range: NSRange)
     
      
        signUpTermAndCondition.setAsLink(textToFind: "Privacy Policy", linkURL: "PrivacyPolicy")
      
        signUpTermAndCondition.setAsLink(textToFind: "Term of Use", linkURL: "TermOfUse")
      
      
        textViewTermsInfo.attributedText = signUpTermAndCondition
        textViewTermsInfo.textAlignment = NSTextAlignment.center
      
       lblPageHeader.text = "SignUpNow".localized(lang: languageCode, comment: "")
       self.automaticallyAdjustsScrollViewInsets = false
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

    @IBAction func getStartedButtonTappedAction(_ sender: AnyObject) {
      self.performSegue(withIdentifier: kSegue_chooseSignUpMethod, sender: self)  
        
    }
  /***********************************************************************************************************
   <Name> alreadyHaveAccountButtonTapped </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to action on already have button</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
    @IBAction func alreadyHaveAccountButtonTapped(_ sender: AnyObject) {
          cancelButtonTappedAction(sender as! UIButton)
        
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
        let popUpView = self.storyboard?.instantiateViewController(withIdentifier: "TermAndCondition") as! TermAndConditonPopUpViewController
        popUpView.termAndCondition = termAndCondition
        let navController = UINavigationController.init(rootViewController: popUpView)
        self.navigationController?.present(navController, animated: true, completion: nil)
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
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.title = "Back"
            if segue.identifier == kSegue_TermAndConditon {
              let popUpViewController = segue.destination as! TermAndConditonPopUpViewController
              popUpViewController.termAndCondition = true
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
