//
//  RoundView.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-11-19.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit

let swiftOrangeColor = UIColor(red: 248/255, green: 96/255.0, blue: 47/255.0, alpha: 1.0)
let lighterSwiftOrangeColor = UIColor(red: 255/255, green: 160/255.0, blue: 70/255.0, alpha: 1.0)

@IBDesignable
class RoundView: UIView {
    
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

    let contentLayer = CALayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        setUpLayer()
    }
    
    func setUpLayer() {
        contentLayer.frame = self.bounds
        contentLayer.contents = image?.cgImage
        contentLayer.contentsGravity = kCAGravityResizeAspect
        contentLayer.isGeometryFlipped = false
        contentLayer.cornerRadius = radius
        contentLayer.borderWidth = borderWidth
        contentLayer.borderColor = borderColor.cgColor
        contentLayer.backgroundColor = bgColor.cgColor
        contentLayer.shadowOpacity = 0.75
        contentLayer.shadowOffset = CGSize(width: 0, height: 3)
        contentLayer.shadowRadius = 3.0
        contentLayer.magnificationFilter = kCAFilterLinear

    }
    
    private func commonInit() {
        setUpLayer()
        self.layer.addSublayer(contentLayer)
    }
}
