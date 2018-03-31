# XCUserGuideView for swift3

[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE.md)
[![Latest Stable Version](http://img.shields.io/cocoapods/v/XCUserGuideView.svg)](https://github.com/wuchun4/XCDownloadTool)
![Platform](http://img.shields.io/cocoapods/p/XCUserGuideView.svg)


Rapid implementation in the light of the concrete position of the user interface controls

![image](https://github.com/wuchun4/XCUserGuideView/blob/master/2017-03-22%2016.49.36.gif)

## Install
[CocoaPods](http://cocoapods.org)

```ruby
pod 'XCUserGuideView'
```

## Here's an example:
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

## License

The MIT License (MIT). See [License 文件](https://github.com/wuchun4/XCUserGuideView/blob/master/LICENSE).
