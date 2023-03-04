//
//  WelcomeVC.swift
//  Diet
//
//  Created by Anish on 3/17/21.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isUserLogin = UserDefaults.standard.bool(forKey: "userLogedIn")
        if (isUserLogin) {
            let vc = storyboard?.instantiateViewController(identifier: "CustomTabbarVC")
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    @IBAction func login(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "login")
        self.present(vc!, animated: true, completion: nil)
    }
    

}
