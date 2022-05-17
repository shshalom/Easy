//
//  EasyNavigationBar.swift
//  Easy
//
//  Created by Shalom on 14/04/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import UIKit

private var _viewControllerBarApperanceKey: UInt8 = 0

public enum BarStyle {
    case title(String)
    case separator(UIColor)
    case background(color: UIColor)
    case left(buttons: [UIBarButtonItem])
    case right(buttons: [UIBarButtonItem])
    case center(view: UIView)
    case shadow(Bool)
    case hideBackButton(Bool)
}

extension UIViewController {

    private var _barAppearance: UINavigationBarAppearance {

        if let value = objc_getAssociatedObject(self, &_viewControllerBarApperanceKey) as? UINavigationBarAppearance {
            return value
        }

        let apparance = UINavigationBarAppearance()
        apparance.configureWithTransparentBackground()
        objc_setAssociatedObject(self, &_viewControllerBarApperanceKey, apparance, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        return apparance
    }

    @discardableResult
    public func navigation(style: BarStyle...) -> Self {

        for option in style {
            switch option {
            case let .hideBackButton(hide):
                self.navigationItem.hidesBackButton = hide
            case let .separator(color):
                _barAppearance.shadowColor = color
                self.navigationController?.navigationBar.shadowImage = color.image()
                self._applyApperance()
            case .background(color: let color):
                _barAppearance.backgroundImage = color.image()
                self.navigationController?.navigationBar.setBackgroundImage(color.image(), for: .default)
                self._applyApperance()
            case let .left(buttons):
                self.navigationItem.setLeftBarButtonItems(buttons, animated: true)
            case let .right(buttons):
                self.navigationItem.setRightBarButtonItems(buttons, animated: true)
            case let .center(content):
                self.navigationItem.titleView = content
            case let .title(title):
                self.title = title
            case let .shadow(enable):
                if enable {
                    self.navigationController?.navigationBar.addShadow()
                } else {
                    self.navigationController?.navigationBar.removeShadow()
                }
            }
        }

        return self
    }

    private func _applyApperance() {
        self.navigationController?.navigationBar.standardAppearance = _barAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = _barAppearance
        self.navigationController?.navigationBar.compactAppearance = _barAppearance
    }
}
