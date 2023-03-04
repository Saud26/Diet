//
//  TargetWeightVC.swift
//  Diet
//
//  Created by Anish on 3/17/21.
//

import UIKit

class TargetWeightVC: UIViewController {

    @IBOutlet weak var weight1: UITextField!
    @IBOutlet weak var weight2: UITextField!
    
    var goal = ""
    var gender = ""
    var weight = ""
    var targatedWeight = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func next(_ sender: Any) {
        if weight1.text == "" || weight2.text == "" {
            simpleAlert("Select your targated weight")
        }else {
            targatedWeight = "\(weight1.text!)\(".")\(weight2.text!)"
        let vc = storyboard?.instantiateViewController(identifier: "height") as! HeightVC
            vc.goal = self.goal
            vc.gender = self.gender
            vc.weight = self.weight
            vc.targatedWeight = self.targatedWeight
        self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
