//
//  HeightVC.swift
//  Diet
//
//  Created by Anish on 3/17/21.
//

import UIKit

class HeightVC: UIViewController {

    
    @IBOutlet weak var feet: UITextField!
    @IBOutlet weak var inches: UITextField!
    
    var goal = ""
    var gender = ""
    var weight = ""
    var targatedWeight = ""
    var height = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func next(_ sender: Any) {
        if feet.text == "" || inches.text == "" {
            simpleAlert("Select your height")
        }else {
            height = "\(feet.text!)\(".")\(inches.text!)"
        let vc = storyboard?.instantiateViewController(identifier: "dob") as! DOBViewController
            vc.goal = self.goal
            vc.gender = self.gender
            vc.weight = self.weight
            vc.targatedWeight = self.targatedWeight
            vc.height = self.height
        self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
