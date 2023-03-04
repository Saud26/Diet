//
//  UpdateProfileVC.swift
//  Diet
//
//  Created by Anish on 5/20/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class UpdateProfileVC: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let fName =  UserDefaults.standard.object(forKey: "firstName") {
            firstName.text = (fName as! String)
        }
        if let lName =  UserDefaults.standard.object(forKey: "lastName") {
            lastName.text = (lName as! String)
        }
        if let phones =  UserDefaults.standard.object(forKey: "phone") {
            phone.text = (phones as! String)

        }
        if let emails =  UserDefaults.standard.object(forKey: "email") {
            email.text = (emails as! String)
        }
        if let proPic =  UserDefaults.standard.object(forKey: "profilePic") {
            if let url = URL(string: proPic as! String){
                profilePic.sd_setImage(with: url, completed: nil)
            }
        }
      
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateProfile(_ sender: Any) {
        if firstName.text == "" || lastName.text == "" || phone.text == "" || email.text == "" {
            simpleAlert("please fill all fields")
        }else if !isValidEmail(testStr: email.text!) {
            simpleAlert("Invalid email")
        }else {
            self.uploadArtistImage(image: profilePic.image!)
        }
        
    }
    
    
    @IBAction func camera(_ sender: Any) {
        let AlertController = UIAlertController(title: "HERBAPKA", message: "Select an image for profile picture", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Take from camera", style: .default) { (action) in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        let gallery = UIAlertAction(title: "Choose from gallery", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        AlertController.addAction(camera)
        AlertController.addAction(gallery)
        AlertController.addAction(cancel)
        
        self.present(AlertController, animated: true, completion: nil)
    }
    // ------------------------------------------------
    // MARK: - IMAGE PICKER DELEGATE
    // ------------------------------------------------
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profilePic.image = image
            
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension UpdateProfileVC {
    //MARK:- UPLOAD PROFILE PICTURE FUNCTION
    
    func uploadArtistImage(image:UIImage){
        
        KRProgressHUD.show()
        let param: [String:Any] = ["session_id":SESSION_ID,"first_name":firstName.text!,"last_name":lastName.text!,"phone":phone.text!,"email":email.text!]
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                multipartFormData.append(image.jpegData(compressionQuality: 0.6)!, withName: "profile_image", fileName: "file.jpeg", mimeType: "image/jpeg")
                for (key, value) in param
                {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        }, to:"https://digitalech.com/dietApp/api/updateUserProfile",headers:nil)
        { (result) in
            switch result {
            case .success(let upload,_,_ ):
                upload.uploadProgress(closure: { (progress) in
                    print("Progress.. \(progress)")
                })
                upload.responseJSON
                    { response in
                        print(response.result)
                        if response.result.value != nil
                        {
                            let userData:JSON = JSON(response.result.value!)
                            print(JSON(response.result.value!)) // for JSOn format result
                            KRProgressHUD.dismiss()
                            self.simpleAlert("Profile updated")
                            
                            UserDefaults.standard.setValue(userData["data"]["first_name"].string ?? "", forKey: "firstName")
                            UserDefaults.standard.setValue(userData["data"]["last_name"].string ?? "", forKey: "lastName")
                            UserDefaults.standard.setValue(userData["data"]["phone"].string ?? "", forKey: "phone")
                            UserDefaults.standard.setValue(userData["data"]["email"].string ?? "", forKey: "email")
                            UserDefaults.standard.setValue(userData["data"]["profile_image"].string ?? "", forKey: "profilePic")
                        }
                }
            case .failure( _):
                KRProgressHUD.dismiss()
                break
            }
        }
    }
    
}
