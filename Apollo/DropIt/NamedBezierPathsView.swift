//
//  NamedBezierPathsView.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-01-15.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit

class NamedBezierPathsView: UIView {
    var bezierPaths = [String:UIBezierPath]() { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        for (_, path) in bezierPaths {
            path.stroke()
        }

    }
    
}
