//
//  ViewController.swift
//  OrientationDemo
//
//  Created by feng on 2021/7/7.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type: .custom)
        button.setTitle("点击跳转", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(self.push), for: .touchUpInside)
        button.center = self.view.center
        button.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.addSubview(button)
    }

    @objc func push() {
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }

}

