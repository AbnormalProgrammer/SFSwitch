//
//  SFSwitch.swift
//  Demo
//
//  Created by Stroman on 2021/7/24.
//

import UIKit

class SFSwitch: UIView {
    // MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.customInitilizer()
        self.installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        self.viewModel.removeObserver(self, forKeyPath: "isOn")
        print("\(type(of: self))释放了")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if self.viewModel === object as? SFSwitchViewModel {
            switch keyPath {
            case "isOn":
                if self.viewModel.isOn == true {
                    UIView.animate(withDuration: self.viewModel.animationDuration) {
                        self.backgroundView.backgroundColor = self.viewModel.onBackgroundColor
                        self.thumbXConstraint!.constant = -self.thumbXConstraint!.constant
                        self.setNeedsLayout()
                        self.layoutIfNeeded()
                    }
                } else {
                    UIView.animate(withDuration: self.viewModel.animationDuration) {
                        self.backgroundView.backgroundColor = self.viewModel.offBackgroundColor
                        self.thumbXConstraint!.constant = -self.thumbXConstraint!.constant
                        self.setNeedsLayout()
                        self.layoutIfNeeded()
                    }
                }
            default:break
            }
        }
    }
    // MARK: - custom methods
    private func customInitilizer() -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addGestureRecognizer(self.tapGesture)
        self.backgroundColor = UIColor.clear
        self.viewModel.addObserver(self, forKeyPath: "isOn", options: .new, context: nil)
        if self.viewModel.isOn == true {
            self.backgroundView.backgroundColor = self.onBackgroundColor
        } else {
            self.backgroundView.backgroundColor = self.offBackgroundColor
        }
    }
    
    private func installUI() -> Void {
        self.addSubview(self.backgroundView)
        self.addSubview(self.thumbView)
        
        NSLayoutConstraint.init(item: self.backgroundView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self.backgroundView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self.backgroundView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 100).isActive = true
        NSLayoutConstraint.init(item: self.backgroundView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 50).isActive = true
        
        self.thumbXConstraint = NSLayoutConstraint.init(item: self.thumbView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: self.thumbOffset)
        self.thumbXConstraint?.isActive = true
        NSLayoutConstraint.init(item: self.thumbView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self.thumbView, attribute: .width, relatedBy: .equal, toItem: self.thumbView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self.thumbView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 40).isActive = true
    }
    // MARK: - public interfaces
    // MARK: - actions
    @objc private func tapGestureAction(_ sender:UITapGestureRecognizer) -> Void {
        self.viewModel.isOn = !self.viewModel.isOn
        self.resultClosure?(self.viewModel.isOn)
    }
    // MARK: - accessors
    internal var onBackgroundColor:UIColor? {
        set {
            guard let nonnilColor = newValue else {
                return
            }
            self.viewModel.onBackgroundColor = nonnilColor
        }
        get {
            return self.viewModel.onBackgroundColor
        }
    }
    internal var offBackgroundColor:UIColor? {
        set {
            guard let nonnilColor = newValue else {
                return
            }
            self.viewModel.offBackgroundColor = nonnilColor
        }
        get {
            return self.viewModel.offBackgroundColor
        }
    }
    internal var isOn:Bool {
        set {
            self.viewModel.isOn = newValue
        }
        get {
            return self.viewModel.isOn
        }
    }
    internal var resultClosure:((Bool) -> Void)?
    
    private let thumbOffset:CGFloat = -50
    private var thumbXConstraint:NSLayoutConstraint?
    private lazy var tapGesture:UITapGestureRecognizer = {
        let result:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureAction(_:)))
        return result
    }()
    private let viewModel:SFSwitchViewModel = SFSwitchViewModel.init()
    private lazy var backgroundView:UIView = {
        let result:UIView = UIView.init()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.isUserInteractionEnabled = false
        return result
    }()
    private lazy var thumbView:UIView = {
        let result:UIView = UIView.init()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.isUserInteractionEnabled = false
        result.backgroundColor = .white
        return result
    }()
    // MARK: - delegates
}
