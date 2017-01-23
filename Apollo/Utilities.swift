//
//  Utilities.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-01-23.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit

// 当前系统版本
let kCersion = (UIDevice.current.systemVersion as NSString).floatValue
// 屏幕宽度
let kScreenH = UIScreen.main.bounds.height
// 屏幕高度
let kScreenW = UIScreen.main.bounds.width



func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
