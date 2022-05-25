//
//  WTBaseViewController.swift
//  Example
//
//  Created by MacPro on 2021/4/20.
//

import UIKit

public class WTAlertBaseController: UIViewController {

    public struct Animate {
        /// Animation time
        public var animateTime: TimeInterval {
            switch self.animatedStyle {
            case .actionSheet:
                return 0.2
            case .alert:
                return 0.15
            }
        }
        /// Animation style
        public enum AnimatedStyle {
            case alert
            case actionSheet
        }
        public let animatedStyle: AnimatedStyle

        public init(animatedStyle: AnimatedStyle = .alert) {
            self.animatedStyle = animatedStyle
        }
    }
    private var animate = Animate.init()

    /// Alert config
    public var config: WTAlertConfig = .default

    let maskView = UIView.init()
    let contentView = UIView.init()

    init(animate: Animate) {
        super.init(nibName: nil, bundle: nil)
        self.animate = animate
        self.setup()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        self.transitioningDelegate = nil
    }
    func setup() {
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.maskView.frame = self.view.bounds
    }
    func setUI() {
        self.view.backgroundColor = .clear

        self.maskView.backgroundColor = self.config.maskColor
        self.view.addSubview(self.maskView)
        self.maskView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(closeClick)))
        self.view.addSubview(self.contentView)
    }

    // MARK: - event

    /// Close event
    @objc func closeClick() {
        if self.config.dismissWhenTouchOutside {
            self.maskView.isUserInteractionEnabled = false
            self.dismiss(animated: true, completion: nil)
            self.didDismissAlert()
        }
    }
    func didDismissAlert() {}

}

extension WTAlertBaseController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    // MARK: - transition animation

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.animate.animateTime
    }
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if transitionContext.viewController(forKey: .to) == self {
            let contentView = transitionContext.containerView
            // Start transition animation
            contentView.addSubview(self.view)
            self.maskView.isUserInteractionEnabled = false
            switch self.animate.animatedStyle {
            case .alert:
                self.contentView.transform = CGAffineTransform.init(scaleX: 1.05, y: 1.05)
                self.maskView.alpha = 0
                UIView.animate(withDuration: self.animate.animateTime, delay: 0, options: .curveEaseInOut) {
                    self.maskView.alpha = 1
                    self.contentView.transform = CGAffineTransform.identity
                } completion: { (_) in
                    transitionContext.completeTransition(true)
                    self.maskView.isUserInteractionEnabled = true
                }
            case .actionSheet:
                self.contentView.frame.origin.y = UIScreen.main.bounds.height
                self.maskView.alpha = 0
                UIView.animate(withDuration: self.animate.animateTime, delay: 0, options: .curveEaseInOut) {
                    self.maskView.alpha = 1
                    self.contentView.frame.origin.y = UIScreen.main.bounds.height-self.contentView.frame.height
                } completion: { (_) in
                    transitionContext.completeTransition(true)
                    self.maskView.isUserInteractionEnabled = true
                }
            }
        } else if transitionContext.viewController(forKey: .from) == self {
            // Close transition animation
            self.maskView.isUserInteractionEnabled = false
            switch self.animate.animatedStyle {
            case .alert:
                UIView.animate(withDuration: self.animate.animateTime, delay: 0, options: .curveEaseInOut) {
                    self.maskView.alpha = 0
                    self.contentView.alpha = 0
                    self.contentView.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
                } completion: { (_) in
                    self.view.removeFromSuperview()
                    transitionContext.completeTransition(true)
                }
            case .actionSheet:
                UIView.animate(withDuration: self.animate.animateTime, delay: 0, options: .curveEaseInOut) {
                    self.maskView.alpha = 0
                    self.contentView.frame.origin.y = UIScreen.main.bounds.height
                } completion: { (_) in
                    self.view.removeFromSuperview()
                    transitionContext.completeTransition(true)
                }
            }
        }
    }

}
