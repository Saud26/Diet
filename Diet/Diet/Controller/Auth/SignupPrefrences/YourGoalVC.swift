//
//  YourGoalVC.swift
//  Diet
//
//  Created by Anish on 3/17/21.
//

import UIKit

class YourGoalVC: UIViewController {

    
    
    @IBOutlet weak var looseWightBtn: UIButton!
    @IBOutlet weak var eatHealthyBtn: UIButton!
    @IBOutlet weak var buildMuscleBtn: UIButton!
    
    
    var gender = ""
    var goal = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selection(_ sender: UIButton) {
        if sender.tag == 1 {
            goal = "1"
            looseWightBtn.setImage(UIImage(named: "2active"), for: .normal)
            eatHealthyBtn.setImage(UIImage(named: "3"), for: .normal)
            buildMuscleBtn.setImage(UIImage(named: "1"), for: .normal)
        }else if sender.tag == 2 {
            goal = "2"
            looseWightBtn.setImage(UIImage(named: "2"), for: .normal)
            eatHealthyBtn.setImage(UIImage(named: "3active"), for: .normal)
            buildMuscleBtn.setImage(UIImage(named: "1"), for: .normal)
        }else if sender.tag == 3 {
            goal = "3"
            looseWightBtn.setImage(UIImage(named: "2"), for: .normal)
            eatHealthyBtn.setImage(UIImage(named: "3"), for: .normal)
            buildMuscleBtn.setImage(UIImage(named: "1active"), for: .normal)
        }
    }
    
    
    
    
    
    @IBAction func next(_ sender: Any) {
        if goal == "" {
            simpleAlert("Select your goal")
        }else {
        let vc = storyboard?.instantiateViewController(identifier: "weight") as! YourWightVC
            vc.goal = self.goal
            vc.gender = self.gender
        self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
 

}
