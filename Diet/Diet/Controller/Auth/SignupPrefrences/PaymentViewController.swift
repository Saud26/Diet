//
//  PaymentViewController.swift
//  Diet
//
//  Created by Anish on 3/17/21.
//

import UIKit

class PaymentViewController: UIViewController {

    var goal = ""
    var gender = ""
    var weight = ""
    var targatedWeight = ""
    var height = ""
    var dob = ""
    var haveTrainer = ""
    var phonenumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btn1(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "name") as! NameViewController
        vc.goal = self.goal
        vc.gender = self.gender
        vc.weight = self.weight
        vc.targatedWeight = self.targatedWeight
        vc.height = self.height
        vc.dob = self.dob
        vc.haveTrainer = self.haveTrainer
        vc.phonenumber = self.phonenumber
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btn2(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "name") as! NameViewController
        vc.goal = self.goal
        vc.gender = self.gender
        vc.weight = self.weight
        vc.targatedWeight = self.targatedWeight
        vc.height = self.height
        vc.dob = self.dob
        vc.haveTrainer = self.haveTrainer
        vc.phonenumber = self.phonenumber
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
