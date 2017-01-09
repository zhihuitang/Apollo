//
//  HistogramView.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-01-07.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit

class HistogramView: UIView {

    var count: Int = 0
    var rawData: [Int] = [0] {
        didSet {
            initBars()
        }
    }
    
    var maxValue: CGFloat {
        return CGFloat(rawData.max()!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //initBars()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        //initBars()
    }
    private func initBars() {
        let width = self.frame.width / CGFloat(rawData.count)
        let height = self.frame.height
        
        guard rawData.count > 0 else { return }
        
        self.subviews.forEach({ $0.removeFromSuperview() })
        var sum: CGFloat = 0
        rawData.forEach({ sum += CGFloat($0) })
        
        for i in 0...rawData.count - 1 {
            //print("bar \(i+1):  \(CGFloat(rawData[i]) * height / maxValue)")
            let size = CGSize(width: width, height: CGFloat(rawData[i]) * height / maxValue)
            let origin = CGPoint(x: CGFloat(i) * width, y: 0)
            let bar = BarView(frame: CGRect(origin: origin, size: size))
            self.addSubview(bar)
        }
    }
    
    func update(index: Int, value: Int) {
        guard index < self.subviews.count else { return }
        let subView = self.subviews[index]
        subView.frame.size.height = CGFloat(value) * self.frame.height / maxValue
        
    }
}
