//
//  HistogramView.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-01-07.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit

@IBDesignable
class HistogramView: UIView {

    @IBInspectable
    var barCount: Int = 0 {
        didSet{
            rawData = self.randomData(size: barCount, range: 100)
            setNeedsDisplay()
        }
    }

    var rawData: [Int] = [1] {
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
    
    override func draw(_ rect: CGRect) {
        initBars()
    }
    
    func update(index: Int, value: Int) {
        guard index < self.subviews.count else { return }
        let subView = self.subviews[index]
        subView.frame.size.height = CGFloat(value) * self.frame.height / maxValue
        
    }
    
    private func randomData(size length: Int, range: Int) -> [Int] {
        var result: [Int] = []
        for _ in 0..<length {
            result.append(Int(arc4random_uniform(UInt32(range))))
        }
        return result
    }
}
