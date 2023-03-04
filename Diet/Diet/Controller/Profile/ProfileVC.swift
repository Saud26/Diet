//
//  ProfileVC.swift
//  Diet
//
//  Created by Anish on 5/20/21.
//

import UIKit
import GoogleSignIn
import FacebookLogin
import FacebookCore
import Alamofire
import SwiftyJSON
import KRProgressHUD

class ProfileVC: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var completedSession: UILabel!
    @IBOutlet weak var goal: UILabel!
    @IBOutlet weak var challenges: UILabel!
    @IBOutlet weak var plans: UILabel!
    @IBOutlet weak var trainerName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.name.text = "\(user[0].first_name) \(user[0].last_name)"
       
        self.trainerName.text = user[0].trainer_name
        for item in user[0].trainings {
            self.goal.text = item.name
        }
        self.plans.text = "\(user[0].trainingPlan.count)"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let fName =  UserDefaults.standard.object(forKey: "firstName") {
            if let lName =  UserDefaults.standard.object(forKey: "lastName") {
                let a = fName as! String
                let b = lName as! String
                name.text = "\(a) \(b)"
            }
        }
        
     
        if let emails =  UserDefaults.standard.object(forKey: "email") {
            email.text = (emails as! String)
        }
        if let proPic =  UserDefaults.standard.object(forKey: "profilePic") {
            if let url = URL(string: proPic as! String){
                profilePicture.sd_setImage(with: url, completed: nil)
            }
        }
    }
    
    @IBAction func yourOder(_ sender: Any) {
    }
    @IBAction func generalSharing(_ sender: Any) {
      //  let appImage = UIImage(named:"")
        let myUrl = "HERBAPKA"
        let appLink = "HERBAPKA"
        
        let vc = UIActivityViewController(activityItems: [myUrl,appLink], applicationActivities: [])
        present(vc, animated: true)
    }
    
    @IBAction func home(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "CustomTabbarVC") as! CustomTabbarVC
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func updateProfile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "updateProfile")
        self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func resetPass(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "updatePassword")
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "firstName")
        UserDefaults.standard.removeObject(forKey: "lastName")
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "profilePic")
        UserDefaults.standard.removeObject(forKey: "sessionId")
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.set(false, forKey: "userLogedIn")
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "welcome") as! WelcomeVC
        UIApplication.shared.windows.first?.rootViewController = redViewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @IBAction func google(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func faceBook(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, let accessToken):
                let token = accessToken
                print("Logged in!", token)
                //self.strLogin = "2"
                self.getUserProfile()
            }
        }

    }
    
}
//MARK:- Google SignIn Delegates
extension ProfileVC : GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            
            print("Gmail login success")
            print(user!)
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let name = user.profile.name
            let email = user.profile.email
            let userImageURL = user.profile.imageURL(withDimension: 200)
            // ...
            print(userImageURL!)
            print(userId!)
            print(idToken!)
            print(name!)
            print(email!)
            updateSocialLogin(userName: EMAIL, tokenId: idToken!, provider: "google")
        }
    }
    //facebook
    func getUserProfile () {
        let connection = GraphRequestConnection()
        var type = ""
        var email1 = ""
        var name1 = ""
        var img1 = ""
        var fbId = ""
        var facebookToken =
        connection.add(GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email, first_name, last_name, picture.type(large),birthday, location{location{country, country_code}}"])) { (httpResponse, result, error) in
            print("result == ", result!)
            print("httpResponse == ", httpResponse!)
            let resposne = result as! NSDictionary
            if error == nil
            {
            
                if let picture = resposne.value(forKey: "picture") as? NSDictionary
                {
                    if let data = picture.value(forKey: "data") as? NSDictionary
                    {
                        if let url = data.value(forKey: "url") as? String
                        {
                            img1 = url
                            print("URL :=> \(url)")
                        }
                    }
                }
                
                if let id = resposne.value(forKey: "id") as? String
                {
                    print("ID :=> \(id)")
                    fbId = id
                }
                if let email = resposne.value(forKey: "email") as? String
                {
                    email1 = email
                    print("EMAIL :=> \(email)")
                }
                if let first_name = resposne.value(forKey: "first_name") as? String
                {
                    name1 = first_name
                    print("FIRST_NAME :=> \(first_name)")
                }
                if let last_name = resposne.value(forKey: "last_name") as? String
                {
                    name1 += last_name
                    print("LAST_NAME :=> \(last_name)")
                }
                self.updateSocialLogin(userName: EMAIL, tokenId: fbId, provider: "facebook")
              //  self.signIn(type: "3", email: email1, image: img1, name: name1)
            }
            else{
                print("Graph Request Failed: \(error!.localizedDescription)")
            }
        }
        connection.start()
    }
    func updateSocialLogin(userName:String,tokenId:String,provider:String){
        let params = ["email":userName,"tokenid":tokenId,"baseprovider":provider]
        Alamofire.request("https://digitalech.com/dietApp/api/userSocialLogin", method: .post, parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                let res : JSON = JSON(response.result.value!)
                print(res)
                /*
                 {
                   "error" : "1",
                   "message" : "Invalid email\/phone or password"
                 }
                 */
            }
        }
    }

}
