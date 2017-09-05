//
//  TrafficCounter.swift
//  TrafficPolice
//
//  Created by 刘栋 on 2016/11/17.
//  Copyright © 2016年 anotheren.com. All rights reserved.
//

import Foundation
//import ifaddrs

public struct TrafficCounter {
    
    public init() { }
    
    public var usage: TrafficPackage {
        var result: TrafficPackage = .zero
        var addrsPointer: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&addrsPointer) == 0 {
            var pointer = addrsPointer
            while pointer != nil {
                if let addrs = pointer?.pointee {
                    let name = String(cString: addrs.ifa_name)
                    if addrs.ifa_addr.pointee.sa_family == UInt8(AF_LINK) {
                        if name.hasPrefix("en") { // Wifi
                            let networkData = unsafeBitCast(addrs.ifa_data, to: UnsafeMutablePointer<if_data>.self)
                            result.wifi.received += networkData.pointee.ifi_ibytes
                            result.wifi.sent += networkData.pointee.ifi_obytes
                        } else if name.hasPrefix("pdp_ip") { // WWAN
                            let networkData = unsafeBitCast(addrs.ifa_data, to: UnsafeMutablePointer<if_data>.self)
                            result.wwan.received += networkData.pointee.ifi_ibytes
                            result.wwan.sent += networkData.pointee.ifi_obytes
                        }
                    }
                }
                pointer = pointer?.pointee.ifa_next
            }
            freeifaddrs(addrsPointer)
        }
        return result
    }
    
    public var allUsage: [String: TrafficData] {
        var result = [String: TrafficData]()
        var addrsPointer: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&addrsPointer) == 0 {
            var pointer = addrsPointer
            while pointer != nil {
                if let addrs = pointer?.pointee {
                    let name = String(cString: addrs.ifa_name)
                    if addrs.ifa_addr.pointee.sa_family == UInt8(AF_LINK) {                        
                        let networkData = unsafeBitCast(addrs.ifa_data, to: UnsafeMutablePointer<if_data>.self)
                        if var addr = result[name] {
                            addr.received += networkData.pointee.ifi_ibytes
                            addr.sent += networkData.pointee.ifi_obytes
                            result[name] = addr
                        } else {
                            let addr = TrafficData(received: networkData.pointee.ifi_ibytes, sent: networkData.pointee.ifi_obytes)
                            result[name] = addr
                        }
                    }
                }
                pointer = pointer?.pointee.ifa_next
            }
            freeifaddrs(addrsPointer)
        }

        return result
    }
}
