//
//  Extensions.swift
//  Apollo
//
//  Created by Zhihui Tang on 2016-12-17.
//  Copyright © 2016 Zhihui Tang. All rights reserved.
//

import Foundation


extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
