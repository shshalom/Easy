//
//  EasyMath.swift
//  Easy
//
//  Created by Shalom Shwaitzer on 18/08/2019.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit

public protocol EasyNumbers {}

public protocol NumericType: FloatingPoint {}

extension NumericType {
    /// Convert a range of number into a new range
    /// - Parameters:
    ///   - min: lower range
    ///   - max: top range
    /// - Returns: An interpolation into required range.
    /// - Descussion: a good usage example would be something like pull to refresh.
    /// - you want to define a streatch that for when its closed you need alpha = 0 and when it streatch to a spesific point it would be alpha=1
    /// - with a scroll you can track mark the desier range - and use this (between) function to interpolate the range into 0 - 1 or 1 - 0 range.
    /// - e.g.  let currentOffset = scrollView.contentOffset.y
    ///      let alpha = currentOffset.between(min: 100, max: 500)?.interpolate(0, 1)
    public func between(min: Self, max: Self) -> (interpolate: (Self, Self) -> Self, _: Self) {

        return ({ nMin, nMax -> Self in

            var result: Self = 0
            let oldMax = max
            let oldMin = min
            let newMax = nMax
            let newMin = nMin

            if self >= oldMin && self <= oldMax {
                let oldRange = oldMax - oldMin
                let newRange = newMax - newMin

                result = ((self - oldMin) * newRange / oldRange) + newMin
            } else if self < oldMin {
                result = nMin
            } else {
                result = nMax
            }

            return result
        }, 0)
    }
}

extension Float: NumericType {}
extension CGFloat: NumericType {}
extension Double: NumericType {}

extension CGFloat {
    public var edges: UIEdgeInsets {
        return .init(top: self, left: self, bottom: self, right: self)
    }
}

extension Int {
    public var edges: UIEdgeInsets {
        return CGFloat(self).edges
    }
}

extension String {
    public var doubleValue: Double {
        Double(self) ?? 0.0
    }

    public var intValue: Int {
        Int(self) ?? 0
    }
}
