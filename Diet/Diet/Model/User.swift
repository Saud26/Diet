//
//  User.swift
//  Diet
//
//  Created by Anish on 5/18/21.
//

import Foundation

struct User {
 
    var first_name : String
    var current_weight : String
    var phone :String
    var gender : String
   
    var user_id : String
    var height : String
    var birth_date :String
    var client_type : String
    
    var username : String
    var package_id : String
    var html :String
    var last_name : String
    
    var plan_id : String
    var created_by : String
    var email :String
    var targeted_weight : String
    
    var recommended_products = [UserRecommendedProducts]()
    var trainings = [UserTraining]()
    var trainingPlan = [UserTrainingPlan]()
}

struct SignInUser {
    var first_name : String
    var current_weight : String
    var phone :String
    var gender : String
   
    var user_id : String
    var height : String
    var birth_date :String
    var client_type : String
    
    var username : String
    var package_id : String
    var html :String
    var last_name : String
    
    var plan_id : String
    var created_by : String
    var email :String
    var targeted_weight : String
    
    var profile_image : String
    var custom_session_id :String
    var trainer_name : String
    
    var recommended_products = [UserRecommendedProducts]()
    var trainings = [UserTraining]()
    var trainingPlan = [UserTrainingPlan]()
}

struct UserRecommendedProducts {
    var id : String
    var image : String
    var price :String
    var status : String
    var name : String
    var featured : String
    var created_at :String
    var description : String
}
struct UserTraining {
    var name : String
    var id : String
    var created_at : String
    var status :String
    var description : String
}
struct UserTrainingPlan {
    var image : String
    var training_id : String
    var description : String
    var workout :String
    var name : String
    var trending : String
    var featured : String
    var id :String
   
}
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


