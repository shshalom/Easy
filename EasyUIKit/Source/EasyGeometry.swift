//
//  EasyGeometry.swift
//  Easy
//
//  Created by Shalom on 17/03/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import CoreGraphics
import UIKit

public extension CGSize {
    var asRect: CGRect {
        CGRect(origin: .zero, size: self)
    }
}

public extension Int {
    var cgSize: CGSize {
        CGSize(width: self, height: self)
    }
}

public extension CGFloat {
    var cgSize: CGSize {
        CGSize(width: self, height: self)
    }
}

public extension Double {
    var cgSize: CGSize {
        CGSize(width: self, height: self)
    }
}

public enum UIEdgeInset: Hashable {
    case top(CGFloat)
    case left(CGFloat)
    case right(CGFloat)
    case bottom(CGFloat)
    case margin(CGFloat)
}

public extension UIEdgeInsets {
    init(_ set: [UIEdgeInset]) {
        self.init()
        
       for edge in set {
            switch edge {
            case let .top(value):
                self.top = value
            case let .left(value):
                self.left = value
            case let .right(value):
                self.right = value
            case let .bottom(value):
                self.bottom = value
            case let .margin(value):
                left = value
                right = value
                top = value
                bottom = value
            }
        }
    }
    
    static func set(_ set: UIEdgeInset...) -> UIEdgeInsets {
        return UIEdgeInsets(set)
    }
    
    static func left(_ value: CGFloat) -> UIEdgeInsets {
        return .set(.left(value))
    }
    
    static func right(_ value: CGFloat) -> UIEdgeInsets {
        return .set(.right(value))
    }
    
    static func top(_ value: CGFloat) -> UIEdgeInsets {
        return .set(.top(value))
    }
    
    static func bottom(_ value: CGFloat) -> UIEdgeInsets {
        return .set(.bottom(value))
    }
    
    static func margin(_ value: CGFloat) -> UIEdgeInsets {
       return .set(.margin(value))
    }
}

public extension UITableView {
    @discardableResult
    func separator(inset: UIEdgeInset...) -> Self {
        self.separatorInset = UIEdgeInsets(inset)
        return self
    }
}

public extension UICollectionView {
    @discardableResult
    func content(inset: UIEdgeInset...) -> Self {
        self.contentInset = UIEdgeInsets(inset)
        return self
    }
}
