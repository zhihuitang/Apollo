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
            setNeedsLayout()
        }
    }
    @IBInspectable
    var radius: CGFloat = 50.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    var bgColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 2.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .white { didSet { setNeedsLayout() } }

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
        setupLayer()
    }
    
    private var outerView: UIView = UIView()
    private var imageView: UIImageView = UIImageView()
    
    private func setupLayer() {
        outerView.frame = self.bounds
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 1
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 5
        outerView.layer.borderColor = borderColor.cgColor
        outerView.layer.borderWidth = borderWidth
        outerView.layer.cornerRadius = radius
        outerView.backgroundColor = bgColor
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: radius).cgPath
        
        imageView.frame = self.bounds
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = radius
        imageView.image = image
    }
    
    private func commonInit() {
        outerView.addSubview(imageView)
        self.addSubview(outerView)
        
        setupLayer()
    }
}
