//
//  EasyNavigationBar.swift
//  Easy
//
//  Created by Shalom on 14/04/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import UIKit

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

public extension UIViewController {
    
    @discardableResult
    func navigation(style: BarStyle...) -> Self {
        
        for option in style {
            switch option {
            case let .hideBackButton(hide):
                self.navigationItem.hidesBackButton = hide
            case let .separator(color):
                self.navigationController?.navigationBar.shadowImage = color.image()
            case .background(color: let color):
                self.navigationController?.navigationBar.setBackgroundImage(color.image(), for: .default)
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
}
