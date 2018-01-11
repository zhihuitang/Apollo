//
//  DataProvider.swift
//  SwiftMagic
//
//  Created by Zhihui Tang on 2018-01-09.
//

import Foundation
import MessageUI


extension UIWindow {
    open override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        Logger.shared.save()
        let manager = LoggerManager()
        manager.show()
    }
}

class LoggerManager: NSObject {
    public func show() {
        let controller = LoggerViewController()
        UIApplication.topViewController()?.present(controller, animated: true, completion: nil)
    }
}
