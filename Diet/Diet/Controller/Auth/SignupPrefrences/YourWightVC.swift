//
//  YourWightVC.swift
//  Diet
//
//  Created by Anish on 3/17/21.
//

import UIKit

class YourWightVC: UIViewController {

    
    @IBOutlet weak var weight1: UITextField!
    @IBOutlet weak var weight2: UITextField!
    
    
    var goal = ""
    var gender = ""
    var weight = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func next(_ sender: Any) {
        if weight1.text == "" || weight2.text == "" {
            simpleAlert("Select your weight")
        }else {
            weight = "\(weight1.text!)\(".")\(weight2.text!)"
        let vc = storyboard?.instantiateViewController(identifier: "tWeight") as! TargetWeightVC
            vc.goal = self.goal
            vc.gender = self.gender
            vc.weight = self.weight
        self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
