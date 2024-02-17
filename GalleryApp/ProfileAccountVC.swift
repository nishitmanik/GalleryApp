//
//  ProfileAccountVC.swift
//  GalleryApp
//
//  Created by MacBook AirM1 on 18/01/24.
//

import UIKit
import FirebaseAuth

class ProfileAccountVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var image: UIImageView!
    
   
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image.layer.cornerRadius = image.bounds.width / 2
        image.clipsToBounds = true
        
        
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
          image.isUserInteractionEnabled = true
          image.addGestureRecognizer(tapGesture)
    }
    
    
    @IBAction func LogoutAccount(_ sender: UIButton) {
        
        showalert(title: "Log out", message: "Are you sure you want to Logout", ViewController: self) { [unowned self] (action) in
            
            if action.title == "Yes" {
                
                do {
                    try Auth.auth().signOut()
                    
                    self.navigationController?.popToRootViewController(animated: true)
                } catch {
                    showAlert(title: "Error", message: "Not LogOut", ViewController: self)
                    print("Error signing out: \(error.localizedDescription)")
                }
            }
        }
        
        
    }
    


    @objc func profileImageTapped() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image.image = pickedImage
        }

        dismiss(animated: true, completion: nil)
    }
    
}
