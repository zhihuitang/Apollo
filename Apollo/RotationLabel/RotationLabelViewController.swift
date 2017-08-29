//
//  RotationLabelViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-08-01.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit
import CoreTelephony

class RotationLabelViewController: BaseViewController {

    @IBOutlet weak var rotationLabel: RotationLabel!
    override var name: String {
        return "RotationLabel Demo"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rotationLabel.texts = ["aa","bb","cc"]
        // Do any additional setup after loading the view.
        
        
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider
        print("carrier name: \(carrier?.carrierName ?? "not available")")
        
        let device = UIDevice.current
        print("systemVersion: \(device.systemVersion), battery: \(device.batteryState.rawValue)")
        
        report_memory()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func report_memory() {
        var taskInfo = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            print("Memory used in bytes: \(taskInfo.resident_size)")
        }
        else {
            print("Error with task_info(): " +
                (String(cString: mach_error_string(kerr), encoding: String.Encoding.ascii) ?? "unknown error"))
        }
        
        print("total memory in MB: \(ProcessInfo.processInfo.physicalMemory/1024/1024)")
    }
    
    
}
