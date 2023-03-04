//
//  PasswordViewController.swift
//  Diet
//
//  Created by Anish on 3/17/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class PasswordViewController: UIViewController {

    
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    
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
    var password = ""
    var confirmPassword = ""
    var firstName = ""
    var lastName = ""
    var myUser = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func next(_ sender: Any) {
        if pass.text == "" || confirmPass.text == ""{
            simpleAlert("Enter your password")
        }else if pass.text != confirmPass.text {
            simpleAlert("password does not match")
        }
        else {
            //pakagae Id 1 for month 2 for Yearly
            //client_type walkin/bytrainer....bytrainer for those who have already created by trainer
            password = pass.text!
            confirmPassword = confirmPass.text!
            self.signup(username: name, email: emailadd, password: password, first_name: firstName, last_name: lastName, gender: gender, plan_id: goal, package_id: "1", current_weight: weight, targeted_weight: targatedWeight, height: height, phone: phonenumber, client_type: "walkin", user_type: "user", user_status: "1", conf_password: confirmPassword, birth_date: dob)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


}

extension PasswordViewController {
    
    func signup(username:String,email:String,password:String,first_name:String,last_name:String,gender:String,plan_id:String,package_id:String,current_weight:String,targeted_weight:String,height:String,phone:String,client_type:String,user_type:String,user_status:String,conf_password:String,birth_date:String){
        
        let params = ["username":username,"email":email,"password":password,"first_name":first_name,"last_name":last_name,"gender":gender,"plan_id":plan_id,"package_id":package_id,"current_weight":current_weight,"targeted_weight":targeted_weight,"height":height,"phone":phone,"client_type":client_type,"user_type":user_type,"user_status":user_status,"conf_password":conf_password,"birth_date":birth_date]
        KRProgressHUD.show()
        Alamofire.request(BASE_URL+"registration", method: .post, parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                let result:JSON = JSON(response.result.value!)
                print(result)
                if result["error"].int! == 1 {
                    self.simpleAlert(result["errors"][0]["message"].string!)
                }else {
                    self.parseSignup(json: result)
                }
            }
        }
    }
    
    func parseSignup(json:JSON){
        
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
            let data = User(first_name: first_name, current_weight: current_weight, phone: phone, gender: gender, user_id: user_id, height: height, birth_date: birth_date, client_type: client_type, username: username, package_id: package_id, html: html, last_name: last_name, plan_id: plan_id, created_by: created_by, email: email, targeted_weight: targeted_weight, recommended_products: recomendedProduct, trainings: training,trainingPlan: userTrainingPlan)
              
        
        UserDefaults.standard.set(true, forKey: "userLogedIn")
        UserDefaults.standard.setValue(user_id, forKey: "userId")
       
        KRProgressHUD.dismiss()
        let vc = storyboard?.instantiateViewController(identifier: "CustomTabbarVC")
        self.present(vc!, animated: true, completion: nil)
        
    }
}
/*
 let vc = storyboard?.instantiateViewController(identifier: "CustomTabbarVC")
 self.present(vc!, animated: true, completion: nil)
 */

