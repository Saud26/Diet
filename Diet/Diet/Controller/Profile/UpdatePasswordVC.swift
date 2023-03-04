//
//  UpdatePasswordVC.swift
//  Diet
//
//  Created by Anish on 5/20/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class UpdatePasswordVC: UIViewController {

    @IBOutlet weak var currentPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updatePass(_ sender: Any) {
        if currentPass.text == "" || newPass.text == "" || confirmPass.text == "" {
            simpleAlert("Fill all the fields")
        }else if newPass.text != confirmPass.text {
            simpleAlert("Password does not match")
        }else if newPass.text!.count < 8 {
            simpleAlert("Invalid password! must be 8 characters long")
        }
        else {
            updatePass(sessionId: SESSION_ID, oldPass: currentPass.text!, newPass: newPass.text!, confirmPass: confirmPass.text!)
        }
    }
    
}
extension UpdatePasswordVC {
    
    func updatePass(sessionId:String,oldPass:String,newPass:String,confirmPass:String) {
        let params = ["session_id":sessionId,"current_password":oldPass,"new_password":newPass,"confirm_password":confirmPass]
        Alamofire.request(BASE_URL+"updateUserPassword", method: .post, parameters: params).responseJSON { (response) in
            if response.result.isSuccess{
                let res : JSON = JSON(response.result.value!)
                print(res)
                self.simpleAlert("Password Updated")
                self.currentPass.text = ""
                self.newPass.text = ""
                self.confirmPass.text = ""
            }
        }
    }
}
