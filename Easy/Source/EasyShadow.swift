//
//  EasyShadow.swift
//  Easy
//
//  Created by Shalom Shwaitzer on 29/07/2018.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import UIKit

public enum ShadowProperties {
    case color(UIColor)
    case radius(CGFloat) //blur
    case offsetX(CGFloat)
    case offsetY(CGFloat)
    case opacity(Float)
    case path(CGPath)
    case mask
    case clip
    case shouldResterize(scale: CGFloat)
}

public extension UIView {
    
    @discardableResult
    func shadow(style: ShadowProperties...) -> Self {
        self.layer.masksToBounds = false
        style.forEach { p in
            switch p {
            case let .color(val):
                self.layer.shadowColor = val.cgColor
            case let .radius(val):
                self.layer.shadowRadius = val
            case let .offsetX(val):
                self.layer.shadowOffset = CGSize(width: val, height: layer.shadowOffset.height)
            case let .offsetY(val):
                self.layer.shadowOffset = CGSize(width: layer.shadowOffset.width, height: val)
            case let .opacity(val):
                self.layer.shadowOpacity = val
            case let .path(val):
                self.layer.shadowPath = val
            case .mask:
                self.layer.masksToBounds = true
            case .clip:
                self.clipsToBounds = false
            case let .shouldResterize(scale: value):
                self.layer.shouldRasterize = true
                self.layer.rasterizationScale = value
            }
        }
        
        return self
    }
}
