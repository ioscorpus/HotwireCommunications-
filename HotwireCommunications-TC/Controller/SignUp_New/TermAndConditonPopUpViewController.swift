//
//  TermAndConditonPopUpViewController.swift
//  HotwireCommunications
//
//  Created by pragya on 27/09/16.
//  Copyright © 2016 chetu. All rights reserved.
//

import UIKit
import SwiftyJSON

class TermAndConditonPopUpViewController: BaseViewController {
  var termAndCondition:Bool!
  var languageCode :String!
  var contentToShow:String!
  @IBOutlet var textView: UITextView!
  
   //MARK:- controller lyfecycle
  /***********************************************************************************************************
   <Name> viewDidLoad,viewWillAppear </Name>
   <Input Type>    </Input Type>
   <Return> void </Return>
   <Purpose> Uiview controller delegate methods</Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date> 27/09/16 </Date>
   </History>
   ***********************************************************************************************************/
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
//        self.tableView.estimatedRowHeight = 100 // for exvarle. Set your average height
//        self.tableView.rowHeight = UITableViewAutomaticDimension
        addBarButtonOnNavigationBar()
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
   <Date>  12/11/16 </Date>
   </History>
   ***********************************************************************************************************/
  
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    
    var viewTitle:String!
    if termAndCondition as Bool{
      viewTitle = "TermOfUse"
      webServiceCallingTermsOfService(languageCode: languageCode)
    }else{
      viewTitle = "PrivacyPolicy"
      webServiceCallingPrivacyPolicy(languageCode: languageCode)
    }
    self.title =  viewTitle.localized(lang: languageCode, comment: "")
    
  }
  /***********************************************************************************************************
   <Name> addBarButtonOnNavigationBar </Name>
   <Input Type> Url , and premeters </Input Type>
   <Return> void </Return>
   <Purpose> method to add done buton on navigation bar to dismiss popup </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  27/09/16 </Date>
   </History>
   ***********************************************************************************************************/
    func addBarButtonOnNavigationBar(){
        let btn1 = UIButton(frame:KFrame_CancelBarbutton )
        btn1.setTitle("Done", for: UIControlState.normal)
        btn1.addTarget(self, action: #selector(TermAndConditonPopUpViewController.DoneButtonTappedAction(_:)), for: .touchUpInside)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: btn1), animated: true);
  
    }
  //MARK:IBAction method
    func DoneButtonTappedAction(_ sender : UIButton){
       self.dismiss(animated: true, completion: {});
    }
  //MARK: Web services
  // privacy_policy  web service calling
  /***********************************************************************************************************
   <Name> webServiceCallingToVerifyCustomerNumber </Name>
   <Input Type> Url , and premeters </Input Type>
   <Return> void </Return>
   <Purpose> method to call a almofire web service method from alamofire connection class   </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  12/12/16 </Date>
   </History>
   ***********************************************************************************************************/
  func webServiceCallingPrivacyPolicy(languageCode:String){
    let finalUrlToHit = "\(kBaseUrl)\(kPrivacyPolicy)\(languageCode.uppercased())"
    //\(Format.json.rawValue)"
    AlamoFireConnectivity.alamofireGetRequest(urlString: finalUrlToHit) { (data, error) in
      if data != nil{
        self.methodToHandelPrivacyPolicySuccess(data: data!)
      }else{
        self.methodToHandelTermsOfServicefailure(error: error!)
      }
    }
  }
  func methodToHandelPrivacyPolicySuccess(data:JSON) {
    //print(data)
    let status = data["Success"].stringValue
    if(status.lowercased() == "true"){
     let dataValue = data["Data"].dictionary
     let privatePolicy = dataValue?["PP"]?.string
      print(privatePolicy!)
      contentToShow = privatePolicy
      textView.attributedText = privatePolicy?.utf8Data?.attributedString
      
    }else{
      self.showTheAlertViewWith(title: "Alert".localized(lang: languageCode, comment: ""), withMessage:data["Message"].stringValue, languageCode: languageCode)
    }
    
  }
  func methodToHandelPrivacyPolicyfailure(error:NSError?){
    if error != nil{
      if error?.code != 123{
        self.showTheAlertViewWith(title: "Alert".localized(lang: languageCode, comment: ""), withMessage:error!.description, languageCode: languageCode)
      }else{
        self.showTheAlertViewWith(title: (error?.localizedDescription)!, withMessage:(error?.localizedFailureReason)!, languageCode: languageCode)
      }
    }
  }
  
  // terms_of_service  web service calling
  /***********************************************************************************************************
   <Name> webServiceCallingToTermsOfService </Name>
   <Input Type> Url , and premeters </Input Type>
   <Return> void </Return>
   <Purpose> method to call a almofire web service method from alamofire connection class   </Purpose>
   <History>
   <Header> Version 1.0 </Header>
   <Date>  12/12/16 </Date>
   </History>
   ***********************************************************************************************************/
  func webServiceCallingTermsOfService(languageCode:String){
    let finalUrlToHit = "\(kBaseUrl)\(kTermsOfService)\(languageCode.uppercased())"
    //\(Format.json.rawValue)"
    AlamoFireConnectivity.alamofireGetRequest(urlString: finalUrlToHit) { (data, error) in
      if data != nil{
        self.methodToHandelTermsOfServiceSuccess(data: data!)
      }else{
        self.methodToHandelTermsOfServicefailure(error: error!)
      }
    }
  }
  
  func methodToHandelTermsOfServiceSuccess(data:JSON) {
    //print(data)
    let status = data["Success"].stringValue
    if(status.lowercased() == "true"){
      let dataValue = data["Data"].dictionary
      let termOfCondition = dataValue?["TOS"]?.string
      print(termOfCondition!)
      contentToShow = termOfCondition
      textView.attributedText = termOfCondition?.utf8Data?.attributedString
    }else{
      self.showTheAlertViewWith(title: "Alert".localized(lang: languageCode, comment: ""), withMessage:data["Message"].stringValue, languageCode: languageCode)
    }
    
  }
  func methodToHandelTermsOfServicefailure(error:NSError?){
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
    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
   <Date>  27/09/16 </Date>
   </History>
   ***********************************************************************************************************/
}
/*
extension TermAndConditonPopUpViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier_TermAndCondHeader) as! TermAndConditionHeaderTableViewCell
        var headerTitle:String!
        if termAndCondition as Bool{
         headerTitle = "TermOfUseCellTitle"
        }else{
         headerTitle = "PrivacyPolicyCellTitle"
        }
         headerCell.lblHeaderTitle.text = headerTitle.localized(lang: LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String, comment: "")
        return headerCell
    }
  func numberOfSections(in tableView: UITableView) -> Int {
     return 1
  }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier_TermAndCondRegular) as! TermAndConditionRegularTableViewCell
        cell.lblHeaderTitle.text = "Section \(indexPath.row + 1)"
        cell.textViewText.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum "
        return cell
    }
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  performSegue(withIdentifier: "nextPage", sender: self)
    }
}
*/
