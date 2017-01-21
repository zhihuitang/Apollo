//
//  ImageViewController.swift
//  Cassini
//
//  Created by Zhihui Tang on 2016-12-29.
//  Copyright © 2016 Zhihui Tang. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.1
            scrollView.maximumZoomScale = 1.0
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
    
    public var imageView = UIImageView()
    
    private var image: UIImage? {
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinnerView?.stopAnimating()
        }
        
        get {
            return imageView.image
        }
    }
    
    private func fetchImage() {

        if let url = imageURL {
            spinnerView?.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let imageData = try Data(contentsOf: url)
                    DispatchQueue.main.async { [weak self] in
                        if url == self?.imageURL {
                            self?.image = UIImage(data: imageData)
                        }else{
                            print("ignored data returned from url \(url)")
                        }
                    }
                }catch {
                    print("exception in fetchImage")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.addSubview(imageView)
        //imageURL = URL(string: DemoURL.Stanford)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    // MARK: UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}

