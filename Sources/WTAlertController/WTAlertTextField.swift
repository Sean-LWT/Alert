//
//  WTAlertTextField.swift
//  AlertDemo
//
//  Created by lwt on 2022/9/4.
//

import UIKit

class WTAlertTextField: UITextField {

    weak var alertController: WTAlertController?

    var keyboardInfo: [String: Any]?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autocorrectionType = .no
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrameNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidBeginEditingNotification(notification:)), name: UITextField.textDidBeginEditingNotification, object: self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func textDidBeginEditingNotification(notification: Notification) {
        self.optimizedAdjustPosition()
    }
    @objc func keyboardWillChangeFrameNotification(notification: Notification) {
        self.keyboardInfo = notification.userInfo as? [String: Any]
        if self.isFirstResponder {
            self.optimizedAdjustPosition()
        }
    }
    func optimizedAdjustPosition() {
        guard let alertController = self.alertController, alertController.config.textFieldOptimizedAdjustPosition, self.isFirstResponder, let keyboardInfo = self.keyboardInfo, let endFrame = keyboardInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect, let duration = keyboardInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        let dismissKeyboard = endFrame.minY >= UIScreen.main.bounds.size.height
        if dismissKeyboard {
            if alertController.view.frame != UIScreen.main.bounds {
                UIView.animate(withDuration: duration) {
                    alertController.view.frame = UIScreen.main.bounds
                }
            }
        } else {
            var viewFrame = alertController.view.frame
            var contentOffset = alertController.titleView.contentOffset
            // scroll to top or bottom
            var rect = self.convert(self.bounds, to: nil)
            let titleViewRect = alertController.titleView.convert(alertController.titleView.bounds, to: nil)
            if rect.maxY > titleViewRect.maxY {
                let height = rect.maxY - titleViewRect.maxY
                contentOffset.y -= height
                rect.origin.y -= height
            } else if rect.minY < titleViewRect.minY {
                let height = titleViewRect.minY - rect.minY
                contentOffset.y += height
                rect.origin.y += height
            }
            let height = rect.maxY - endFrame.minY
            if height != 0 {
                viewFrame.origin.y -= height
                if viewFrame.origin.y > 0 {
                    viewFrame.origin.y = 0
                }
            }
            if alertController.view.frame != viewFrame || alertController.titleView.contentOffset != contentOffset {
                UIView.animate(withDuration: duration) {
                    if alertController.view.frame != viewFrame {
                        alertController.view.frame = viewFrame
                    }
                    if alertController.titleView.contentOffset != contentOffset {
                        alertController.titleView.contentOffset = contentOffset
                    }
                }
            }
        }
    }

}
