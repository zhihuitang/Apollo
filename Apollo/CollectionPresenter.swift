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

protocol CollectionDelegate {
    var data: [DeviceInfo] { get }
}

struct DeviceInfo {
    let key: String
    let value: String
}

class CollectionPresenter: CollectionDelegate {
    var data: [DeviceInfo] = []

    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        collect()
    }
    
    private func collect(){
        //data["IDFA"] = "don't know"
        let (adEnabled, idfa) = getIDFA()
        data.append(DeviceInfo(key: "IDFA enabled", value: String(adEnabled)))
        data.append(DeviceInfo(key: "IDFA", value: idfa))
        data.append(DeviceInfo(key: "Battery State", value: String(UIDevice.current.batteryState.rawValue)))
        data.append(DeviceInfo(key: "Battery Level", value: "\(UIDevice.current.batteryLevel * 100)%"))

    }
    
    func getIDFA() -> (Bool,String) {
        let manager = ASIdentifierManager.shared()!

        return (manager.isAdvertisingTrackingEnabled, manager.advertisingIdentifier.uuidString)
    }
}
