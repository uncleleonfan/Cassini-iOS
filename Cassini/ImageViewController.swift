//
//  ImageViewController.swift
//  Cassini
//
//  Created by Leon Fan on 2018/11/17.
//  Copyright © 2018 Leon Fan. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    private let imageString = "https://ws1.sinaimg.cn/large/0065oQSqly1fw0vdlg6xcj30j60mzdk7.jpg"
    
    fileprivate var imageView = UIImageView()
    
    private var image : UIImage? {
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()

        }
        
        get {
            return imageView.image
        }
    }
    
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView?
    
    
    private func fetchImage() {
        if let url = imageURL {
            self.spinner?.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContent = try? Data(contentsOf: url)
                if let imageData = urlContent, url == self?.imageURL {
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: imageData)
                    }
                
                }
            }

        }
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
////        view.addSubview(imageView)
//        imageURL = URL(string: imageString)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        if image == nil {
            fetchImage()
        }
    }

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.addSubview(imageView)
            scrollView.contentSize = imageView.frame.size
            scrollView.minimumZoomScale = 0.3
            scrollView.maximumZoomScale = 1
        }
    }
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