/*
 {
   "first_name" : "anish",
   "current_weight" : "78.00",
   "phone" : "3343651596",
   "gender" : "male",
   "user_id" : "31",
   "recommended_products" : [
     {
       "id" : "4",
       "image" : "https:\/\/cdn-a.william-reed.com\/var\/wrbm_gb_food_pharma\/storage\/images\/publications\/food-beverage-nutrition\/nutraingredients-asia.com\/article\/2019\/12\/04\/whey-protein-for-the-indian-gut-muscleblaze-s-new-sports-products-aim-to-improve-absorption\/10361335-3-eng-GB\/Whey-protein-for-the-Indian-gut-MuscleBlaze-s-new-sports-products-aim-to-improve-absorption.jpg",
       "price" : "USD 125",
       "status" : "1",
       "name" : "MB (Muscle Blaze)",
       "featured" : "1",
       "created_at" : "2021-03-10 16:11:57",
       "description" : "BIOZYME Whey Isolate"
     },
     {
       "id" : "5",
       "image" : "https:\/\/barbend.com\/wp-content\/uploads\/2019\/03\/optimum-nutrition-gold-standard-isolate-featured.jpg",
       "price" : "USD 85",
       "status" : "1",
       "name" : "Gold Standard",
       "featured" : "1",
       "created_at" : "2021-03-10 16:14:24",
       "description" : "This is very good protien"
     }
   ],
   "height" : "5.8",
   "birth_date" : "18 02 1990",
   "client_type" : "walkin",
   "error" : 0,
   "username" : "anish1890@gmail.com",
   "package_id" : "1",
   "html" : "Registered Successfully.",
   "last_name" : "afzal",
   "plan_id" : "1",
   "created_by" : "1",
   "trainings" : [
     {
       "plans" : [
         {
           "image" : "https:\/\/i.guim.co.uk\/img\/media\/94f9cbe72ba5ab188531729a478e2d5236cc6e8c\/0_500_5069_3041\/master\/5069.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=e769aa64f4348c79f021f873ba3def1d",
           "training_id" : "1",
           "description" : "Loss Weight program",
           "workout" : "[{\"title\":\"Push up\",\"video_url\":\"https:\/\/www.youtube.com\/watch?v=Eh00_rniF8E\",\"image_url\":\"https:\/\/static.vecteezy.com\/system\/resources\/previews\/000\/162\/135\/original\/push-up-pose-vector.jpg\",\"excercise_description\":\"10 rep x 2\"},{\"title\":\"Squats\",\"video_url\":\"https:\/\/www.youtube.com\/watch?v=YaXPRqUwItQ\",\"image_url\":\"https:\/\/img.freepik.com\/free-vector\/man-woman-doing-squats-male-female-characters-cartoon-style_201240-78.jpg?size=626&ext=jpg\",\"excercise_description\":\"15 reps x 2\"}]",
           "name" : "Week 1",
           "trending" : "0",
           "featured" : "0",
           "id" : "1"
         },
         {
           "image" : "https:\/\/i.pinimg.com\/originals\/90\/40\/ed\/9040edf1e9e91de0367bc24cb902e57d.jpg",
           "training_id" : "1",
           "description" : "asdsads",
           "workout" : "[{\"title\":\"Excercise 1\",\"video_url\":\"asad asdas s\",\"image_url\":\"asdas dsa das\",\"excercise_description\":\"s adasdasd\"},{\"title\":\"Excercise 2\",\"video_url\":\"dasdas sdas ds afsfsdfdf\",\"image_url\":\"dfasd dfsd \",\"excercise_description\":\"as fdas df\"},{\"title\":\"excercise 3\",\"video_url\":\"yhhciurl3.com\",\"image_url\":\"imageurl3.com\",\"excercise_description\":\"asdasdc ff avf dd fsdf sdf asfcccsda   \"}]",
           "name" : "Week 2",
           "trending" : "0",
           "featured" : "0",
           "id" : "2"
         },
         {
           "image" : "https:\/\/www.mensjournal.com\/wp-content\/uploads\/mf\/1280-barbell-curl_0.jpg?w=1200&h=675&crop=1&quality=86&strip=all",
           "training_id" : "1",
           "description" : "This is challenge for all the participant of our gym to complete this trainings to get \"Fighter Belt\".",
           "workout" : "[{\"title\":\"Daily Boxing Champ\",\"video_url\":\"https:\/\/www.youtube.com\/watch?v=jCTEVKRTuS8\",\"image_url\":\"https:\/\/static01.nyt.com\/images\/2012\/04\/13\/sports\/13amputee1\/13amputee1-superJumbo.jpg\",\"excercise_description\":\"You needs to practice Boxing at least 1 hour on daily basis to achieve boxing medals.\"}]",
           "name" : "Fighter Challange",
           "trending" : "1",
           "featured" : "0",
           "id" : "3"
         },
         {
           "image" : "https:\/\/i0.wp.com\/images-prod.healthline.com\/hlcmsresource\/images\/AN_images\/woman-exercising-at-stadium-1296x728.jpg?w=1155&h=1528",
           "training_id" : "1",
           "description" : "You needs to do daily walk to burn your fat",
           "workout" : "[{\"title\":\"Joging\",\"video_url\":\"https:\/\/www.youtube.com\/watch?v=R3AUw3-jtEo\",\"image_url\":\"https:\/\/access24.tv\/wp-content\/uploads\/2018\/07\/workout-tips-2017.jpg\",\"excercise_description\":\"Needs to follow this exercise strictly\"}]",
           "name" : "Fat Burning",
           "trending" : "1",
           "featured" : "0",
           "id" : "5"
         }
       ],
       "name" : "Loose Weight",
       "id" : "1",
       "created_at" : "2021-03-05 15:32:14",
       "status" : "1",
       "description" : "loss your weight to 60 program."
     }
   ],
   "email" : "anish1890@gmail.com",
   "targeted_weight" : "50.00"
 }
 */
