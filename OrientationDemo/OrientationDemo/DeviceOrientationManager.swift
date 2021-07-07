//
//  DeviceOrientationManager.swift
//  EQS
//
//  Created by feng on 2021/7/5.
//  Copyright © 2021 ShuXun. All rights reserved.
//

import UIKit
import CoreMotion

protocol DeviceOrientationDelegate {
    func directionChanged(_ type: UIInterfaceOrientation)
}

class DeviceOrientationManager: NSObject {
    private var motionManager = CMMotionManager()
    private let sensitive: Float = 0.77
    private var delegate: DeviceOrientationDelegate
    private var currentDirection: UIInterfaceOrientation = .portrait
    init(delegate: DeviceOrientationDelegate) {
        self.delegate = delegate
    }
    
    func startMonitor() {
        start()
    }
    func stop() {
        motionManager.stopDeviceMotionUpdates()
    }
    func start() {
        motionManager.deviceMotionUpdateInterval = 0.7
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current ?? OperationQueue.main) { (motion, error) in
                OperationQueue.main.addOperation {
                    if let mo = motion {
                        self.deviceMotion(motion: mo)
                    }
                }
            }
        }
    }
    func deviceMotion(motion: CMDeviceMotion) {
        let x = motion.gravity.x
        let y = motion.gravity.y
        if y < 0 {
            if fabs(y) > Double(sensitive) {
                if currentDirection != .portrait {
                    currentDirection = .portrait
                    delegate.directionChanged(currentDirection)
                }
            }
        } else {
            if y > Double(sensitive) {
                if currentDirection != .portraitUpsideDown {
                    currentDirection = .portraitUpsideDown
                    delegate.directionChanged(.portraitUpsideDown)
                }
            }
        }
        if x < 0 {
            if fabs(x) > Double(sensitive) {
                if currentDirection != .landscapeLeft {
                    currentDirection = .landscapeLeft
                    delegate.directionChanged(currentDirection)
                }
            }
        } else {
            if x > Double(sensitive) {
                if currentDirection != .landscapeRight {
                    currentDirection = .landscapeRight
                    delegate.directionChanged(.landscapeRight)
                }
            }
        }
    }
    
}

