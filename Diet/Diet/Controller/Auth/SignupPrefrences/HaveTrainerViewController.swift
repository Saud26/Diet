//
//  HaveTrainerViewController.swift
//  Diet
//
//  Created by Anish on 3/17/21.
//

import UIKit

class HaveTrainerViewController: UIViewController {

    var goal = ""
    var gender = ""
    var weight = ""
    var targatedWeight = ""
    var height = ""
    var dob = ""
    var haveTrainer = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func yes(_ sender: Any) {
        self.haveTrainer = "yes"
        let vc = storyboard?.instantiateViewController(identifier: "phone") as! PhoneViewController
        vc.goal = self.goal
        vc.gender = self.gender
        vc.weight = self.weight
        vc.targatedWeight = self.targatedWeight
        vc.height = self.height
        vc.dob = self.dob
        vc.haveTrainer = self.haveTrainer
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func no(_ sender: Any) {
        self.haveTrainer = "no"
        let vc = storyboard?.instantiateViewController(identifier: "phone") as! PhoneViewController
        vc.goal = self.goal
        vc.gender = self.gender
        vc.weight = self.weight
        vc.targatedWeight = self.targatedWeight
        vc.height = self.height
        vc.dob = self.dob
        vc.haveTrainer = self.haveTrainer
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
