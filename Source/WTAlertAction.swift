//
//  WTAlertViewAction.swift
//  Example
//
//  Created by MacPro on 2021/4/20.
//

import UIKit

public class WTAlertAction {

    public typealias CustomBlock = (_ width: CGFloat) -> UIView

    public typealias Handler = (WTAlertAction) -> Void

    /// 唯一标识
    public let identify = UUID.init().uuidString

    /// 自定义UI block
    private(set) var customBlock: CustomBlock

    /// 回调 block
    private(set) var handler: Handler?

    public enum Style {
        case `default`
        case cancel
        case destructive
    }
    /// 展示类型
    public let style: Style

    public var isEnabled = true

    public init(style: Style, customBlock: @escaping CustomBlock) {
        self.style = style
        self.customBlock = customBlock
    }
    public init(title: String?, style: Style, handler: Handler? = nil) {
        self.style = style
        self.handler = handler
        self.customBlock = { _ in WTActionButton.init(title: title) }
    }

}
