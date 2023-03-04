//
//  GenderVC.swift
//  Diet
//
//  Created by Anish on 3/17/21.
//

import UIKit

class GenderVC: UIViewController {

    @IBOutlet weak var maleBtn: UIButton!
    
    @IBOutlet weak var femaleBtn: UIButton!
    
    var gender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func genderSelect(_ sender: UIButton) {
        if sender.tag == 1 {
            gender = "male"
            self.maleBtn.setImage(UIImage(named: "male1"), for: .normal)
            self.femaleBtn.setImage(UIImage(named: "female0"), for: .normal)
        }else if sender.tag == 2 {
            gender = "female"
            self.maleBtn.setImage(UIImage(named: "male0"), for: .normal)
            self.femaleBtn.setImage(UIImage(named: "female1"), for: .normal)
        }
    }
    
    @IBAction func next(_ sender: Any) {
        if gender == "" {
            simpleAlert("Select your gender")
        }else {
        let vc = storyboard?.instantiateViewController(identifier: "goal") as! YourGoalVC
        vc.gender = self.gender
        self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
