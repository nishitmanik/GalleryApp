//
//  ProfileAccountVC.swift
//  GalleryApp
//
//  Created by MacBook AirM1 on 18/01/24.
//

import UIKit
import FirebaseAuth

class ProfileAccountVC: UIViewController {

    
    @IBOutlet weak var image: UIImageView!
    
   
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.blue.cgColor
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        image.layer.masksToBounds = false
    }
    
    
    @IBAction func LogoutAccount(_ sender: UIButton) {
        
        showalert(title: "Log out", message: "Are you sure you want to Logout", ViewController: self) { [unowned self] (action) in
            
            if action.title == "Yes" {
                
                do {
                    try Auth.auth().signOut()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginScreen") as! LoginScreenVC
                    self.navigationController?.pushViewController(vc, animated: true)
                } catch {
                    showAlert(title: "Error", message: "Not LogOut", ViewController: self)
                    print("Error signing out: \(error.localizedDescription)")
                }
            }
        }
        
        
    }
    
    func showalert(title: String, message: String, ViewController: UIViewController, completion: ((UIAlertAction) -> Void)? = nil) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: completion)
            let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)

            alert.addAction(yesAction)
            alert.addAction(noAction)

            ViewController.present(alert, animated: true, completion: nil)
        }
}
