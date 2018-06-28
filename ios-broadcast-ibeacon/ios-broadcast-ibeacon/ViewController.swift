//
//  ViewController.swift
//  ios-broadcast-ibeacon
//
//  Created by Surattikorn Chumkaew on 28/6/2561 BE.
//  Copyright © 2561 example. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralManagerDelegate {
    
    var region: CLBeaconRegion?
    var peripheralData: NSDictionary?
    var peripheralManager: CBPeripheralManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.region = createBeaconRegion()
        (self.peripheralManager, self.peripheralData) = createPeripheralDevice(region: region!)
    }

    func createBeaconRegion() -> CLBeaconRegion? {
        let proximityUUID = UUID(uuidString:
            "00112233-4455-6677-8899-AABBCCDDEEFF")
        let major : CLBeaconMajorValue = 123
        let minor : CLBeaconMinorValue = 456
        let beaconID = "com.example.ios-broadcast-ibeacon"
        
        return CLBeaconRegion(proximityUUID: proximityUUID!, major: major,
                              minor: minor, identifier: beaconID)
    }
    
    func createPeripheralDevice(region : CLBeaconRegion) -> (CBPeripheralManager?, NSDictionary?) {
        let peripheral = CBPeripheralManager(delegate: self, queue: nil)
        let peripheralData = region.peripheralData(withMeasuredPower: nil)
        return (peripheral, peripheralData)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            print(".poweredOn")
            peripheral.startAdvertising(((peripheralData as NSDictionary!) as! [String : Any]))
        case .poweredOff:
            print(".poweredOff")
            peripheral.stopAdvertising()
        default:
            print("default")
            peripheral.stopAdvertising()
        }
    }


}

