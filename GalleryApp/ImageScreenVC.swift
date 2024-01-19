//
//  ImageScreenVC.swift
//  GalleryApp
//
//  Created by MacBook AirM1 on 18/01/24.
//

import UIKit

class ImageScreenVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var TableViewImage: UITableView!
    
    var arrImage : [MainModelImages] = [] {
        didSet{
            print(arrImage.count)
            DispatchQueue.main.async {
                self.TableViewImage.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        TableViewImage.delegate = self
        TableViewImage.dataSource = self
     
    
        getImage()
    }

    func getImage() {
        guard let url = URL(string: "https://picsum.photos/v2/list?page=1&limit=20") else {
            print("Invalid URL")
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error occurred while accessing data with URL")
                return
            }

            do {
                self.arrImage = try JSONDecoder().decode([MainModelImages].self, from: data)
            } catch {
                print("Error occurred while decoding JSON into Swift structured: \(error)")
            }
        }

        dataTask.resume()
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ImageTableViewCell

        print("\(indexPath.row)Image Url:-", arrImage[indexPath.row].download_url)
          
           if let imageUrlString = arrImage[indexPath.row].download_url {
               GetImage(imageUrlString: imageUrlString) { (img) in
                   DispatchQueue.main.async {
                       cell.ImageScreen.image = img
                   }
               }
           } else {
               
               cell.ImageScreen.image = UIImage(named: "createaccount_backimg")
           }

        return cell
        
    }

    
    func GetImage(imageUrlString: String?, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrlString = imageUrlString, let imageUrl = URL(string: imageUrlString) else {
            completion(nil)
            return
        }

        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: imageUrl)),
            let image = UIImage(data: cachedResponse.data) {
            completion(resizeImage(image, maxWidth: 393, maxHeight: 295))
            return
        }

        let session = URLSession.shared

        let task = session.dataTask(with: imageUrl) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    let resizedImage = self.resizeImage(image, maxWidth: 393, maxHeight: 295)
                    completion(resizedImage)

                    // MARK: SET image from cache
                    let cachedResponse = CachedURLResponse(response: response!, data: data)
                    URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: imageUrl))
                }
            }
        }

        task.resume()
    }

    func resizeImage(_ image: UIImage, maxWidth: CGFloat, maxHeight: CGFloat) -> UIImage {
        var newWidth = image.size.width
        var newHeight = image.size.height

        if newWidth > maxWidth {
            let scaleFactor = maxWidth / newWidth
            newWidth *= scaleFactor
            newHeight *= scaleFactor
        }

        if newHeight > maxHeight {
            let scaleFactor = maxHeight / newHeight
            newWidth *= scaleFactor
            newHeight *= scaleFactor
        }

        let newSize = CGSize(width: newWidth, height: newHeight)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        image.draw(in: CGRect(origin: .zero, size: newSize))

        if let resizedImage = UIGraphicsGetImageFromCurrentImageContext() {
            return resizedImage
        }

        return image
    }
    
    
    
}


struct MainModelImages: Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String?
}
