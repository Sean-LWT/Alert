# WTAlertController


[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-Swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![Version](https://img.shields.io/cocoapods/v/WTAlertController.svg?style=flat-square)](http://cocoapods.org/pods/WTAlertController)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)

WTAlertController是一个基于Swift的高可用视图框架。基于iOS原生的UIAlertController功能进行封装，并提供了其他自定义样式的接口，扩展灵活，能让App快速创建自己想要的样式。


## 效果预览

<div>
	<img src="https://raw.githubusercontent.com/Sean-LWT/Alert/main/Asset/1.png" width = "10%" div/>
	<img src="https://raw.githubusercontent.com/Sean-LWT/Alert/main/Asset/2.png" width = "10%" div/>
	<img src="https://raw.githubusercontent.com/Sean-LWT/Alert/main/Asset/3.png" width = "10%" div/>
	<img src="https://raw.githubusercontent.com/Sean-LWT/Alert/main/Asset/4.png" width = "10%" div/>
	<img src="https://raw.githubusercontent.com/Sean-LWT/Alert/main/Asset/5.png" width = "10%" div/>
</div>

## 特性

- [x] 基于纯Swift开发
- [x] 支持UIAlertController样式
- [x] 支持横屏和竖屏
- [x] 支持修改相关展示样式
- [x] 支持自定义样式

## 要求

- iOS 11.0+
- Xcode 13.0+
- Swift 5.5+

## 安装

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

把这个添加到 `Podfile` 并更新依赖:

```ruby
pod 'WTAlertController'
```

### Swift Package Manager

添加Package
```swift
dependencies: [
    .Package(url: "https://github.com/Sean-LWT/Alert.git")
]
```

### 其他

Sources/WTAlertController/ 将此目录下的文件拷贝到项目中即可

## 使用

在需要的地方导入 WTAlertController
```swift
import WTAlertController
```

### 快速开始

```swift
let alert = WTAlertController.init(title: "标题", message: "内容", preferredStyle: .actionSheet)
alert.addAction(.init(title: "取消", style: .cancel))
alert.addAction(.init(title: "确定", style: .default))
self.present(alert, animated: true)
```

### 自定义样式

```swift
// titleView
alert.addTitleViews { width in
	let customView = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 59))
	customView.numberOfLines = 0
	customView.attributedText = .init(string: "我是一个自定义的titleView\n😄你想放什么都可以啊", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.red])
    customView.textAlignment = .center
	return customView
}
// action
alert.addAction(.init(style: .default, customBlock: { width in
	let customView = UIButton.init(type: .custom)
	customView.frame = .init(origin: .zero, size: .init(width: width, height: 80))
	customView.backgroundColor = .systemOrange
	customView.setAttributedTitle(.init(string: "我是一个自定义的选项", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.blue]), for: .normal)
	return customView
}))
```

### 替换全局样式

```swift
var config = WTAlertConfig.default
config.cornerRadius = 10
// 其他样式
...
WTAlertConfig.default = config
```

## License

```
MIT License
```
