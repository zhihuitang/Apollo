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
            outerView.layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable
    var shadowOffset: CGSize = CGSize.zero {
        didSet {
            outerView.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float = 1 {
        didSet {
            outerView.layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable
    var bgColor: UIColor = .white {
        didSet {
            outerView.backgroundColor = bgColor
        }
    }
    @IBInspectable
    var shadowColor: UIColor = .black {
        didSet {
            outerView.layer.shadowColor = shadowColor.cgColor
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
    
    lazy private var outerView: UIView = {
        let view = UIView(frame: self.bounds)
        return view
        
    }()
    lazy private var imageView: UIImageView = {
        let view = UIImageView(frame: self.bounds)
        return view
    }()
    
    private func commonInit() {
        imageView.clipsToBounds = true
        outerView.clipsToBounds = false
        outerView.layer.shadowOpacity = shadowOpacity
        
        outerView.addSubview(imageView)
        self.addSubview(outerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        outerView.frame = self.bounds
        imageView.frame = self.bounds
    }
    
}
