# XCUserGuideView for swift3

[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE.md)
[![Latest Stable Version](http://img.shields.io/cocoapods/v/XCUserGuideView.svg)](https://github.com/wuchun4/XCDownloadTool)
![Platform](http://img.shields.io/cocoapods/p/XCUserGuideView.svg)


swift 快速实现针对界面控件具体位置的用户引导


## 安装
通过 CocoaPods

```ruby
pod 'XCUserGuideView'
```

##使用方法
```swift
		let tempguide:XCUserGuideView = XCUserGuideView(frame: self.view.bounds)
        let item1:XCUserGuideSharpItem = XCUserGuideSharpItem()
        item1.frame = (button1?.frame)!
        item1.title = "Look up FF or ff in Wiktionary, the free dictionary"
        item1.direction = .up
        item1.sharp = .Circle
        item1.guideView = button1
        tempguide.show(rootView: self.view, item: item1, completion: nil)
```

## 代码许可

The MIT License (MIT). 详情见 [License 文件](https://github.com/wuchun4/XCUserGuideView/blob/master/LICENSE).