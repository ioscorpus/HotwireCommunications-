//
//  ChooseSignUpMethodViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 30/08/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class ChooseSignUpMethodViewController: BaseViewController {
 @IBOutlet var lblPageHeader: UILabel!
 @IBOutlet weak var btnNewCoustomer: UIButton!
 @IBOutlet weak var btnExistingCoustomer: UIButton!
 @IBOutlet weak var btnAlreadyHaveAccount: UIButton!
    var languageCode:String!
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
    lblPageHeader.text = "SignUpMethod".localized(lang: languageCode, comment: "")
        
    btnAlreadyHaveAccount.setTitle("AlreadyHaveAccount".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btnNewCoustomer.setTitle("NewCustomer".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
    btnExistingCoustomer.setTitle("ExistingCustomer".localized(lang: languageCode, comment: ""), for: UIControlState.normal)
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
    btn1.addTarget(self, action: #selector(ChooseSignUpMethodViewController.backButtonTappedAction(_:)), for: .touchUpInside)
    self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: btn1), animated: true);
  }
   func backButtonTappedAction(_ sender : UIButton){
     self.navigationController!.popViewController(animated: true)
   }
  
  //MARK:- IB button action 
  /***********************************************************************************************************
  <Name> newCustomerButtonTappedAction </Name>
  <Input Type>    </Input Type>
  <Return> void </Return>
  <Purpose> method execute when click on new coustomer button tapped</Purpose>
  <History>
  <Header> Version 1.0 </Header>
  <Date>  30/08/16 </Date>
  </History>
  ***********************************************************************************************************/
    @IBAction func newCustomerButtonTappedAction(_ sender: AnyObject) {
        self.performSegue(withIdentifier: kSegue_InstallationCode, sender: self)
        
    }
  /***********************************************************************************************************
   <Name> existingCustomerButtonTappedAction </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on existing coustomer button tapped</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
    @IBAction func existingCustomerButtonTappedAction(_ sender: AnyObject) {
        self.performSegue(withIdentifier: kSegue_CustomerNumber, sender: self)
        
    }
  /***********************************************************************************************************
   <Name> alreadyHaveAccountButtonTapped </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> method execute when click on already have button tapped</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  30/08/16 </Date>
   </History>
   ***********************************************************************************************************/
    @IBAction func alreadyHaveAccountButtonTapped(_ sender: AnyObject) {
        cancelButtonTappedAction(sender as! UIButton)
        
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
 
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.title = "Back"
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
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
    //MARK:- ADD notification
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

