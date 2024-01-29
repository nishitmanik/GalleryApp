//
//  ImageScreenVC.swift
//  GalleryApp
//
//  Created by MacBook AirM1 on 18/01/24.
//

import UIKit

class ImageScreenVC: UIViewController, UIScrollViewDelegate {
    
    

    @IBOutlet weak var scrollView: UIScrollView!
    
   
    @IBOutlet weak var Pagecontrolview: UIPageControl!
    
    
    
    
    var imageNames = ["image1","image2","image3","image4","image5","image6","image7","image8","image9","image10"]
    var currentPage = 0
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        for (index, imageName) in imageNames.enumerated() {
            if let imageToDisplay = UIImage(named: imageName) {
                let imageView = UIImageView(image: imageToDisplay)

                let coordinate = view.frame.width * CGFloat(index)
                imageView.frame = CGRect(x: coordinate, y: 0, width: view.frame.width, height: scrollView.frame.height)

                scrollView.addSubview(imageView)
            }
        }

        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(imageNames.count), height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self

        Pagecontrolview.numberOfPages = imageNames.count
        Pagecontrolview.currentPage = 0

        // Set up timer for automatic scrolling
        startTimer()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }

    @objc func autoScroll() {
        currentPage = (currentPage + 1) % imageNames.count
        let offsetX = view.frame.width * CGFloat(currentPage)
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        Pagecontrolview.currentPage = currentPage
    }

    // MARK: - UIScrollViewDelegate

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        Pagecontrolview.currentPage = currentPage
    }

    deinit {
        
        timer?.invalidate()
        timer = nil
    }
}
