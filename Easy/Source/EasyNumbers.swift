//
//  EasyMath.swift
//  Easy
//
//  Created by Shalom Shwaitzer on 18/08/2019.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

public protocol EasyNumbers {}
public extension EasyNumbers {
    func between<T: FloatingPoint>(min: T, max: T) -> (interpolate: (T, T) -> T, _: Int)? {
        
        guard let self = self as? T else { return nil }
        
        return ({ nMin, nMax -> T in
            
            var result: T = 0
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

extension Float: EasyNumbers {}
extension CGFloat: EasyNumbers {}
extension Double: EasyNumbers {}

public extension Int {
    func between<T: FloatingPoint>(min: T, max: T) -> (interpolate: (T, T) -> T, _: Int)? {
        return CGFloat(self).between(min: min, max: max)
    }
}

public extension CGFloat {
    var edges: UIEdgeInsets {
        return .init(top: self, left: self, bottom: self, right: self)
    }
}

public extension Int {
    var edges: UIEdgeInsets {
        return CGFloat(self).edges
    }
}

public extension String {
    var doubleValue: Double {
        Double(self) ?? 0.0
    }
    
    var intValue: Int {
        Int(self) ?? 0
    }
}
