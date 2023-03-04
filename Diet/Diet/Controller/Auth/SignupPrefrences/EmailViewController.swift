//
//  EmailViewController.swift
//  Diet
//
//  Created by Anish on 3/17/21.
//

import UIKit

class EmailViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    var goal = ""
    var gender = ""
    var weight = ""
    var targatedWeight = ""
    var height = ""
    var dob = ""
    var haveTrainer = ""
    var phonenumber = ""
    var name = ""
    var emailadd = ""
    var firstName = ""
    var lastName = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func next(_ sender: Any) {
        if email.text == "" {
            simpleAlert("Enter your email")
        }else {
            emailadd = email.text!
        let vc = storyboard?.instantiateViewController(identifier: "password") as! PasswordViewController
            vc.goal = self.goal
            vc.gender = self.gender
            vc.weight = self.weight
            vc.targatedWeight = self.targatedWeight
            vc.height = self.height
            vc.dob = self.dob
            vc.haveTrainer = self.haveTrainer
            vc.phonenumber = self.phonenumber
            vc.name = self.name
            vc.emailadd = self.emailadd
            vc.firstName = self.firstName
            vc.lastName = self.lastName
        self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
