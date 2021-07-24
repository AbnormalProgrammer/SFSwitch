# SFSwitch
我发现iOS中的UISwitch自定义程度太低了，我想自己写一个可以高度定制化的开关控件。
## 示例
![示例](https://github.com/AbnormalProgrammer/SFSwitch/raw/main/resources/example.gif)
## 它是什么？
这是我自己写的开关控件。
## 它有什么用？
我发现UISwitch是无法通过约束改变大小的，这个使用起来很不方便，于是，我自己写了一个实现相同功能的控件。<br>不过功能还在完善中，说明文档也并不面面俱到，具体请看代码。
## 它的需求背景是什么？
UISwitch自定义程度太低，满足不了我的需求。
## 行为表现
1. 默认状态是关，即，false，这一点和UISwitch一样。
2. 可以改变false和true状态的背景颜色。
3. 可以通过约束设定大小。
## 如何使用？
请看下面的代码：<br>
```
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
```
源代码在Sources文件夹里面，请自行取用。
## 适用环境
iOS 14.5及以上
<br>swift 5.0
<br>XCode 12
## 联系方式
我的profile里面有联系方式
## 许可证
本控件遵循MIT许可，详情请见[LICENSE](https://github.com/AbnormalProgrammer/SFQRScaner/blob/main/LICENSE)。
