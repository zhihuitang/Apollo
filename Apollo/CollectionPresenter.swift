//
//  CollectionPresenter.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-08-29.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import AdSupport
import Foundation
import UIKit
import ExternalAccessory
import CoreBluetooth
import SwiftMagic

protocol CollectionDelegate {
    var data: [DeviceInfo] { get }
}

struct DeviceInfo {
    let key: String
    let value: String
}

@available(iOS 10.0, *)
class CollectionPresenter: NSObject, CollectionDelegate, CBCentralManagerDelegate {
    var data: [DeviceInfo] = []
    var centralManager : CBManager?

    required override init() {
        super.init()
        UIDevice.current.isBatteryMonitoringEnabled = true
        self.collect()
        self.startUpCentralManager()
    }
    
    private func collect(){
        //data["IDFA"] = "don't know"
        let (adEnabled, idfa) = getIDFA()
        data.append(DeviceInfo(key: "IDFA enabled", value: String(adEnabled)))
        data.append(DeviceInfo(key: "IDFA", value: idfa))
        data.append(DeviceInfo(key: "Battery State", value: String(UIDevice.current.batteryState.rawValue)))
        data.append(DeviceInfo(key: "Battery Level", value: "\(UIDevice.current.batteryLevel * 100)%"))

        var udid = UIDevice.current.identifierForVendor!.uuidString
        if let _udid = KeychainService.loadPassword() {
            udid = _udid as String
        } else {
            KeychainService.savePassword(token: udid as NSString)
        }
        data.append(DeviceInfo(key: "udid", value: udid))

//        getBlueteethDevices()
        
        if let networkInfo = DeviceKit.getNetWorkInfo() {
            for (name, info) in networkInfo {                
                data.append(DeviceInfo(key: name, value: info))
            }
            
        }
        if let wifiAddr = DeviceKit.getWifiAddr() {
            data.append(DeviceInfo(key: "Wifi Address", value: wifiAddr))
        }
        
        data.append(DeviceInfo(key: "Network Usage", value: "-----------------------------------"))
        let traffic = TrafficCounter()
        //print("usage: \(traffic.usage.description)")
        for (name, usage) in traffic.allUsage {
            data.append(DeviceInfo(key: name, value: usage.description))
        }
    
    }
    
    func getIDFA() -> (Bool,String) {
        let manager = ASIdentifierManager.shared()!

        return (manager.isAdvertisingTrackingEnabled, manager.advertisingIdentifier.uuidString)
    }

    func getBlueteethDevices(){
        let accessories = EAAccessoryManager.shared().connectedAccessories
        if accessories.count < 1 {
            logger.d("no connected accessories")
        } else {
            for accessory in accessories {
                print(accessory.name)
            }
        }
    }
    
    func startUpCentralManager() {
        logger.d("Initializing central manager")
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        logger.d("checking state")
        
        if central.state != .poweredOn {
            // In a real app, you'd deal with all the states correctly
            return
        }
        central.scanForPeripherals(withServices: nil,options:nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
    }
}

