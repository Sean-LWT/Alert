//
//  WTAlertConfig.swift
//  Alert
//
//  Created by MacPro on 2022/4/28.
//

import UIKit

open class WTAlertConfig {

    /// 是否需要点击action后关闭
    var dismissWhenTouchAction = true
    /// 圆角
    var cornerRadius: CGFloat = 15
    /// 背景色
    var maskColor = UIColor.black.withAlphaComponent(0.5)
    /// 是否可以点击边缘关闭
    var dismissWhenTouchOutside = false
    /// alert背景
    var contentColor = UIColor.white
    var contentDarkColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    /// 标题布局
    var titlelabelInset = UIEdgeInsets.init(top: 20, left: 15, bottom: 20, right: 15)
    /// 标题颜色
    var titleColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    var titleDarkColor = UIColor.white
    /// 标题字体
    var titleFont = UIFont.init(name: "PingFangSC-Medium", size: 18)!
    /// 内容颜色
    var messageColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    var messageDarkColor = UIColor.white
    /// 内容字体
    var messageFont = UIFont.systemFont(ofSize: 16)
    /// action字体 (alert)
    var alertActionFont = UIFont.systemFont(ofSize: 18)
    /// action字体 (alert destructive)
    var destructiveAlertActionFont = UIFont.systemFont(ofSize: 18)
    /// action字体 (alert cancel)
    var cancelAlertActionFont = UIFont.systemFont(ofSize: 18)
    /// action字体 (actionSheet)
    var actionSheetActionFont = UIFont.systemFont(ofSize: 16)
    /// action字体 (actionSheet destructive)
    var destructiveActionSheetActionFont = UIFont.systemFont(ofSize: 16)
    /// action字体 (actionSheet cancel)
    var cancelActionSheetActionFont = UIFont.systemFont(ofSize: 16)
    /// action颜色 (alert)
    var alertActionColor = UIColor.init(red: 70/255.0, green: 71/255.0, blue: 71/255.0, alpha: 1)
    var alertActionDarkColor = UIColor.white
    /// action颜色 (alert destructive)
    var destructiveAlertActionColor = UIColor.init(red: 255/255.0, green: 81/255.0, blue: 134/255.0, alpha: 1)
    var destructiveAlertActionDarkColor = UIColor.init(red: 255/255.0, green: 81/255.0, blue: 134/255.0, alpha: 1)
    /// action颜色 (alert cancel)
    var cancelAlertActionColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    var cancelAlertActionDarkColor = UIColor.white
    /// action颜色 (actionSheet)
    var actionSheetActionColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    var actionSheetActionDarkColor = UIColor.white
    /// action颜色 (actionSheet destructive)
    var destructiveActionSheetActionColor = UIColor.init(red: 255/255.0, green: 81/255.0, blue: 134/255.0, alpha: 1)
    var destructiveActionSheetActionDarkColor = UIColor.init(red: 255/255.0, green: 81/255.0, blue: 134/255.0, alpha: 1)
    /// action颜色 (actionSheet cancel)
    var cancelActionSheetActionColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    var cancelActionSheetActionDarkColor = UIColor.white
    /// 分割线颜色
    var cropColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 0.1)
    var cropDarkColor = UIColor.white.withAlphaComponent(0.1)
    /// cancel分割线颜色
    var cancelCropColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 0.1)
    var cancelCropDarkColor = UIColor.black.withAlphaComponent(0.3)

}
