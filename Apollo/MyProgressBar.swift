//
//  MyProgressBar.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-11-20.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit

@IBDesignable class MyProgressBar: UIView {
    
    //显示进度的文本标签
    private let textLabel = UILabel()
    
    //显示当前进度区域
    private let bar = UIView()
    
    //进度
    @IBInspectable var percent: Int = 0 {
        didSet {
            if percent > 100 {
                percent = 100
            }else if percent < 0 {
                percent = 0
            }
            textLabel.text =  "\(percent)%"
            setNeedsLayout()
        }
    }
    
    //文本颜色
    @IBInspectable var color: UIColor = .white {
        didSet {
            textLabel.textColor = color
        }
    }
    
    //进度条颜色
    @IBInspectable var barColor: UIColor = UIColor.orange {
        didSet {
            bar.backgroundColor = barColor
        }
    }
    
    //进度条背景颜色
    @IBInspectable var barBgColor: UIColor = UIColor.lightGray {
        didSet {
            layer.backgroundColor = barBgColor.cgColor
        }
    }
    
    //init方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetup()
    }
    
    //init方法
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialSetup()
    }
    
    //页面初始化相关设置
    private func initialSetup() -> Void {
        bar.backgroundColor = self.barColor
        addSubview(bar)
        
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.textColor = self.color
        textLabel.text = "\(self.percent)%"
        addSubview(textLabel)
    }
    
    //布局相关设置
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.backgroundColor = self.barBgColor.cgColor
        
        var barFrame = bounds
        barFrame.size.width *= (CGFloat(self.percent) / 100)
        bar.frame = barFrame
        
        textLabel.frame = bounds
    }
}
