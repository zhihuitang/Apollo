//
//  BarView.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-01-07.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit

class BarView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        let holderHeight = self.superview!.frame.height
        let y: CGFloat = holderHeight - frame.height
        self.frame.origin.y = y
        let weight = frame.height / (holderHeight)
        let color = UIColor(hue: weight, saturation: 1, brightness: 1, alpha: 1)
        self.backgroundColor = color
    }
    
    func updateHeight(height: CGFloat){
        self.frame.size.height = height
    }
}
