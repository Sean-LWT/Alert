//
//  WTAlertController.swift
//  Example
//
//  Created by MacPro on 2021/4/20.
//

import UIKit

public class WTAlertController: WTAlertBaseController {

    public enum Style {
        case alert
        case actionSheet
    }
    private(set) var style: Style = .alert
    public var preferredStyle: Style {
        self.style
    }

    private var alertTitle: String?
    private var alertMessage: String?

    let titleView = UIScrollView.init()
    let actionView = UIScrollView.init()
    /// TitleView height
    private var titleViewHeight: CGFloat = 0.0
    /// ActionView height
    private var actionViewHeight: CGFloat = 0.0

    /// Title/action split line
    let lineView = UIView.init()

    public convenience init() {
        self.init(animate: .init())
    }
    public convenience init(title: String?, message: String?, preferredStyle: Style) {
        switch preferredStyle {
        case .alert:
            self.init(animate: .init())
        case .actionSheet:
            self.init(animate: .init(animatedStyle: .actionSheet))
            self.config.dismissWhenTouchOutside = true
        }
        self.alertTitle = title
        self.alertMessage = message
        self.style = preferredStyle
    }
    private override init(animate: WTAlertBaseController.Animate) {
        super.init(animate: animate)
    }
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.35) {
                self.layoutContentView()
            }
        }
    }
    override func setUI() {
        super.setUI()
        self.contentView.clipsToBounds = true
        if #available(iOS 13.0, *) {
            let contentColor = self.config.contentColor
            let contentDarkColor = self.config.contentDarkColor
            self.contentView.backgroundColor = .init(dynamicProvider: { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .light:
                    return contentColor
                default:
                    return contentDarkColor
                }
            })
        } else {
            self.contentView.backgroundColor = self.config.contentColor
        }
        switch self.style {
        case .alert:
            self.contentView.frame = .init(x: 0, y: 0, width: 270, height: 0)
        case .actionSheet:
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                self.contentView.frame = .init(x: 0, y: 0, width: 500, height: 0)
            default:
                self.contentView.frame = .init(x: 0, y: 0, width: min(self.view.bounds.width, self.view.bounds.height), height: 0)
            }
        }
        // Split line
        if #available(iOS 13.0, *) {
            let cropColor = self.config.cropColor
            let cropDarkColor = self.config.cropDarkColor
            self.lineView.backgroundColor = UIColor.init(dynamicProvider: { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .light:
                    return cropColor
                default:
                    return cropDarkColor
                }
            })
        } else {
            self.lineView.backgroundColor = self.config.cropColor
        }
        self.lineView.isHidden = true
        self.contentView.addSubview(self.lineView)

        // Title tips
        self.contentView.addSubview(self.titleView)
        self.titleView.alwaysBounceVertical = false
        self.titleView.contentInsetAdjustmentBehavior = .never
        self.titleView.frame = .init(x: 0, y: 0, width: self.contentView.frame.width, height: 0)
        self.setupTitle()
        self.titleViewHeight = self.titleView.bounds.height

        // Action
        self.contentView.addSubview(self.actionView)
        self.actionView.alwaysBounceVertical = false
        self.actionView.contentInsetAdjustmentBehavior = .never
        self.actionView.frame = .init(x: 0, y: 0, width: self.contentView.frame.width, height: 0)
        self.setupAction()
        self.actionViewHeight = self.actionView.bounds.height

        self.layoutContentView()
    }
    func layoutContentView() {
        // Limit value judgment
        self.checkLimit()

        // Split line
        if self.titleView.frame.height > 0 && self.actionView.frame.height > 0 {
            self.lineView.frame = .init(x: 0, y: self.titleView.frame.maxY-0.5, width: self.contentView.frame.width, height: 0.5)
            self.lineView.isHidden = false
        } else {
            self.lineView.isHidden = true
        }

        // Set style UI
        switch self.style {
        case .alert:
            self.contentView.frame = .init(x: (self.view.bounds.width-self.contentView.frame.width)/2.0, y: (self.view.bounds.height-self.contentView.frame.height)/2.0, width: self.contentView.frame.width, height: self.contentView.frame.height)
        case .actionSheet:
            self.contentView.frame = .init(x: (self.view.bounds.width-self.contentView.frame.width)/2.0, y: self.view.bounds.height-self.contentView.frame.height, width: self.contentView.frame.width, height: self.contentView.frame.height)
        }

        if self.config.cornerRadius > 0 {
            switch self.style {
            case .alert:
                self.contentView.layer.cornerRadius = self.config.cornerRadius
            case .actionSheet:
                self.contentView.layer.cornerRadius = 0
                let layer = CAShapeLayer.init()
                layer.path = UIBezierPath.init(roundedRect: self.contentView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: .init(width: self.config.cornerRadius, height: self.config.cornerRadius)).cgPath
                self.contentView.layer.mask = layer
            }
        } else {
            self.contentView.layer.cornerRadius = 0
        }
    }

    /// Limit value judgment
    func checkLimit() {
        let window: UIWindow?
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.connectedScenes.filter { $0 is UIWindowScene }.flatMap { ($0 as! UIWindowScene).windows }.first(where: { $0.isKeyWindow })
        } else {
            window = UIApplication.shared.keyWindow
        }
        var safeAreaInsets: UIEdgeInsets = .init(top: 20, left: 0, bottom: 0, right: 0)
        if let window = window {
            safeAreaInsets = .init(top: window.safeAreaInsets.top, left: 0, bottom: window.safeAreaInsets.bottom, right: 0)
            if window.safeAreaInsets.top == 0 {
                safeAreaInsets.top = 20
            }
        }
        // Max height
        let maxHeight = self.view.bounds.height-safeAreaInsets.top-44-safeAreaInsets.bottom
        if self.titleViewHeight + self.actionViewHeight > maxHeight {
            // The maximum limit has been exceeded and the display needs to be compressed
            if self.actionViewHeight == 0 {
                self.titleView.frame.size.height = maxHeight
            } else {
                // TitleView max height
                let titleViewMaxHeight: CGFloat
                switch self.style {
                case .alert:
                    if self.actionViewHeight > 50 {
                        titleViewMaxHeight = maxHeight-75
                    } else {
                        titleViewMaxHeight = maxHeight-50
                    }
                case .actionSheet:
                    if self.actionViewHeight > 55 {
                        titleViewMaxHeight = maxHeight-80
                    } else {
                        titleViewMaxHeight = maxHeight-55
                    }
                }
                if self.titleViewHeight > titleViewMaxHeight {
                    // Over titleView max height
                    self.titleView.frame.size.height = titleViewMaxHeight
                } else {
                    self.titleView.frame.size.height = self.titleViewHeight
                }
                self.actionView.frame.size.height = maxHeight-self.titleView.frame.size.height
            }
        } else {
            self.titleView.frame.size.height = self.titleViewHeight
            self.actionView.frame.size.height = self.actionViewHeight
        }
        switch self.style {
        case .alert:
            break
        case .actionSheet:
            if self.actionViewHeight > 0 {
                self.actionView.contentInset = .init(top: 0, left: 0, bottom: safeAreaInsets.bottom, right: 0)
                self.actionView.frame.size.height += safeAreaInsets.bottom
            } else {
                self.titleView.contentInset = .init(top: 0, left: 0, bottom: safeAreaInsets.bottom, right: 0)
                self.titleView.frame.size.height += safeAreaInsets.bottom
            }
        }
        self.actionView.frame.origin.y = self.titleView.frame.maxY
        self.contentView.frame.size.height = self.actionView.frame.maxY
        switch self.style {
        case .alert:
            if self.contentView.frame.height <= 0 {
                self.contentView.frame.size.height = 50
            }
        case .actionSheet:
            if self.contentView.frame.height <= safeAreaInsets.bottom {
                self.contentView.frame.size.height = 55*1.5+safeAreaInsets.bottom
            }
        }
    }

    /// Setup title
    func setupTitle() {
        if self.alertTitle == nil && self.alertMessage == nil && self.configurationHandlers.isEmpty {
            return
        }
        // Title
        let titlelabel: UILabel?
        if let alertTitle = self.alertTitle {
            titlelabel = UILabel.init()
            titlelabel?.numberOfLines = 0
            self.titleView.addSubview(titlelabel!)
            let paragraphStyle = NSMutableParagraphStyle.init()
            paragraphStyle.lineSpacing = 2
            paragraphStyle.alignment = .center
            if #available(iOS 13.0, *) {
                let titleColor = self.config.titleColor
                let titleDarkColor = self.config.titleDarkColor
                titlelabel?.attributedText = .init(string: alertTitle, attributes: [.font: self.config.titleFont, .foregroundColor: UIColor.init(dynamicProvider: { traitCollection in
                    switch traitCollection.userInterfaceStyle {
                    case .light:
                        return titleColor
                    default:
                        return titleDarkColor
                    }
                }), .paragraphStyle: paragraphStyle])
            } else {
                titlelabel?.attributedText = .init(string: alertTitle, attributes: [.font: self.config.titleFont, .foregroundColor: self.config.titleColor, .paragraphStyle: paragraphStyle])
            }
        } else {
            titlelabel = nil
        }
        // Subtitle
        let subTitlelabel: UILabel?
        if let alertMessage = self.alertMessage {
            subTitlelabel = UILabel.init()
            subTitlelabel?.numberOfLines = 0
            self.titleView.addSubview(subTitlelabel!)
            let paragraphStyle = NSMutableParagraphStyle.init()
            paragraphStyle.lineSpacing = 2
            paragraphStyle.alignment = .center
            if #available(iOS 13.0, *) {
                let messageColor = self.config.messageColor
                let messageDarkColor = self.config.messageDarkColor
                subTitlelabel?.attributedText = .init(string: alertMessage, attributes: [.font: self.config.messageFont, .foregroundColor: UIColor.init(dynamicProvider: { traitCollection in
                    switch traitCollection.userInterfaceStyle {
                    case .light:
                        return messageColor
                    default:
                        return messageDarkColor
                    }
                }), .paragraphStyle: paragraphStyle])
            } else {
                subTitlelabel?.attributedText = .init(string: alertMessage, attributes: [.font: self.config.messageFont, .foregroundColor: self.config.messageColor, .paragraphStyle: paragraphStyle])
            }
        } else {
            subTitlelabel = nil
        }
        // Max width
        let maxWidth = self.titleView.frame.size.width-self.config.titlelabelInset.left-self.config.titlelabelInset.right
        var height: CGFloat = 0
        if let titlelabel = titlelabel, let subTitlelabel = subTitlelabel {
            titlelabel.frame = .init(x: self.config.titlelabelInset.left, y: self.config.titlelabelInset.top, width: maxWidth, height: titlelabel.sizeThatFits(.init(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)).height)
            subTitlelabel.frame = .init(x: titlelabel.frame.minX, y: titlelabel.frame.maxY+10, width: titlelabel.frame.size.width, height: subTitlelabel.sizeThatFits(.init(width: titlelabel.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height)
            height = subTitlelabel.frame.maxY
        } else {
            if let label = titlelabel ?? subTitlelabel {
                let labelHeight = label.sizeThatFits(.init(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)).height
                label.frame = .init(x: self.config.titlelabelInset.left, y: self.config.titlelabelInset.top, width: maxWidth, height: labelHeight)
                height = label.frame.maxY
            }
        }
        // TitleViews
        if !self.configurationHandlers.isEmpty {
            var textViewTop = height+5
            self.configurationHandlers.forEach { configurationHandler in
                let titleView = configurationHandler(maxWidth)
                if titleView.bounds.size.width != maxWidth {
                    fatalError("⚠️ custom view width must be equal to\(maxWidth)")
                }
                self.titleView.addSubview(titleView)
                titleView.frame = .init(x: self.config.titlelabelInset.left, y: textViewTop+10, width: maxWidth, height: titleView.frame.height)
                self.titleViews.append(titleView)
                textViewTop += titleView.frame.height+10
            }
            height = textViewTop
        }
        // Bottom space 20
        height += 20
        self.titleView.frame.size.height = height
        self.titleView.contentSize = self.titleView.frame.size
    }

    /// Setup actions
    func setupAction() {
        if self.actions.isEmpty { return }
        let maxWidth = self.actionView.frame.width
        /// Create actionView
        let actionItems = self.actions.map { (action) -> WTActionView in
            let customView = action.customBlock(maxWidth)
            if let actionBtn = customView as? WTActionButton {
                if #available(iOS 13.0, *) {
                    let actionTouchColor = self.config.actionTouchColor
                    let actionTouchDarkColor = self.config.actionTouchDarkColor
                    actionBtn.touchView.backgroundColor = .init(dynamicProvider: { traitCollection in
                        switch traitCollection.userInterfaceStyle {
                        case .dark:
                            return actionTouchDarkColor
                        default:
                            return actionTouchColor
                        }
                    })
                } else {
                    actionBtn.touchView.backgroundColor = self.config.actionTouchColor
                }
                let insets: UIEdgeInsets
                switch self.style {
                case .alert:
                    insets = .init(top: 14, left: 10, bottom: 14, right: 10)
                case .actionSheet:
                    insets = .init(top: 17, left: 10, bottom: 17, right: 10)
                }
                actionBtn.insets = insets
                actionBtn.label.adjustsFontSizeToFitWidth = true
                actionBtn.label.textAlignment = .center
                switch self.style {
                case .alert:
                    actionBtn.label.minimumScaleFactor = 0.7
                    switch action.style {
                    case .default:
                        actionBtn.label.font = self.config.alertActionFont
                        if #available(iOS 13.0, *) {
                            let alertActionColor = self.config.alertActionColor
                            let alertActionDarkColor = self.config.alertActionDarkColor
                            actionBtn.label.textColor = UIColor.init(dynamicProvider: { traitCollection in
                                switch traitCollection.userInterfaceStyle {
                                case .light:
                                    return alertActionColor
                                default:
                                    return alertActionDarkColor
                                }
                            })
                        } else {
                            actionBtn.label.textColor = self.config.alertActionColor
                        }
                    case .cancel:
                        actionBtn.label.font = self.config.cancelAlertActionFont
                        if #available(iOS 13.0, *) {
                            let cancelAlertActionColor = self.config.cancelAlertActionColor
                            let cancelAlertActionDarkColor = self.config.cancelAlertActionDarkColor
                            actionBtn.label.textColor = UIColor.init(dynamicProvider: { traitCollection in
                                switch traitCollection.userInterfaceStyle {
                                case .light:
                                    return cancelAlertActionColor
                                default:
                                    return cancelAlertActionDarkColor
                                }
                            })
                        } else {
                            actionBtn.label.textColor = self.config.cancelAlertActionColor
                        }
                    case .destructive:
                        actionBtn.label.font = self.config.destructiveAlertActionFont
                        if #available(iOS 13.0, *) {
                            let destructiveAlertActionColor = self.config.destructiveAlertActionColor
                            let destructiveAlertActionDarkColor = self.config.destructiveAlertActionDarkColor
                            actionBtn.label.textColor = UIColor.init(dynamicProvider: { traitCollection in
                                switch traitCollection.userInterfaceStyle {
                                case .light:
                                    return destructiveAlertActionColor
                                default:
                                    return destructiveAlertActionDarkColor
                                }
                            })
                        } else {
                            actionBtn.label.textColor = self.config.destructiveAlertActionColor
                        }
                    }
                case .actionSheet:
                    actionBtn.label.minimumScaleFactor = 0.8
                    switch action.style {
                    case .default:
                        actionBtn.label.font = self.config.actionSheetActionFont
                        if #available(iOS 13.0, *) {
                            let actionSheetActionColor = self.config.actionSheetActionColor
                            let actionSheetActionDarkColor = self.config.actionSheetActionDarkColor
                            actionBtn.label.textColor = UIColor.init(dynamicProvider: { traitCollection in
                                switch traitCollection.userInterfaceStyle {
                                case .light:
                                    return actionSheetActionColor
                                default:
                                    return actionSheetActionDarkColor
                                }
                            })
                        } else {
                            actionBtn.label.textColor = self.config.actionSheetActionColor
                        }
                    case .cancel:
                        actionBtn.label.font = self.config.cancelActionSheetActionFont
                        if #available(iOS 13.0, *) {
                            let cancelActionSheetActionColor = self.config.cancelActionSheetActionColor
                            let cancelActionSheetActionDarkColor = self.config.cancelActionSheetActionDarkColor
                            actionBtn.label.textColor = UIColor.init(dynamicProvider: { traitCollection in
                                switch traitCollection.userInterfaceStyle {
                                case .light:
                                    return cancelActionSheetActionColor
                                default:
                                    return cancelActionSheetActionDarkColor
                                }
                            })
                        } else {
                            actionBtn.label.textColor = self.config.cancelActionSheetActionColor
                        }
                    case .destructive:
                        actionBtn.label.font = self.config.destructiveActionSheetActionFont
                        if #available(iOS 13.0, *) {
                            let destructiveActionSheetActionColor = self.config.destructiveActionSheetActionColor
                            let destructiveActionSheetActionDarkColor = self.config.destructiveActionSheetActionDarkColor
                            actionBtn.label.textColor = UIColor.init(dynamicProvider: { traitCollection in
                                switch traitCollection.userInterfaceStyle {
                                case .light:
                                    return destructiveActionSheetActionColor
                                default:
                                    return destructiveActionSheetActionDarkColor
                                }
                            })
                        } else {
                            actionBtn.label.textColor = self.config.destructiveActionSheetActionColor
                        }
                    }
                }
                // Setup max size
                var maxSize: CGSize
                switch self.style {
                case .alert:
                    maxSize = .init(width: maxWidth, height: 50)
                case .actionSheet:
                    maxSize = .init(width: maxWidth, height: 55)
                }
                actionBtn.frame = .init(origin: .zero, size: actionBtn.sizeThatFits(maxSize))
                actionBtn.addTarget(self, action: #selector(actionClick(actionBtn:)), for: .touchUpInside)
                actionBtn.accessibilityIdentifier = action.identify
                return .init(style: action.style, customView: actionBtn)
            } else {
                if customView.bounds.size.width != maxWidth {
                    fatalError("⚠️ custom view width must be equal to\(maxWidth)")
                }
                return .init(style: action.style, customView: customView)
            }
        }
        // Layout actions
        let cancelActions = actionItems.filter { $0.style == .cancel }
        let defaultActions = actionItems.filter { $0.style != .cancel }
        if self.style == .alert && actionItems.count == 2 && actionItems.first!.bounds.size.width <= maxWidth/2.0 && actionItems.last!.bounds.size.width <= maxWidth/2.0 {
            // Horizontal layout actionItem
            let actionItems = (cancelActions+defaultActions)
            var actionLeft: CGFloat = 0
            actionItems.forEach { (actionItem) in
                self.actionView.addSubview(actionItem)
                actionItem.frame = .init(x: actionLeft, y: 0, width: maxWidth/2.0, height: 50)
                actionLeft += actionItem.frame.size.width
            }
            // Split line
            if let actionItem = actionItems.first {
                let lineView = UIView.init()
                self.actionView.addSubview(lineView)
                if #available(iOS 13.0, *) {
                    let cropColor = self.config.cropColor
                    let cropDarkColor = self.config.cropDarkColor
                    lineView.backgroundColor = UIColor.init(dynamicProvider: { traitCollection in
                        switch traitCollection.userInterfaceStyle {
                        case .light:
                            return cropColor
                        default:
                            return cropDarkColor
                        }
                    })
                } else {
                    lineView.backgroundColor = self.config.cropColor
                }
                lineView.frame = .init(x: actionItem.frame.maxX-0.25, y: 0, width: 0.5, height: actionItem.frame.height)
            }
            // Split line
            let lineView = UIView.init()
            self.actionView.addSubview(lineView)
            if #available(iOS 13.0, *) {
                let cropColor = self.config.cropColor
                let cropDarkColor = self.config.cropDarkColor
                lineView.backgroundColor = UIColor.init(dynamicProvider: { traitCollection in
                    switch traitCollection.userInterfaceStyle {
                    case .light:
                        return cropColor
                    default:
                        return cropDarkColor
                    }
                })
            } else {
                lineView.backgroundColor = self.config.cropColor
            }
            lineView.frame = .init(x: 0, y: 0, width: maxWidth, height: 0.5)
            self.actionView.frame.size.height = 50
        } else {
            // Vertical layout actionItem
            var actionTop: CGFloat = 0
            for actionItem in defaultActions {
                self.actionView.addSubview(actionItem)
                actionItem.frame.origin.y = actionTop
                actionItem.frame.size.width = maxWidth
                if actionTop > 0 {
                    // Split line
                    let lineView = UIView.init()
                    self.actionView.addSubview(lineView)
                    if #available(iOS 13.0, *) {
                        let cropColor = self.config.cropColor
                        let cropDarkColor = self.config.cropDarkColor
                        lineView.backgroundColor = UIColor.init(dynamicProvider: { traitCollection in
                            switch traitCollection.userInterfaceStyle {
                            case .light:
                                return cropColor
                            default:
                                return cropDarkColor
                            }
                        })
                    } else {
                        lineView.backgroundColor = self.config.cropColor
                    }
                    lineView.frame = .init(x: 0, y: actionItem.frame.minY-0.25, width: maxWidth, height: 0.5)
                }
                actionTop = actionItem.frame.maxY
            }
            for item in cancelActions.enumerated() {
                let actionItem = item.element
                self.actionView.addSubview(actionItem)
                if item.offset == 0 && self.style == .actionSheet {
                    actionItem.frame.origin.y = actionTop+8
                } else {
                    actionItem.frame.origin.y = actionTop
                }
                actionItem.frame.size.width = maxWidth
                if item.offset == 0 && self.style == .actionSheet && actionTop > 0 {
                    // Cancel split line
                    let lineView = UIView.init()
                    self.actionView.addSubview(lineView)
                    if #available(iOS 13.0, *) {
                        let cancelCropColor = self.config.cancelCropColor
                        let cancelCropDarkColor = self.config.cancelCropDarkColor
                        lineView.backgroundColor = UIColor.init(dynamicProvider: { traitCollection in
                            switch traitCollection.userInterfaceStyle {
                            case .light:
                                return cancelCropColor
                            default:
                                return cancelCropDarkColor
                            }
                        })
                    } else {
                        lineView.backgroundColor = self.config.cropColor
                    }
                    lineView.frame = .init(x: 0, y: actionItem.frame.minY-8, width: maxWidth, height: 8)
                } else if actionTop > 0 {
                    // Split line
                    let lineView = UIView.init()
                    self.actionView.addSubview(lineView)
                    if #available(iOS 13.0, *) {
                        let cropColor = self.config.cropColor
                        let cropDarkColor = self.config.cropDarkColor
                        lineView.backgroundColor = UIColor.init(dynamicProvider: { traitCollection in
                            switch traitCollection.userInterfaceStyle {
                            case .light:
                                return cropColor
                            default:
                                return cropDarkColor
                            }
                        })
                    } else {
                        lineView.backgroundColor = self.config.cropColor
                    }
                    lineView.frame = .init(x: 0, y: actionItem.frame.minY-0.25, width: maxWidth, height: 0.5)
                }
                actionTop = actionItem.frame.maxY
            }
            self.actionView.frame.size.height = actionTop
        }
        self.actionView.contentSize = self.actionView.frame.size
    }

    // MARK: - Action

    private var actions: [WTAlertAction] = []

    /// Add action
    public func addAction(_ action: WTAlertAction) {
        self.actions.append(action)
    }

    /// Action event
    @objc private func actionClick(actionBtn: WTActionButton) {
        if let action = self.actions.first(where: { $0.identify == actionBtn.accessibilityIdentifier }), action.isEnabled {
            if self.config.dismissWhenTouchAction {
                self.dismiss(animated: true) {
                    action.handler?(action)
                }
            } else {
                action.handler?(action)
            }
        }
    }

    override func didDismissAlert() {
        if let action = self.actions.first(where: { $0.style == .cancel && $0.isEnabled }) {
            action.handler?(action)
        }
    }

    // MARK: - custom titleView

    public typealias ConfigurationHandler = (_ width: CGFloat) -> UIView

    public typealias ConfigurationTextFieldHandler = (_ textField: UITextField, _ width: CGFloat) -> Void

    private var configurationHandlers: [ConfigurationHandler] = []

    private var titleViews: [UIView] = []

    public var customTitleViews: [UIView] {
        self.titleViews
    }

    /// Add titleView
    public func addTitleView(configurationHandler: @escaping ConfigurationHandler) {
        self.configurationHandlers.append(configurationHandler)
    }

    /// Add textFieldView
    public func addTextFieldView(configurationTextFieldHandler: @escaping ConfigurationTextFieldHandler) {
        let textFieldTextColor = self.config.textFieldTextColor
        let textFieldDarkTextColor = self.config.textFieldDarkTextColor
        let textFieldBackgroundColor = self.config.textFieldBackgroundColor
        let textFieldDarkBackgroundColor = self.config.textFieldDarkBackgroundColor
        let backgroundColor: UIColor
        let textColor: UIColor
        if #available(iOS 13.0, *) {
            backgroundColor = .init(dynamicProvider: { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .light:
                    return textFieldBackgroundColor
                default:
                    return textFieldDarkBackgroundColor
                }
            })
            textColor = UIColor.init(dynamicProvider: { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .light:
                    return textFieldTextColor
                default:
                    return textFieldDarkTextColor
                }
            })
        } else {
            textColor = textFieldTextColor
            backgroundColor = textFieldBackgroundColor
        }
        let font = self.config.textFieldFont
        self.configurationHandlers.append {[weak self] width in
            let textField = WTAlertTextField.init()
            textField.backgroundColor = backgroundColor
            textField.textColor = textColor
            textField.font = font
            textField.layer.cornerRadius = 4
            textField.layer.masksToBounds = true
            textField.leftView = UIView.init(frame: .init(x: 0, y: 0, width: 8, height: 8))
            textField.leftViewMode = .always
            textField.clearButtonMode = .whileEditing
            configurationTextFieldHandler(textField, width)
            textField.frame = .init(x: 0, y: 0, width: width, height: 40)
            textField.alertController = self
            return textField
        }
    }

}
