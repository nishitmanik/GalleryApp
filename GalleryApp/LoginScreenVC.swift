//
//  LoginScreenVC.swift
//  GalleryApp
//
//  Created by MacBook AirM1 on 17/01/24.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

class LoginScreenVC: UIViewController {

    @IBOutlet weak var EmailTxt: UITextField!
    
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var login: UIButton!

    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var Googlebtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let arrayOfElements = [EmailTxt, PasswordTxt, login]

        for element in arrayOfElements {
            element?.layer.cornerRadius = 20
        }
        
        updateAppearance()
        

    }

    
    @IBAction func Loginbtn(_ sender: UIButton) {
        guard let email = EmailTxt.text, !email.isEmpty else {
            showAlert(title: "Error", message: "Enter Email", ViewController: self)
            return
        }

        guard let password = PasswordTxt.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Enter Password", ViewController: self)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if authResult != nil {
//                showAlert(title: "Log in Done", message: "Correct Password", ViewController: strongSelf)
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ImageScreen") as! ImageScreenVC
                         self?.navigationController?.pushViewController(vc, animated: true)
                print("Log in done")
            } else if error != nil {
                
                showAlert(title: "Error", message: "Incorrect Email or Password", ViewController: strongSelf)
            }
        }
    }
    @IBAction func GoogleSignIn(_ sender: UIButton) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

                    let config = GIDConfiguration(clientID: clientID)

                    GIDSignIn.sharedInstance.configuration = config

                    GIDSignIn.sharedInstance.signIn(withPresenting: self)

                    GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
                        guard error == nil else {
                            showAlert(title: "Error", message: "Incorrect Email or Password", ViewController: self)
                            return
                        }

                        guard let user = result?.user,
                            let idToken = user.idToken?.tokenString
                        else {
                        showAlert(title: "Ok", message: "Received Mail to Confirm Login", ViewController: self)
                            print("Log in done")
                            return
                        }

                        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                       accessToken: user.accessToken.tokenString)

                        Auth.auth().signIn(with: credential) { (authResult, error) in
                                    if let error = error {
                                        showAlert(title: "Error", message: error.localizedDescription, ViewController: self)
                                        print("Firebase authentication error: \(error.localizedDescription)")
                                        return
                                    }
                            else if authResult != nil {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageScreen") as! ImageScreenVC
                                self.navigationController?.pushViewController(vc, animated: true)
                                print("Log in done")
                                
                            }

                                    
                                    print("Successfully signed in with Firebase")
                                   
                                }
                    }
        
        
    }
    

    @IBAction func DarkMode(_ sender: UIButton) {
        
        toggleDarkLightMode()
    }
    
    private func toggleDarkLightMode() {
        
            if traitCollection.userInterfaceStyle == .light {
                overrideUserInterfaceStyle = .dark
            } else {
                overrideUserInterfaceStyle = .light
            }

            updateAppearance()
        }

    private func updateAppearance() {
        
        let imageName = traitCollection.userInterfaceStyle == .light ? "lightModeImage" : "darkModeImage"
        imgBg.image = UIImage(named: imageName)
        
    }
    
    @IBAction func ForgotPassword(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(identifier: "CreateScreenVC") as! CreateaccountVc
        
        self.navigationController?.pushViewController(VC, animated: true)
        
        
    }
    
    
}
