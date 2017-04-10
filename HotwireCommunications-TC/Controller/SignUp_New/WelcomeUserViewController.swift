//
//  WelcomeUserViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 27/10/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class WelcomeUserViewController: BaseViewController {
   var languageCode:String!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var contentView: UIView!
  
  @IBOutlet var lblThanksUser: UILabel!
  @IBOutlet var lblUserInfoInfo: UILabel!
  @IBOutlet weak var btnGetStated: UIButton!
 // var userName:String = "John"
  // data object
   var createUserObject :CreateUser?
  
  //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 27/10/16 </Date>
   </History>
   ***********************************************************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
       addNotificationObserver()
      HotwireCommunicationApi.sharedInstance.createUserObject = createUserObject
        // Do any additional setup after loading the view.
    }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
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
   <Date>  27/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  func viewUpdateContentOnBasesOfLanguage(){
    self.navigationController?.navigationBar.isHidden = true
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    btnGetStated.setTitle("GetStarted".localized(lang: languageCode, comment: ""), for: UIControlState.normal) 
    lblThanksUser.text = "\("Hi".localized(lang: languageCode, comment: ""))  \(createUserObject!.first_name!) \(createUserObject!.last_name!).\n\("ThanksForCreatingAccount".localized(lang: languageCode, comment: ""))"
    lblUserInfoInfo.text = "ThanksForCreatingAccountInfo".localized(lang: languageCode, comment: "")
  
  }
  /***********************************************************************************************************
   <Name> configureViewProperty </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method to call to update view properties </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>   27/10/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  func configureViewProperty(){
    btnGetStated.backgroundColor = kColor_ContinuteUnselected
    btnGetStated.isSelected = true
  }
  
  //MARK: Iboulet methods
   @IBAction func btnGetStatedtappedAction(_ sender: AnyObject) {
     self.performSegue(withIdentifier: kSegue_PushNotificationActivation, sender: self)
  }
    // MARK: - Navigation
  /***********************************************************************************************************
   <Name> prepareForSegue </Name>
   <Input Type> UIStoryboardSegue,AnyObject </Input Type>
   <Return> void </Return>
   <Purpose> method call when segue called  </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  27/10/16 </Date>
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
   <Date>   27/10/16 </Date>
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
