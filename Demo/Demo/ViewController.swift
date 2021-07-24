//
//  ViewController.swift
//  Demo
//
//  Created by Stroman on 2021/7/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.customSwitch)
        
        self.customSwitch.resultClosure = {status in
            print(status)
        }
        
        NSLayoutConstraint.init(item: self.customSwitch, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self.customSwitch, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        // Do any additional setup after loading the view.
    }


    private lazy var customSwitch:SFSwitch = {
        let result:SFSwitch = SFSwitch.init()
        return result
    }()
}

