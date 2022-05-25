//
//  WTAlertConfig.swift
//  Alert
//
//  Created by MacPro on 2022/4/28.
//

import UIKit

public struct WTAlertConfig {

    public static var `default` = WTAlertConfig.init()

    /// Need to click action to close
    public var dismissWhenTouchAction = true
    /// ContentView radius
    public var cornerRadius: CGFloat = 15
    /// MaskVeiw background color
    public var maskColor = UIColor.black.withAlphaComponent(0.5)
    /// Touch outside to close
    public var dismissWhenTouchOutside = false
    /// Alert background color
    public var contentColor = UIColor.white
    public var contentDarkColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    /// Title inset
    public var titlelabelInset = UIEdgeInsets.init(top: 20, left: 15, bottom: 20, right: 15)
    /// Title color
    public var titleColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    public var titleDarkColor = UIColor.white
    /// Title font
    public var titleFont = UIFont.init(name: "PingFangSC-Medium", size: 18)!
    /// Message color
    public var messageColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    public var messageDarkColor = UIColor.white
    /// Message font
    public var messageFont = UIFont.systemFont(ofSize: 16)
    /// Action font (alert)
    public var alertActionFont = UIFont.systemFont(ofSize: 18)
    /// Action font (alert destructive)
    public var destructiveAlertActionFont = UIFont.systemFont(ofSize: 18)
    /// Action font (alert cancel)
    public var cancelAlertActionFont = UIFont.systemFont(ofSize: 18)
    /// Action font (actionSheet)
    public var actionSheetActionFont = UIFont.systemFont(ofSize: 16)
    /// Action font (actionSheet destructive)
    public var destructiveActionSheetActionFont = UIFont.systemFont(ofSize: 16)
    /// Action font (actionSheet cancel)
    public var cancelActionSheetActionFont = UIFont.systemFont(ofSize: 16)
    /// Action color (alert)
    public var alertActionColor = UIColor.init(red: 70/255.0, green: 71/255.0, blue: 71/255.0, alpha: 1)
    public var alertActionDarkColor = UIColor.white
    /// Action color (alert destructive)
    public var destructiveAlertActionColor = UIColor.init(red: 255/255.0, green: 81/255.0, blue: 134/255.0, alpha: 1)
    public var destructiveAlertActionDarkColor = UIColor.init(red: 255/255.0, green: 81/255.0, blue: 134/255.0, alpha: 1)
    /// Action color (alert cancel)
    public var cancelAlertActionColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    public var cancelAlertActionDarkColor = UIColor.white
    /// Action color (actionSheet)
    public var actionSheetActionColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    public var actionSheetActionDarkColor = UIColor.white
    /// Action color (actionSheet destructive)
    public var destructiveActionSheetActionColor = UIColor.init(red: 255/255.0, green: 81/255.0, blue: 134/255.0, alpha: 1)
    public var destructiveActionSheetActionDarkColor = UIColor.init(red: 255/255.0, green: 81/255.0, blue: 134/255.0, alpha: 1)
    /// Action color (actionSheet cancel)
    public var cancelActionSheetActionColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
    public var cancelActionSheetActionDarkColor = UIColor.white
    /// Split line color
    public var cropColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 0.1)
    public var cropDarkColor = UIColor.white.withAlphaComponent(0.05)
    /// Split line color for cancel
    public var cancelCropColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 0.05)
    public var cancelCropDarkColor = UIColor.black.withAlphaComponent(0.3)
    /// ActionButton touch color
    public var actionTouchColor = UIColor.gray.withAlphaComponent(0.2)
    public var actionTouchDarkColor = UIColor.gray.withAlphaComponent(0.2)

}
