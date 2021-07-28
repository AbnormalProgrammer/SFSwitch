//
//  ViewController.swift
//  Demo
//
//  Created by Stroman on 2021/7/24.
//

import UIKit

class ViewController: UIViewController,SFSwitchProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.customSwitch)
        
        self.customSwitch.resultClosure = {status in
            print("这是闭包回调:",status)
        }
        
        NSLayoutConstraint.init(item: self.customSwitch, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self.customSwitch, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        // Do any additional setup after loading the view.
    }


    private lazy var customSwitch:SFSwitch = {
        let result:SFSwitch = SFSwitch.init()
        result.delegate = self
        return result
    }()
    
    func SFSwitchStatusChanged(_ status: Bool) {
        print("这是代理方法:",status)
    }
}

