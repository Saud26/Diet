//
//  DOBViewController.swift
//  Diet
//
//  Created by Anish on 3/17/21.
//

import UIKit

class DOBViewController: UIViewController {

    @IBOutlet weak var day: UITextField!
    @IBOutlet weak var month: UITextField!
    @IBOutlet weak var year: UITextField!
    
    
    
    var goal = ""
    var gender = ""
    var weight = ""
    var targatedWeight = ""
    var height = ""
    var dob = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func next(_ sender: Any) {
        if day.text == "" || month.text == "" || year.text == ""{
            simpleAlert("Select your date of birth")
        }else {
            dob = "\(day.text!)\(" ")\(month.text!)\(" ")\(year.text!)"
        let vc = storyboard?.instantiateViewController(identifier: "trainer") as! HaveTrainerViewController
            vc.goal = self.goal
            vc.gender = self.gender
            vc.weight = self.weight
            vc.targatedWeight = self.targatedWeight
            vc.height = self.height
            vc.dob = self.dob
        self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
