//
//  ViewController.swift
//  Alert
//
//  Created by MacPro on 2022/4/28.
//

import UIKit

class ViewController: UIViewController {

    let alertBtn = UIButton.init(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.alertBtn.center = self.view.center
    }
    func setUI() {
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .init(dynamicProvider: { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .light:
                    return .white
                default:
                    return .black
                }
            })
        } else {
            self.view.backgroundColor = .white
        }
        self.navigationItem.title = "Alert"

        self.view.addSubview(self.alertBtn)
        self.alertBtn.bounds = .init(origin: .zero, size: .init(width: 80, height: 50))
        self.alertBtn.setAttributedTitle(.init(string: "开启alert", attributes: [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.blue]), for: .normal)
        self.alertBtn.addTarget(self, action: #selector(openAlert(alertBtn:)), for: .touchUpInside)

        // 设置全局默认
        var config = WTAlertConfig.default
        config.cornerRadius = 10
        WTAlertConfig.default = config
    }
    @objc func openAlert(alertBtn: UIButton) {
        let alert = WTAlertController.init(title: "温馨提示", message: "请选择一个内容", preferredStyle: .actionSheet)
        alert.addTextFieldView { textField, width in
            textField.text = "宽度 \(width)"
        }
//        alert.addTitleView { width in
//            let customView = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 59))
//            customView.numberOfLines = 0
//            customView.attributedText = .init(string: "我是一个自定义的titleView\n😄你想放什么都可以啊", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.red])
//            customView.textAlignment = .center
//            return customView
//        }
        alert.addAction(.init(title: "取消", style: .cancel))
        alert.addAction(.init(title: "内容1", style: .default))
//        alert.addAction(.init(style: .default, customBlock: { width in
//            let customView = UIButton.init(type: .custom)
//            customView.frame = .init(origin: .zero, size: .init(width: width, height: 80))
//            customView.backgroundColor = .systemOrange
//            customView.setAttributedTitle(.init(string: "我是一个自定义的选项", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.blue]), for: .normal)
//            return customView
//        }))
//        alert.addAction(.init(title: "内容2", style: .destructive))
        self.present(alert, animated: true)
    }

}
