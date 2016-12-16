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

    }
}


extension DispatchViewController {
    override func getDemoName() -> String {
        return "Dispatch"
    }
    
    override func getDemoDescription() -> String {
        return "demo"
    }
}
