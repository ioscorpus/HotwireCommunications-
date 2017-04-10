//
//  RemoteViewController.swift
//  HotwireCommunications
//
//  Created by Dev on 31/03/17.
//  Copyright © 2017 chetu. All rights reserved.
//

import UIKit

class RemoteViewController: UIViewController {

    @IBOutlet var keyBoardView: UIView!
    @IBOutlet weak var keyBoardButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let scrollHeight:CGFloat = self.scrollView.frame.size.height
        let scrollWidth:CGFloat = self.scrollView.frame.size.width
        
        print("scrollHeight:\(scrollHeight)")
        print("scrollWidth:\(scrollWidth)")
        
       
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height:1700)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickCloseButton(_ sender: UIButton) {
        
        print("clickCloseButton")
       self.dismiss(animated: true, completion: nil)
    }

   
    @IBAction func clickKeyoardButton(_ sender: Any) {
        
        if keyBoardView.isHidden == true {
            
             self.keyBoardView.isHidden = false
             self.keyBoardButton.setImage(UIImage(named: "RM_Keybord_ON")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }else
        {
             self.keyBoardView.isHidden = true
             self.keyBoardButton.setImage(UIImage(named: "RM_Keybord_OFF")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        
    }

}
