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
        
        self.selfWidthConstraint = NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: self.gainSelfWidth())
        self.selfWidthConstraint?.isActive = true
        self.selfHeightConstraint = NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: self.gainSelfHeight())
        self.selfHeightConstraint?.isActive = true
        
        NSLayoutConstraint.init(item: self.backgroundView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self.backgroundView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        self.backgroundWidthConstraint = NSLayoutConstraint.init(item: self.backgroundView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: self.gainBackgroundViewWidth())
        self.backgroundHeightConstraint = NSLayoutConstraint.init(item: self.backgroundView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: self.gainBackgroundViewHeight())
        self.backgroundWidthConstraint?.isActive = true
        self.backgroundHeightConstraint?.isActive = true
        
        self.thumbXConstraint = NSLayoutConstraint.init(item: self.thumbView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: -self.gainThumbOffset())
        self.thumbXConstraint?.isActive = true
        NSLayoutConstraint.init(item: self.thumbView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self.thumbView, attribute: .width, relatedBy: .equal, toItem: self.thumbView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        self.thumbWidthConstraint = NSLayoutConstraint.init(item: self.thumbView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 2 * self.localThumbRadius)
        self.thumbWidthConstraint?.isActive = true
        self.thumbView.layer.cornerRadius = self.localThumbRadius
    }
    
    private func updateUI() -> Void {
        self.selfWidthConstraint?.constant = self.gainSelfWidth()
        self.selfHeightConstraint?.constant = self.gainSelfHeight()
        if self.thumbXConstraint!.constant < 0 {
            self.thumbXConstraint?.constant = -self.gainThumbOffset()
        } else {
            self.thumbXConstraint?.constant = self.gainThumbOffset()
        }
        self.thumbWidthConstraint?.constant = 2 * self.localThumbRadius
        self.backgroundWidthConstraint?.constant = self.gainBackgroundViewWidth()
        self.backgroundHeightConstraint?.constant = self.gainBackgroundViewHeight()
        self.backgroundView.layer.cornerRadius = self.localBackgroundRadius
        self.thumbView.layer.cornerRadius = self.localThumbRadius
    }
    
    private func gainSelfWidth() -> CGFloat {
        let widthBackground:CGFloat = self.localSlideDistance + 2 * self.localBackgroundRadius
        let widthThumb:CGFloat = self.slideDistance + 2 * self.localThumbRadius
        return max(widthBackground, widthThumb)
    }
    
    private func gainSelfHeight() -> CGFloat {
        return max(self.localThumbRadius, self.localBackgroundRadius) * 2
    }
    
    private func gainBackgroundViewWidth() -> CGFloat {
        return self.localSlideDistance + 2 * self.backgroundRadius
    }
    
    private func gainBackgroundViewHeight() -> CGFloat {
        return self.localBackgroundRadius * 2
    }
    
    private func gainThumbOffset() -> CGFloat {
        return self.localSlideDistance / 2
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
    internal var thumbRadius:CGFloat {
        set {
            self.localThumbRadius = newValue
            self.updateUI()
        }
        get {
            return self.localThumbRadius
        }
    }/*滑块的半径*/
    internal var slideDistance:CGFloat {
        set {
            self.localSlideDistance = newValue
            self.updateUI()
        }
        get {
            return self.localSlideDistance
        }
    }/*滑块的滑动距离*/
    internal var backgroundRadius:CGFloat {
        set {
            self.localBackgroundRadius = newValue
            self.updateUI()
        }
        get {
            return self.localBackgroundRadius
        }
    }/*背景视图的角半径*/
    
    private var localBackgroundRadius:CGFloat = 12
    private var localSlideDistance:CGFloat = 30
    private var localThumbRadius:CGFloat = 10
    
    private var backgroundWidthConstraint:NSLayoutConstraint?
    private var backgroundHeightConstraint:NSLayoutConstraint?
    private var thumbXConstraint:NSLayoutConstraint?
    private var thumbWidthConstraint:NSLayoutConstraint?
    private var selfWidthConstraint:NSLayoutConstraint?
    private var selfHeightConstraint:NSLayoutConstraint?
    
    private lazy var tapGesture:UITapGestureRecognizer = {
        let result:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureAction(_:)))
        return result
    }()
    private let viewModel:SFSwitchViewModel = SFSwitchViewModel.init()
    private lazy var backgroundView:UIView = {
        let result:UIView = UIView.init()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.isUserInteractionEnabled = false
        result.layer.masksToBounds = true
        result.layer.cornerRadius = self.localBackgroundRadius
        return result
    }()
    private lazy var thumbView:UIView = {
        let result:UIView = UIView.init()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.isUserInteractionEnabled = false
        result.backgroundColor = .white
        result.layer.masksToBounds = true
        return result
    }()
    // MARK: - delegates
}
