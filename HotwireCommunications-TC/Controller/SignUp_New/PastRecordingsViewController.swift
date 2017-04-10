


import UIKit

class PastRecordingsViewController: UIViewController , UITableViewDataSource , UITableViewDelegate ,UIGestureRecognizerDelegate  {
    
   
    
    @IBOutlet weak var pastRecordingTableView: UITableView!
    
    @IBOutlet weak var dVRSpaceDetailView: UIView!
    @IBOutlet weak var dVRSpaceLabel: UILabel!
    @IBOutlet weak var dVRprogressView: UIProgressView!
    @IBOutlet weak var dVRValueLabel: UILabel!
    
    var selectedIndex : NSInteger! = -1
    let dVRBoxList:[String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","15","16","17","18","19","20","21","22"]
    var indexVal : NSInteger = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Past Recordings".localized(lang: LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE as String, comment: "")
        
         let cell = pastRecordingTableView.dequeueReusableCell(withIdentifier:"PastRecdTableViewCell") as! PastRecdTableViewCell
        
        var rect :CGRect = cell.detailsView.frame
        
        rect.size.height = 0.0
        
        
        cell.detailsView.frame = rect

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dVRSpaceDetailView.backgroundColor = kColor_DVRSpacebackground
        self.dVRprogressView.transform = CGAffineTransform.init(scaleX: 1.0, y: 10.0)
        self.dVRprogressView.setProgress(0.70, animated:false)
        self.dVRprogressView.tintColor = kColor_TabBarSelected
        self.dVRprogressView.trackTintColor = kColor_NavigationBarColor
   /*     let cell = pastRecordingTableView.dequeueReusableCell(withIdentifier:"PastRecdTableViewCell") as! PastRecdTableViewCell
       // cell.deleteViewWidthConstraints.constant = 0.0
       // cell.deleteViewHeightConstraints.constant = 0.0
        cell.topSpaceConstraint.constant = 0.0
        cell.titleHeightConstraint.constant = 0.0
        cell.recordedHeightCon.constant = 0.0
        cell.recordWidthConstraint.constant = 0.0
        cell.dateHeightConstraint.constant = 0.0
        
        cell.detailBtnConstr.constant = 0.0
        cell.detailBtnHeightConstr.constant = 0.0
        cell.descrptionConstr.constant = 0.0
        
    cell.detailsView.removeFromSuperview()
        */
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    @IBAction func DeleteButton(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func OptionButton(_ sender: UIButton) {
        
        let DetailsController = self.storyboard?.instantiateViewController(withIdentifier: "PastRecordingDetailsController") as! PastRecordingDetailsController
        self.navigationController?.pushViewController(DetailsController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        

        let count: Int = dVRBoxList.count
        let scount:Double = Double(count%3)
        var intCount:Int = count/3
        if scount == 0 {
            
            return intCount
        }
        
        intCount = intCount + 1;
        return intCount

        
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"PastRecdTableViewCell") as! PastRecdTableViewCell
        
        var rect :CGRect = cell.detailsView.frame
        
        rect.size.height = 0.0
        
        
        cell.detailsView.frame = rect

//        cell.firstImage.isUserInteractionEnabled = true
//        cell.secondImage.isUserInteractionEnabled = true
//        cell.thirdImage.isUserInteractionEnabled = true
        
      for i in 0..<3{
        if indexVal < dVRBoxList.count{
           
            
            if i == 0{
             //   let firstImgTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
             //   cell.firstImage.addGestureRecognizer(firstImgTapGesture)
                
                 print("\(dVRBoxList[indexVal]) ++++ index path \(indexPath.row)")
            }else if i == 1{
              //  let secondImgTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
              //  cell.secondImage.addGestureRecognizer(secondImgTapGesture)
                
                 print("\(dVRBoxList[indexVal]) ++++ index path \(indexPath.row)")
            }else{
               // let thirdimgTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
              //  cell.thirdImage.addGestureRecognizer(thirdimgTapGesture)

                 print("\(dVRBoxList[indexVal]) ++++ index path \(indexPath.row)")
            }
            
            
        }
        indexVal += 1

        }


        return cell
    
    }
   

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           let cell = tableView.dequeueReusableCell(withIdentifier:"PastRecdTableViewCell") as! PastRecdTableViewCell
        print("indexPath.row : \(indexPath.row) ====== selectedIndex : \(selectedIndex)")
//        tableView.beginUpdates()
//        tableView.endUpdates()
        
        if indexPath.row == selectedIndex
        {
          //  cell.deleteViewWidthConstraints.constant = 101.0
           // cell.deleteViewHeightConstraints.constant = 81.0
              cell.topSpaceConstraint.constant = 11.0
            var rect :CGRect = cell.detailsView.frame
            
            rect.size.height = 200.0
            
            
            cell.detailsView.frame = rect
            return 400
        }else{
            //cell.deleteViewWidthConstraints.constant = 0.0
            //cell.deleteViewHeightConstraints.constant = 0.0
              cell.topSpaceConstraint.constant = 0.0
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == selectedIndex{
            selectedIndex = -1
        }else{
            selectedIndex = indexPath.row
        }
        tableView.reloadData()
    }
    
    
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        
        if let imgTap = sender.view as? UIImageView {
            print("Tag Value == \(imgTap.tag)")// data popoulate purpose
            
            
//            let tapLocation = sender.location(in: imgTap)
//            let tapIndexPath = self.pastRecordingTableView.indexPathForRow(at: tapLocation)
//            
//            if tapIndexPath?.row == selectedIndex {
//                selectedIndex = -1
//            }else{
//                selectedIndex = tapIndexPath?.row
//            }
//            self.pastRecordingTableView.reloadData()
//            print("tapIndexPath = =\(tapIndexPath?.row)")
           
       }
       

    }
    
}
