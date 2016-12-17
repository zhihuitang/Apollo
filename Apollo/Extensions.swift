//
//  Extensions.swift
//  Apollo
//
//  Created by Zhihui Tang on 2016-12-17.
//  Copyright © 2016 Zhihui Tang. All rights reserved.
//

import Foundation


extension NSObject {
    /**
     https://mp.weixin.qq.com/s?__biz=MzI4NjAzODk0OQ==&mid=2652684823&idx=1&sn=97f7ec5e00335777c4aac8c05dcfc42d&chksm=f00b6cddc77ce5cb403302f19c318f3768e7e521ccd400751deb414b4486081e19bd115cb579&scene=0&key=c81d77271180a0e64a22a32ec279b136924c4eda1abf2956a7d3b3c00d791005b2182749ff72c0311ed1d24ecd45ac30ba823057020f43b0b317961341ec120d0b672f268836fedf461ebaebfdcd5b58&ascene=0&uin=MTU5NzI4MTg2MQ%3D%3D&devicetype=iMac+MacBookPro11%2C4+OSX+OSX+10.12.1+build(16B2555)&version=12010110&nettype=WIFI&fontScale=100&pass_ticket=Ngq28lcvcdZLSL9yRAINGArAUddcLKiS%2F4HxviaRA5b9e3W%2FGx8qBeGx64LQBxq0
    */
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
