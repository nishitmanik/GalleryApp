//
//  ProfileAccountVC.swift
//  GalleryApp
//
//  Created by MacBook AirM1 on 18/01/24.
//

import UIKit

class ProfileAccountVC: UIViewController {

    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var CollectionImage: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image.layer.borderWidth = 2
        image.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 2, alpha: 0)
        image.layer.cornerRadius = 20
    }
    
    
    @IBAction func LogoutAccount(_ sender: UIButton) {
        
        showAlert(title: "Log out", message: "Are you sure you want to Logout", ViewController: self)
        
//        let VC = self.storyboard?.instantiateViewController(identifier: "LoginScreenVC") as! LoginScreenVC
//        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    

}
