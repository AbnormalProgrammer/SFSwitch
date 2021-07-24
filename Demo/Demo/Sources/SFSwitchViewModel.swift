//
//  SFSwitchViewModel.swift
//  Demo
//
//  Created by Stroman on 2021/7/24.
//

import UIKit

class SFSwitchViewModel: NSObject {
    // MARK: - lifecycle
    deinit {
        print("\(type(of: self))释放了")
    }
    
    override init() {
        super.init()
        self.customInitilizer()
    }
    // MARK: - custom methods
    private func customInitilizer() -> Void {
    }
    // MARK: - public interfaces
    // MARK: - actions
    // MARK: - accessors
    internal let animationDuration:TimeInterval = 0.25//动画的时间
    internal var onBackgroundColor:UIColor = UIColor.systemGreen
    internal var offBackgroundColor:UIColor = UIColor.systemGray
    
    @objc dynamic internal var isOn:Bool = false
    // MARK: - delegates
}
