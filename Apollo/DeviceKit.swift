//
//  DeviceKit.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-09-05.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import Foundation

class DeviceKit {
    /**
     https://stackoverflow.com/questions/31220371/detect-hotspot-enabling-in-ios-with-private-apis
     
     
     https://stackoverflow.com/questions/30748480/swift-get-devices-ip-address
     */
    class func getNetWorkInfo() -> [String:String]? {
        var address : String?
        var networkInfo = [String:String]()
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                //print("network name: \(name)")
                //if  name == "en0" {
                
                // Convert interface address to a human readable string:
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                            &hostname, socklen_t(hostname.count),
                            nil, socklen_t(0), NI_NUMERICHOST)
                address = String(cString: hostname)
                networkInfo[name] = address
                //}
            }
        }
        freeifaddrs(ifaddr)
        
        return networkInfo
    }
    
    class func getWifiAddr() -> String? {
        return getNetWorkInfo()?["en0"]
    }

}
