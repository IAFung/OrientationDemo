//
//  SecondViewController.swift
//  OrientationDemo
//
//  Created by feng on 2021/7/7.
//

import UIKit

class SecondViewController: UIViewController {
    
    var manager: DeviceOrientationManager?
    let label = UILabel(frame: .zero)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.allowAutoRotate = true
//        var orientation = UIDevice.current.orientation
//        print("-----------\(orientation.rawValue)")
//        if !orientation.isLandscape {
//            orientation = .landscapeLeft
//        }
//        
//        setOrientation(orientation)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.allowAutoRotate = false
        manager?.stop()
        setOrientation(.portrait)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        manager = DeviceOrientationManager(delegate: self)
        manager?.startMonitor()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        label.text = "测试转屏"
        label.textColor = .cyan
        label.textAlignment = .center
        view.addSubview(label)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        label.frame = self.view.frame
    }
    
    func setOrientation(_ orientation: UIDeviceOrientation) {
        var rawValue: Int
        if #available(iOS 13.0, *) {
            rawValue = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.rawValue ?? 0
        } else {
           rawValue = UIApplication.shared.statusBarOrientation.rawValue
        }
        
        if rawValue != UIDevice.current.orientation.rawValue {
            UIDevice.current.setValue(NSNumber(value: rawValue), forKey: "orientation")
        }
        UIDevice.current.setValue(NSNumber(value: orientation.rawValue), forKey: "orientation")
    }
    

}
extension SecondViewController: DeviceOrientationDelegate {
    func directionChanged(_ type: UIInterfaceOrientation) {
        switch type {
        case .landscapeLeft:
            setOrientation(.landscapeLeft)
        case .landscapeRight:
            setOrientation(.landscapeRight)
        default:
            break
        }
    }
}
