//
//  RoundImageViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-11-19.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit

class RoundImageViewController: BaseViewController {
    override var name: String {
        return "Round image view"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addImageView()
    }
    
    private func addImageView() {
        let outerView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 1
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 5
        outerView.layer.borderColor = UIColor.white.cgColor
        outerView.layer.borderWidth = 3
        outerView.layer.cornerRadius = 50
        outerView.backgroundColor = UIColor.white
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 50).cgPath
        
        
        let myImage = UIImageView(frame: outerView.bounds)
        myImage.clipsToBounds = true
        myImage.layer.cornerRadius = 50
        myImage.image = UIImage(named: "tang")
        
        outerView.addSubview(myImage)
        self.view.addSubview(outerView)
    }
}
