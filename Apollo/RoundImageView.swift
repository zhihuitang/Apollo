//
//  RoundImageView.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-11-20.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit

@IBDesignable
class RoundImageView: UIView {
    @IBInspectable
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    @IBInspectable
    var radius: CGFloat = 50.0 {
        didSet {
            outerView.layer.cornerRadius = radius
            outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: radius).cgPath
            imageView.layer.cornerRadius = radius
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat = 5.0 {
        didSet {
        }
    }
    
    @IBInspectable
    var bgColor: UIColor = .white {
        didSet {
            outerView.backgroundColor = bgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 2.0 {
        didSet {
            outerView.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .white {
        didSet {
            outerView.layer.borderColor = borderColor.cgColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        outerView.frame = self.bounds
        imageView.frame = self.bounds
    }
    
    private var outerView: UIView = UIView()
    private var imageView: UIImageView = UIImageView()
    
    private func setupLayer() {
        imageView.clipsToBounds = true
        outerView.clipsToBounds = false
        
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 1
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = shadowRadius

    }
    
    private func commonInit() {
        setupLayer()
        outerView.addSubview(imageView)
        self.addSubview(outerView)
        
    }
}
