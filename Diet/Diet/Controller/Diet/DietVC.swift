//
//  DietVC.swift
//  Diet
//
//  Created by Anish on 2/2/21.
//

import UIKit

class DietVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dietHeading: UILabel!
    @IBOutlet weak var dietDetail: UITextView!
    @IBOutlet weak var profileBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for item in user[0].trainings {
            self.dietHeading.text = item.name
            self.dietDetail.text = item.description
        }
        if let proPic =  UserDefaults.standard.object(forKey: "profilePic") {
            if let url = URL(string: proPic as! String){
                profileBtn.sd_setImage(with: url, for: .normal, completed: nil)
            }
        }
    }
    
    @IBAction func gotoProfile(_ sender: Any) {
    }
    
  

}
extension DietVC : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return user[0].recommended_products.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = user[0].recommended_products[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CVCell1
        
        if let url = URL(string: product.image) {
            cell.productImage.sd_setImage(with: url, completed: nil)
        }
        cell.productSize.text = product.name
        return cell
        
    }
    
    
}
