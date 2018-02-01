//
//  Swizzling+Extension.swift
//  Apollo
//
//  Created by Zhihui Tang on 2018-02-01.
//  Copyright © 2018 Zhihui Tang. All rights reserved.
//

import Foundation
import UIKit


// UIView Swizzling
private let swizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    let originalMethod = class_getInstanceMethod(forClass, originalSelector)
    let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    method_exchangeImplementations(originalMethod, swizzledMethod)
}

// ------------------------------------------------------------------------------------------------

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? navcon
        } else {
            return self
        }
    }
    
    static let classInit: Void = {
        logger.d("UIViewController classInit")
        let originalSelector = #selector(viewWillAppear)
        let swizzledSelector = #selector(swizzled_viewWillAppear)
        swizzling(UIViewController.self, originalSelector, swizzledSelector)
    }()
    
    // MARK: - Method Swizzling
    func swizzled_viewWillAppear(animated: Bool) {
        self.swizzled_viewWillAppear(animated: animated)
        logger.i("viewWillAppear: \(self.className)")
        /*
         if let name = self.descriptiveName {
         print("viewWillAppear: \(name)")
         } else {
         print("viewWillAppear: \(self)")
         }
         */
    }
}

// ------------------------------------------------------------------------------------------------

extension UIApplication {
    
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    
    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }
    
}

protocol SelfAware: class {
    static func awake()
}

class NothingToSeeHere {
    
    static func harmlessFunction() {
        logger.d("UIApplication run once")
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass?>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount { (types[index] as? SelfAware.Type)?.awake() }
        types.deallocate(capacity: typeCount)
    }
}


// Custom Class

extension UIView: SelfAware {
    static func awake() {
        let originalSelector = #selector(layoutSubviews)
        let swizzledSelector = #selector(swizzled_layoutSubviews)
        swizzling(UIView.self, originalSelector, swizzledSelector)
    }
    
    // MARK: - Method Swizzling
    func swizzled_layoutSubviews() {
        self.swizzled_layoutSubviews()
        logger.d("layoutSubviews: \(self.className)")
    }
}
