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

        image.layer.borderWidth = 2
        image.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 2, alpha: 0)
        image.layer.cornerRadius = 20
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
