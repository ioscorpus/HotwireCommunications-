//
//  TabBarBaseViewController.swift
//  HotwireCommunications
//
//  Created by Chetu-macmini-26 on 07/11/16.
//  Copyright © 2016 chetu. All rights reserved.
//

import UIKit

class TabBarBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      let storyboard = UIStoryboard(name: kStoryBoardMain, bundle: nil)
    //  let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
      let initialViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarViewController
       initialViewController.selectedIndex = 0
       addChildViewController(initialViewController)
       initialViewController.view.frame = self.view.frame
      view.addSubview(initialViewController.view)
      initialViewController.didMove(toParentViewController: self)
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
