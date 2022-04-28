//
//  WTActionButton.swift
//  ZhiBoPin
//
//  Created by vaexiin on 2021/5/9.
//

import UIKit

class WTActionButton: UIButton {

    /// 内容
    let label = UILabel.init()

    var insets = UIEdgeInsets.zero

    convenience init(title: String?) {
        self.init(frame: .zero)
        self.label.text = title
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.clipsToBounds = true

        self.label.backgroundColor = self.backgroundColor
        self.addSubview(self.label)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
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

}
