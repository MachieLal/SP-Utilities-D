//
//  MotionSensorManager.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 6/8/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import UIKit
import CoreMotion

class MotionSensorManager {
    private let updateInterval: TimeInterval = 10
    static let sharedInstance = MotionSensorManager()
    
    private let manager = CMMotionManager()
    
    func startDeviceMotionUpdates() {
        let operationQueue = OperationQueue.main
//        operationQueue.qualityOfService = .userInitiated
        operationQueue.maxConcurrentOperationCount = 2
        
        manager.accelerometerUpdateInterval = updateInterval
        manager.gyroUpdateInterval = updateInterval
        manager.magnetometerUpdateInterval = updateInterval
        manager.deviceMotionUpdateInterval = updateInterval
        
//        if manager.isGyroAvailable {
//            manager.startGyroUpdates(to: operationQueue) { (data, _) in
//                if let gyroData = data {
//                    print("DEBUG---gyroData - - x:\(ceil(gyroData.rotationRate.x)), y:\(ceil(gyroData.rotationRate.y)), z:\(ceil(gyroData.rotationRate.z))")
//                }
//            }
//        }
        
//        if manager.isAccelerometerAvailable {
//            manager.startAccelerometerUpdates(to: operationQueue) { (data, _) in
//                if let accelerometerData = data {
//                    let acceleration = accelerometerData.acceleration
//                    print("DEBUG---accelerometerData - - \(acceleration)")
//                    let magnitude = ceil(sqrt(pow(acceleration.x, 2) + pow(acceleration.y, 2) + pow(acceleration.z, 2)))
//                    print("DEBUG---accelerometerData - magnitude - \(magnitude)")
//                }
//            }
//        }
        
//        if manager.isMagnetometerAvailable {
//            manager.startMagnetometerUpdates(to: operationQueue) { (data, _) in
//                if let magnetometerData = data {
//                    print("DEBUG---magnetometerData -\(Date(timeIntervalSinceNow: magnetometerData.timestamp))- \(magnetometerData)")
//                }
//            }
//        }
        
        if manager.isDeviceMotionAvailable {
            manager.startDeviceMotionUpdates(to: operationQueue) { (data, _) in
                if let motionData = data {
                    print("DEBUG---motionData -\(Date(timeIntervalSinceNow: motionData.timestamp))- \(motionData)")
                    print("\n")
                    print("\n")
                    print("\n")
                }
            }
        }
    }
    
    func stopDeviceMotionUpdates() {
        if manager.isGyroActive {
            manager.stopGyroUpdates()
        }
        
        if manager.isAccelerometerActive {
            manager.stopAccelerometerUpdates()
        }
        
        if manager.isMagnetometerActive {
            manager.stopMagnetometerUpdates()
        }
        
        if manager.isDeviceMotionActive {
            manager.stopDeviceMotionUpdates()
        }
    }
}
