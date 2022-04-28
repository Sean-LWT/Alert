//
//  WTAlertConfig.swift
//  Alert
//
//  Created by MacPro on 2022/4/28.
//

import UIKit

open class WTAlertConfig {

    /// 是否需要点击action后关闭
    open var dismissWhenTouchAction = true
    /// 圆角
    open var cornerRadius: CGFloat = 15
    /// 背景色
    open var maskColor = UIColor.black.withAlphaComponent(0.5)
    /// 是否可以点击边缘关闭
    open var dismissWhenTouchOutside = false
    /// alert背景
    open var contentColor = UIColor.white
    open var contentDarkColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    /// 标题布局
    open var titlelabelInset = UIEdgeInsets.init(top: 20, left: 15, bottom: 20, right: 15)
    /// 标题颜色
    open var titleColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    open var titleDarkColor = UIColor.white
    /// 标题字体
    open var titleFont = UIFont.init(name: "PingFangSC-Medium", size: 18)!
    /// 内容颜色
    open var messageColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    open var messageDarkColor = UIColor.white
    /// 内容字体
    open var messageFont = UIFont.systemFont(ofSize: 16)
    /// action字体 (alert)
    open var alertActionFont = UIFont.systemFont(ofSize: 18)
    /// action字体 (alert destructive)
    open var destructiveAlertActionFont = UIFont.systemFont(ofSize: 18)
    /// action字体 (alert cancel)
    open var cancelAlertActionFont = UIFont.systemFont(ofSize: 18)
    /// action字体 (actionSheet)
    open var actionSheetActionFont = UIFont.systemFont(ofSize: 16)
    /// action字体 (actionSheet destructive)
    open var destructiveActionSheetActionFont = UIFont.systemFont(ofSize: 16)
    /// action字体 (actionSheet cancel)
    open var cancelActionSheetActionFont = UIFont.systemFont(ofSize: 16)
    /// action颜色 (alert)
    open var alertActionColor = UIColor.init(red: 70/255.0, green: 71/255.0, blue: 71/255.0, alpha: 1)
    open var alertActionDarkColor = UIColor.white
    /// action颜色 (alert destructive)
    open var destructiveAlertActionColor = UIColor.init(red: 255/255.0, green: 81/255.0, blue: 134/255.0, alpha: 1)
    open var destructiveAlertActionDarkColor = UIColor.init(red: 255/255.0, green: 81/255.0, blue: 134/255.0, alpha: 1)
    /// action颜色 (alert cancel)
    open var cancelAlertActionColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    open var cancelAlertActionDarkColor = UIColor.white
    /// action颜色 (actionSheet)
    open var actionSheetActionColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    open var actionSheetActionDarkColor = UIColor.white
    /// action颜色 (actionSheet destructive)
    open var destructiveActionSheetActionColor = UIColor.init(red: 255/255.0, green: 81/255.0, blue: 134/255.0, alpha: 1)
    open var destructiveActionSheetActionDarkColor = UIColor.init(red: 255/255.0, green: 81/255.0, blue: 134/255.0, alpha: 1)
    /// action颜色 (actionSheet cancel)
    open var cancelActionSheetActionColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    open var cancelActionSheetActionDarkColor = UIColor.white
    /// 分割线颜色
    open var cropColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 0.1)
    open var cropDarkColor = UIColor.white.withAlphaComponent(0.1)
    /// cancel分割线颜色
    open var cancelCropColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 0.1)
    open var cancelCropDarkColor = UIColor.black.withAlphaComponent(0.3)

}
