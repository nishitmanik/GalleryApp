//
//  CreateaccountVc.swift
//  GalleryApp
//
//  Created by MacBook AirM1 on 17/01/24.
//

import UIKit
import FirebaseAuth

class CreateaccountVc: UIViewController {

    @IBOutlet weak var TxtName: UITextField!
    @IBOutlet weak var Txtemail: UITextField!
    
    @IBOutlet weak var txtConfirm: UITextField!
    
    @IBOutlet weak var Txtpass: UITextField!
    
    @IBOutlet weak var Btnsign: UIButton!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Btnsign.layer.cornerRadius = 20
        
    }
   
    
    @IBAction func Btnsign(_ sender: UIButton) {

        if TxtName.text == "" || Txtpass.text == "" || Txtemail.text == "" ||
            txtConfirm.text == "" {
            showAlert(title: "Error", message: "Enter valid ", ViewController: self)
        }else if Txtemail.text == "" {
            showAlert(title: "Error", message: "Valid Email", ViewController: self)
            
        }
        else if Txtpass.text != txtConfirm.text {
            showAlert(title: "Error", message: "Password not matched", ViewController: self)
            
        } else {
            Auth.auth().createUser(withEmail: Txtemail.text!, password: Txtpass.text!) { authResult, error in
                if let err = error {
                    showAlert(title: "Error", message: err.localizedDescription, ViewController: self)
                } else if let result = authResult {
                    showAlert(title: "Done", message: "Go to Login page ", ViewController: self)

                }
            }
        }
        
    }
    
}
