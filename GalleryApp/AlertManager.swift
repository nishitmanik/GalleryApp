//
//  AlertManager.swift
//  GalleryApp
//
//  Created by MacBook AirM1 on 17/01/24.
//

import Foundation
import UIKit

func showAlert(title t:String, message m:String, ViewController vc : UIViewController) {
    let alert = UIAlertController(title: t, message: m, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(alertAction)
    vc.present(alert, animated: true, completion: nil)
}

func showalert(title: String, message: String, ViewController: UIViewController, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: completion)
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)

        alert.addAction(yesAction)
        alert.addAction(noAction)

        ViewController.present(alert, animated: true, completion: nil)
    }
