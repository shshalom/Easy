//
//  EasyGeometry.swift
//  Easy
//
//  Created by Shalom on 17/03/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import CoreGraphics
import UIKit

extension CGSize {
    public var asRect: CGRect {
        CGRect(origin: .zero, size: self)
    }
}

extension Int {
    public var cgSize: CGSize {
        CGSize(width: self, height: self)
    }
}

extension CGFloat {
    public var cgSize: CGSize {
        CGSize(width: self, height: self)
    }
}

extension Double {
    public var cgSize: CGSize {
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

extension UIEdgeInsets {
    public init(_ set: UIEdgeInset) {
        self.init()

        switch set {
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

    private static func set(_ set: UIEdgeInset) -> UIEdgeInsets {
        return UIEdgeInsets(set)
    }

    public static func left(_ value: CGFloat) -> UIEdgeInsets {
        return .set(.left(value))
    }

    public static func right(_ value: CGFloat) -> UIEdgeInsets {
        return .set(.right(value))
    }

    public static func top(_ value: CGFloat) -> UIEdgeInsets {
        return .set(.top(value))
    }

    public static func bottom(_ value: CGFloat) -> UIEdgeInsets {
        return .set(.bottom(value))
    }

    public static func margin(_ value: CGFloat) -> UIEdgeInsets {
        return .set(.margin(value))
    }
}

extension UIEdgeInsets {
    public func top(_ value: CGFloat) -> Self {
        var `self` = self
        self.top = value
        return self
    }

    public func bottom(_ value: CGFloat) -> Self {
        var `self` = self
        self.bottom = value
        return self
    }

    public func left(_ value: CGFloat) -> Self {
        var `self` = self
        self.left = value
        return self
    }

    public func right(_ value: CGFloat) -> Self {
        var `self` = self
        self.right = value
        return self
    }
}

extension String {
    // parse any format of "(value, value, value, value) into CGRect type
    public var asRect: CGRect {
        let values = self.components(separatedBy: .init(charactersIn: "(), ")).reduce([CGFloat]()) {
            if let x = Float($1) {
                return $0 + [CGFloat(x)]
            } else {
                return $0
            }
        }

        return values.count == 4 ? CGRect(x: values[0], y: values[1], width: values[2], height: values[3]) : .zero
    }
}
