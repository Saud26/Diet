//
//  NameViewController.swift
//  Diet
//
//  Created by Anish on 3/17/21.
//

import UIKit

class NameViewController: UIViewController {

    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    var goal = ""
    var gender = ""
    var weight = ""
    var targatedWeight = ""
    var height = ""
    var dob = ""
    var haveTrainer = ""
    var phonenumber = ""
    var name = ""
    var first_Name = ""
    var last_Name = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func next(_ sender: Any) {
        if firstName.text == "" || lastName.text == ""{
            simpleAlert("Enter your full name")
        }else {
            name = "\(firstName.text!) \(lastName.text!)"
            first_Name = firstName.text!
            last_Name = lastName.text!
        let vc = storyboard?.instantiateViewController(identifier: "email") as! EmailViewController
            vc.goal = self.goal
            vc.gender = self.gender
            vc.weight = self.weight
            vc.targatedWeight = self.targatedWeight
            vc.height = self.height
            vc.dob = self.dob
            vc.haveTrainer = self.haveTrainer
            vc.phonenumber = self.phonenumber
            vc.name = self.name
            vc.firstName = self.first_Name
            vc.lastName = self.last_Name
        self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   

}
