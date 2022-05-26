//
//  WTActionButton.swift
//  ZhiBoPin
//
//  Created by vaexiin on 2021/5/9.
//

import UIKit

class WTActionButton: UIButton {

    let touchView = UIView.init()

    /// Content
    let label = UILabel.init()

    /// Content layout insets from superView
    var insets = UIEdgeInsets.zero

    override var buttonType: UIButton.ButtonType {
        .custom
    }

    convenience init(title: String?) {
        self.init(frame: .zero)
        self.label.text = title
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true

        self.touchView.isUserInteractionEnabled = false
        self.touchView.isHidden = true
        self.addSubview(self.touchView)
        self.addSubview(self.label)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.touchView.frame = self.bounds
        self.label.frame = .init(x: self.insets.left, y: self.insets.top, width: self.bounds.size.width-self.insets.left-self.insets.right, height: self.bounds.size.height-self.insets.top-self.insets.bottom)
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let maxLabelSize = CGSize.init(width: size.width-self.insets.left-self.insets.right, height: size.height-self.insets.top-self.insets.bottom)
        let realLabelSize = self.label.sizeThatFits(maxLabelSize)
        var realSize = CGSize.init(width: realLabelSize.width+self.insets.left+self.insets.right, height: realLabelSize.height+self.insets.top+self.insets.bottom)
        if realSize.width > size.width {
            realSize.width = size.width
        }
        if realSize.height > size.height {
            realSize.height = size.height
        }
        return realSize
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        defer {
            self.touchView.isHidden = false
        }
        return super.beginTracking(touch, with: event)
    }
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        self.touchView.isHidden = !self.isTouchInside
        return super.continueTracking(touch, with: event)
    }
    override func cancelTracking(with event: UIEvent?) {
        self.touchView.isHidden = true
        super.cancelTracking(with: event)
    }
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        self.touchView.isHidden = true
        super.endTracking(touch, with: event)
    }

}
