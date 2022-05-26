//
//  WTActionView.swift
//  ZhiBoPin
//
//  Created by vaexiin on 2021/5/9.
//

import UIKit

class WTActionView: UIView {

    private(set) var customView: UIView!

    private(set) var style: WTAlertAction.Style!

    init(style: WTAlertAction.Style, customView: UIView) {
        super.init(frame: customView.bounds)
        self.backgroundColor = .clear
        self.clipsToBounds = true

        self.style = style
        self.customView = customView
        self.addSubview(self.customView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.customView.frame = self.bounds
    }

}
