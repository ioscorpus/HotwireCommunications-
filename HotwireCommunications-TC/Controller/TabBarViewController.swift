//
//  TabBarViewController.swift
//  HotwireCommunications-TC
//
//  Created by Chetu-macmini-26 on 09/06/16.
//  Copyright © 2016 Hotwire Communications. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController,UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  override func viewWillAppear(_ animated: Bool) {
    UITabBar.appearance().tintColor = kColor_TabBarSelected
    UITabBar.appearance().barTintColor = UIColor.white
    self.tabBar.isTranslucent = false
    super.viewWillAppear(animated)
   

  }
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
    
    
  }
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
    
    return true
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
