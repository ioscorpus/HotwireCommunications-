//
//  CommunityViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 05/09/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class CommunityViewController: BaseViewController {
   let headerTitle = "MY_INTERNET_SERVICE"
  let listArray = ["Check_My_Email", "Speed_Test","VPN_Connection","Upgrade_Internet_Service"]
  @IBOutlet var topImageView: UIImageView!
  @IBOutlet var tableView: UITableView!
  var headerReuseIdentifier = "HeaderCell"
  var cellReuseIdentifier = "RegularCell"
  var languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String
    override func viewDidLoad() {
        super.viewDidLoad()
       setUpLeftImageOnNavigationBar()
      tableView.delegate = self
      tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.title = "Community".localized(lang: LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String, comment: "")
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
// MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
 // MARK: - Tableview delegate and data source
extension CommunityViewController: UITableViewDelegate,UITableViewDataSource {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let  headerCell = tableView.dequeueReusableCell(withIdentifier: headerReuseIdentifier) as! HeaderTableViewCell
    headerCell.lblHeaderTitle.text = headerTitle.localized(lang: LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String, comment: "")
    return headerCell
  }
  func numberOfSections(in tableView: UITableView) -> Int {
     return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listArray.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! HomeBasicTableViewCell
    cell.lblHeaderTitle.text = listArray[indexPath.row].localized(lang: LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String, comment: "")
    cell.lblDetailText?.text = ""
    return cell
  }
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 25
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return 55
  }
}
