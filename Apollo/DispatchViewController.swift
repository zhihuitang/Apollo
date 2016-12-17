//
//  DispatchViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2016-12-16.
//  Copyright © 2016 Zhihui Tang. All rights reserved.
//

import UIKit

/**
 https://mp.weixin.qq.com/s?__biz=MzI4NjAzODk0OQ==&mid=2652684817&idx=1&sn=924f6593823a880132c239c707de1385&chksm=f00b6cdbc77ce5cdb8becea5b0ccfcfb877c2db7d92d7f48ef766798c06fea928a67adc770f0&scene=0&key=c81d77271180a0e6bf71a85ab7bb56d31f9a83cae672dce6161024fc71fe26afb55f36f92854652f71f1c8acfd251ed10a06c9eaf7f584a253b8508167eba1418ebb98a3f6cf1a1c2fe704e41e42ea83&ascene=0&uin=MTU5NzI4MTg2MQ%3D%3D&devicetype=iMac+MacBookPro11%2C4+OSX+OSX+10.12.1+build(16B2555)&version=12010110&nettype=WIFI&fontScale=100&pass_ticket=Ngq28lcvcdZLSL9yRAINGArAUddcLKiS%2F4HxviaRA5b9e3W%2FGx8qBeGx64LQBxq0
 */

class DispatchViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dispatchGo(_ sender: UIButton) {
        let queue = DispatchQueue(label: "com.appcoda.myqueue")
        queue.async {
            for i in 0..<10 {
                print("🍎 \(i)")
            }
        }
        
        for i in 100..<110 {
            print("🍏 \(i)")
        }
        
    }
    @IBAction func queueWithQos(_ sender: Any) {
        let queue1 = DispatchQueue(label: "com.appcoda.queue1", qos: DispatchQoS.userInitiated)
        let queue2 = DispatchQueue(label: "com.appcoda.queue2", qos: DispatchQoS.utility)
        
        queue1.async {
            for i in 0..<10 {
                print("🍎 \(i)")
            }
        }

        queue2.async {
            for i in 100..<110 {
                print("🍏 \(i)")
            }
        }

        DispatchQueue.main.asyncAfter(deadline: 10 ) {
            print("finished 👌")
        }
    }
    

}


/*
 https://mp.weixin.qq.com/s?__biz=MzI4NjAzODk0OQ==&mid=2652684823&idx=1&sn=97f7ec5e00335777c4aac8c05dcfc42d&chksm=f00b6cddc77ce5cb403302f19c318f3768e7e521ccd400751deb414b4486081e19bd115cb579&scene=0&key=c81d77271180a0e64a22a32ec279b136924c4eda1abf2956a7d3b3c00d791005b2182749ff72c0311ed1d24ecd45ac30ba823057020f43b0b317961341ec120d0b672f268836fedf461ebaebfdcd5b58&ascene=0&uin=MTU5NzI4MTg2MQ%3D%3D&devicetype=iMac+MacBookPro11%2C4+OSX+OSX+10.12.1+build(16B2555)&version=12010110&nettype=WIFI&fontScale=100&pass_ticket=Ngq28lcvcdZLSL9yRAINGArAUddcLKiS%2F4HxviaRA5b9e3W%2FGx8qBeGx64LQBxq0
 */


extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}

extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}


extension DispatchViewController {
  
    override var name: String {
        return "Dispatch demo"
    }
    
}
