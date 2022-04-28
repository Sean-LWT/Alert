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
    }
    @objc func openAlert(alertBtn: UIButton) {
        let alert = WTAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addTitleViews { width in
            let textField = UITextField.init()
            textField.frame = .init(x: 0, y: 0, width: width, height: 40)
            if #available(iOS 13.0, *) {
                textField.backgroundColor = UIColor.init(dynamicProvider: { traitCollection in
                    switch traitCollection.userInterfaceStyle {
                    case .light:
                        return UIColor.gray.withAlphaComponent(0.3)
                    default:
                        return UIColor.gray.withAlphaComponent(0.1)
                    }
                })
                textField.textColor = UIColor.init(dynamicProvider: { traitCollection in
                    switch traitCollection.userInterfaceStyle {
                    case .light:
                        return .black
                    default:
                        return .white
                    }
                })
            } else {
                textField.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
                textField.textColor = .black
            }
            textField.layer.cornerRadius = 4
            textField.layer.masksToBounds = true
            textField.font = UIFont.systemFont(ofSize: 16)
            return textField
        }
        alert.addTitleViews { width in
            let customView = UILabel.init(frame: .init(x: 0, y: 0, width: width, height: 59))
            customView.attributedText = .init(string: "😄你想放什么都可以啊", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.red])
            customView.textAlignment = .center
            return customView
        }
        alert.addAction(.init(title: "取消", style: .cancel))
        alert.addAction(.init(title: "了解了", style: .default))
        alert.addAction(.init(title: "知道了", style: .destructive))
        alert.addAction(.init(style: .cancel, customBlock: { width in
            let customView = UIButton.init(type: .custom)
            customView.frame = .init(origin: .zero, size: .init(width: width, height: 80))
            customView.backgroundColor = .systemOrange
            customView.setAttributedTitle(.init(string: "我是一个按钮", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.blue]), for: .normal)
            return customView
        }))
        self.present(alert, animated: true)
    }

}
