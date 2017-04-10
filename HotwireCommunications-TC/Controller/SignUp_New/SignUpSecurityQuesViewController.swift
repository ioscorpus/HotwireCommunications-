//
//  SignUpSecurityQuesViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 04/10/16.
//  Copyright © 2016 chetu. All rights reserved.
//

import UIKit

class SignUpSecurityQuesViewController: BaseViewController {
   var languageCode:String!
  @IBOutlet var tableView: UITableView!
  @IBOutlet var lblAboutSecurityQuesInfo: UILabel!
  var headerReuseIdentifier = kCellIdentifier_SecurityHeader
  var cellReuseIdentifier = kCellIdentifier_SecurityQues
  var selectedQuesKey:String!
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
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  //MARK:- Refresh view
  func viewUpdateContentOnBasesOfLanguage(){
    languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    self.navigationItem.title =  "SignUp".localized(languageCode, comment: "")
    lblAboutSecurityQuesInfo.text = "SecurityQuestionInfoText".localized(languageCode, comment: "")
    tableView.reloadData()
  }
  func configureViewProperty(){
  
    
  }
  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    self.title = "Back"
    if segue.identifier == kSegue_SecurityAns {
      let nextViewController = segue.destinationViewController as! SignupEnterSecurityAnsViewController
        nextViewController.viewTitleKey = selectedQuesKey
    }
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
extension SignUpSecurityQuesViewController: UITableViewDelegate,UITableViewDataSource {
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let  headerCell = tableView.dequeueReusableCellWithIdentifier(headerReuseIdentifier) as! SecurityQuestionHeaderTableViewCell
    headerCell.lblHeaderTitle.text = "SelectSecurityQuest".localized(languageCode, comment: "")
    return headerCell
  }
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return kSecurityQuesList.count
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as! SecurityQuesTableViewCell
    cell.lblTitleText.text = kSecurityQuesList[indexPath.row].localized(languageCode, comment: "")
       return cell
  }
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 40
  }
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    selectedQuesKey = kSecurityQuesList[indexPath.row]
    performSegueWithIdentifier(kSegue_SecurityAns, sender: self)
  }
}
