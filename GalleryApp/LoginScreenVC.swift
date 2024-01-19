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
    }
    func sign(_ signIn: GIDSignIn!,didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("User email: \(user.profile?.email ?? "No Email")")
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        
        return GIDSignIn.sharedInstance.handle(url)
        
        
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
