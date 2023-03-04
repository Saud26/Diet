//
//  ViewController.swift
//  Diet
//
//  Created by Anish on 1/27/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD
import GoogleSignIn
import FacebookLogin
import FacebookCore

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtn(_ sender: Any) {
        if email.text == "" || password.text == "" {
            simpleAlert("email or password is missing")
        }else if !isValidEmail(testStr: email.text!) {
            simpleAlert("wrong email")
        }else {
            signIn(email: email.text!, password: password.text!)
        }
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
extension ViewController : GIDSignInDelegate {
    
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
            checkSocialLogins(userName: email!, tokenId: idToken!)
        }
    }
    //facebook
    func getUserProfile () {
        let connection = GraphRequestConnection()
        var type = ""
        var email1 = ""
        var name1 = ""
        var img1 = ""
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
                
              //  self.signIn(type: "3", email: email1, image: img1, name: name1)
            }
            else{
                print("Graph Request Failed: \(error!.localizedDescription)")
            }
        }
        connection.start()
    }
}
extension ViewController {
    
    func signIn(email:String,password:String) {
        KRProgressHUD.show()
        let params = ["username":email,"password":password,"user_type":"user"]
        Alamofire.request(BASE_URL+"userLogin", method: .post, parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                let result : JSON = JSON(response.result.value!)
                print(result)
               self.parseResults(json: result)
            }
        }
    }
    func parseResults(json:JSON){
        let first_name = json["first_name"].string ?? ""
        let current_weight = json["current_weight"].string ?? ""
        let phone = json["phone"].string ?? ""
        let gender = json["gender"].string ?? ""
        let user_id = json["user_id"].string ?? ""
        let height = json["height"].string ?? ""
        let birth_date = json["birth_date"].string ?? ""
        let client_type = json["client_type"].string ?? ""
        let username = json["username"].string ?? ""
        let package_id = json["package_id"].string ?? ""
        let html = json["html"].string ?? ""
        let last_name = json["last_name"].string ?? ""
        let plan_id = json["plan_id"].string ?? ""
        let created_by = json["created_by"].string ?? ""
        let email  = json["email"].string ?? ""
        let targeted_weight  = json["targeted_weight"].string ?? ""
        let profile_image = json["profile_image"].string ?? ""
        let custom_session_id  = json["custom_session_id"].string ?? ""
        let trainer_name  = json["trainer_name"].string ?? ""
        
        let recommended_products = json["recommended_products"].array
        var recomendedProduct = [UserRecommendedProducts]()
        for item in recommended_products! {
            let id : String = item["id"].string ?? ""
            let image : String = item["image"].string ?? ""
            let price :String = item["price"].string ?? ""
            let status : String = item["status"].string ?? ""
            let name : String = item["name"].string ?? ""
            let featured : String = item["featured"].string ?? ""
            let created_at :String = item["created_at"].string ?? ""
            let description : String = item["description"].string ?? ""
            
            let data = UserRecommendedProducts(id: id, image: image, price: price, status: status, name: name, featured: featured, created_at: created_at, description: description)
            recomendedProduct.append(data)
        }
        var training = [UserTraining]()
        var userTrainingPlan = [UserTrainingPlan]()
        let traingsJson = json["trainings"].array
       
        for item in traingsJson! {
            let name : String = item["name"].string ?? ""
            let id : String = item["id"].string ?? ""
            let created_at : String = item["created_at"].string ?? ""
            let status :String = item["status"].string ?? ""
            let description : String = item["description"].string ?? ""
            let trainingData = UserTraining(name: name, id: id, created_at: created_at, status: status, description: description)
            training.append(trainingData)
            let plans = item["plans"].array
            for plan in plans! {
                let image : String = plan["image"].string ?? ""
                let training_id : String = plan["training_id"].string ?? ""
                let description :String = plan["description"].string ?? ""
                let workout : String = plan["workout"].string ?? ""
                let name : String = plan["name"].string ?? ""
                let trending : String = plan["trending"].string ?? ""
                let featured :String = plan["featured"].string ?? ""
                let id : String = plan["description"].string ?? ""
             let trainingPlanData = UserTrainingPlan(image: image, training_id: training_id, description: description, workout: workout, name: name, trending: trending, featured: featured, id: id)
                userTrainingPlan.append(trainingPlanData)
            }
        }
        let userData = SignInUser(first_name: first_name, current_weight: current_weight, phone: phone, gender: gender, user_id: user_id, height: height, birth_date: birth_date, client_type: client_type, username: username, package_id: package_id, html: html, last_name: last_name, plan_id: plan_id, created_by: created_by, email: email, targeted_weight: targeted_weight, profile_image: profile_image, custom_session_id: custom_session_id, trainer_name: trainer_name,recommended_products: recomendedProduct,trainings: training,trainingPlan: userTrainingPlan)
            
     
        UserDefaults.standard.set(true, forKey: "userLogedIn")
        UserDefaults.standard.setValue(user_id, forKey: "userId")
        UserDefaults.standard.setValue(custom_session_id, forKey: "sessionId")
        KRProgressHUD.dismiss()
        let vc = storyboard?.instantiateViewController(identifier: "CustomTabbarVC") as! CustomTabbarVC
        
        self.present(vc, animated: true, completion: nil)
    }
    func checkSocialLogins(userName:String,tokenId:String){
        let params = ["username":userName,"tokenid":tokenId]
        Alamofire.request("https://digitalech.com/dietApp/api/userLogin", method: .post, parameters: params).responseJSON { (response) in
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

/*
 {
   "targeted_weight" : "50.00",
   "email" : "anish1890@gmail.com",
   "gender" : "male",
   "plan_id" : "1",
   "user_id" : "31",
   "profile_image" : "http:\/\/digitalech.com\/dietApp\/api\/assets\/images\/user-profile.png",
   "phone" : "3343651596",
   "error" : 0,
   "first_name" : "anish",
   "package_id" : "1",
   "client_type" : "walkin",
   "recommended_products" : [
     {
       "description" : "BIOZYME Whey Isolate",
       "image" : "https:\/\/cdn-a.william-reed.com\/var\/wrbm_gb_food_pharma\/storage\/images\/publications\/food-beverage-nutrition\/nutraingredients-asia.com\/article\/2019\/12\/04\/whey-protein-for-the-indian-gut-muscleblaze-s-new-sports-products-aim-to-improve-absorption\/10361335-3-eng-GB\/Whey-protein-for-the-Indian-gut-MuscleBlaze-s-new-sports-products-aim-to-improve-absorption.jpg",
       "price" : "USD 125",
       "status" : "1",
       "featured" : "1",
       "created_at" : "2021-03-10 16:11:57",
       "id" : "4",
       "name" : "MB (Muscle Blaze)"
     },
     {
       "description" : "This is very good protien",
       "image" : "https:\/\/barbend.com\/wp-content\/uploads\/2019\/03\/optimum-nutrition-gold-standard-isolate-featured.jpg",
       "price" : "USD 85",
       "status" : "1",
       "featured" : "1",
       "created_at" : "2021-03-10 16:14:24",
       "id" : "5",
       "name" : "Gold Standard"
     }
   ],
   "last_name" : "afzal",
   "trainings" : [
     {
       "status" : "1",
       "description" : "loss your weight to 60 program.",
       "name" : "Loose Weight",
       "plans" : [
         {
           "description" : "Loss Weight program",
           "training_id" : "1",
           "image" : "https:\/\/i.guim.co.uk\/img\/media\/94f9cbe72ba5ab188531729a478e2d5236cc6e8c\/0_500_5069_3041\/master\/5069.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=e769aa64f4348c79f021f873ba3def1d",
           "featured" : "0",
           "workout" : "[{\"title\":\"Push up\",\"video_url\":\"https:\/\/www.youtube.com\/watch?v=Eh00_rniF8E\",\"image_url\":\"https:\/\/static.vecteezy.com\/system\/resources\/previews\/000\/162\/135\/original\/push-up-pose-vector.jpg\",\"excercise_description\":\"10 rep x 2\"},{\"title\":\"Squats\",\"video_url\":\"https:\/\/www.youtube.com\/watch?v=YaXPRqUwItQ\",\"image_url\":\"https:\/\/img.freepik.com\/free-vector\/man-woman-doing-squats-male-female-characters-cartoon-style_201240-78.jpg?size=626&ext=jpg\",\"excercise_description\":\"15 reps x 2\"}]",
           "trending" : "0",
           "id" : "1",
           "name" : "Week 1"
         },
         {
           "description" : "asdsads",
           "training_id" : "1",
           "image" : "https:\/\/i.pinimg.com\/originals\/90\/40\/ed\/9040edf1e9e91de0367bc24cb902e57d.jpg",
           "featured" : "0",
           "workout" : "[{\"title\":\"Excercise 1\",\"video_url\":\"asad asdas s\",\"image_url\":\"asdas dsa das\",\"excercise_description\":\"s adasdasd\"},{\"title\":\"Excercise 2\",\"video_url\":\"dasdas sdas ds afsfsdfdf\",\"image_url\":\"dfasd dfsd \",\"excercise_description\":\"as fdas df\"},{\"title\":\"excercise 3\",\"video_url\":\"yhhciurl3.com\",\"image_url\":\"imageurl3.com\",\"excercise_description\":\"asdasdc ff avf dd fsdf sdf asfcccsda   \"}]",
           "trending" : "0",
           "id" : "2",
           "name" : "Week 2"
         },
         {
           "description" : "This is challenge for all the participant of our gym to complete this trainings to get \"Fighter Belt\".",
           "training_id" : "1",
           "image" : "https:\/\/www.mensjournal.com\/wp-content\/uploads\/mf\/1280-barbell-curl_0.jpg?w=1200&h=675&crop=1&quality=86&strip=all",
           "featured" : "0",
           "workout" : "[{\"title\":\"Daily Boxing Champ\",\"video_url\":\"https:\/\/www.youtube.com\/watch?v=jCTEVKRTuS8\",\"image_url\":\"https:\/\/static01.nyt.com\/images\/2012\/04\/13\/sports\/13amputee1\/13amputee1-superJumbo.jpg\",\"excercise_description\":\"You needs to practice Boxing at least 1 hour on daily basis to achieve boxing medals.\"}]",
           "trending" : "1",
           "id" : "3",
           "name" : "Fighter Challange"
         },
         {
           "description" : "You needs to do daily walk to burn your fat",
           "training_id" : "1",
           "image" : "https:\/\/i0.wp.com\/images-prod.healthline.com\/hlcmsresource\/images\/AN_images\/woman-exercising-at-stadium-1296x728.jpg?w=1155&h=1528",
           "featured" : "0",
           "workout" : "[{\"title\":\"Joging\",\"video_url\":\"https:\/\/www.youtube.com\/watch?v=R3AUw3-jtEo\",\"image_url\":\"https:\/\/access24.tv\/wp-content\/uploads\/2018\/07\/workout-tips-2017.jpg\",\"excercise_description\":\"Needs to follow this exercise strictly\"}]",
           "trending" : "1",
           "id" : "5",
           "name" : "Fat Burning"
         }
       ],
       "id" : "1",
       "created_at" : "2021-03-05 15:32:14"
     }
   ],
   "trainer_name" : "Super Administrator",
   "current_weight" : "78.00",
   "created_by" : "1",
   "height" : "5.8",
   "custom_session_id" : "6053911aa6cdf",
   "username" : "anish1890@gmail.com"
 }
 */
