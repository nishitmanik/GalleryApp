//
//  ProfileAccountVC.swift
//  GalleryApp
//
//  Created by MacBook AirM1 on 18/01/24.
//

import UIKit

class ProfileAccountVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var CollectionImage: UICollectionView!
    
    var imageArr = ["image1","image2","image3","image4"]
    
    
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProfileCollectionViewCell
        
        cell.ImageCell?.image = UIImage(named: imageArr[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/2 - 30
        let height = width + (width * 0.33)
        
        return CGSize(width: width, height: height)
    }

}
