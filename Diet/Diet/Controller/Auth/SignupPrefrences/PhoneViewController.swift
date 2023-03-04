//
//  PhoneViewController.swift
//  Diet
//
//  Created by Anish on 3/17/21.
//

import UIKit

class PhoneViewController: UIViewController {

    @IBOutlet weak var number: UITextField!
    
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
    

    @IBAction func next(_ sender: Any) {
        if number.text == "" {
            simpleAlert("Enter your phone number")
        }else {
            phonenumber = number.text!
        let vc = storyboard?.instantiateViewController(identifier: "payment") as! PaymentViewController
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
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
