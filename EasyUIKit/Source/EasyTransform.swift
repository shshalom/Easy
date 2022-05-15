//
//  EasyTransform.swift
//  Easy
//
//  Created by Shalom on 13/04/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    enum TransformFlip {
        case x, y
    }
    
    func rotate(degrees: CGFloat, animated: Bool = false) -> Self {
        rotate(radians: degreesToRadians(value: degrees), animated: animated)
    }
    
    func rotate(radians: CGFloat, animated: Bool = false) -> Self {
        if animated {
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform(rotationAngle: radians)
            }
        } else {
            transform = CGAffineTransform(rotationAngle: radians)
        }
        
        return self
    }
    
    @discardableResult
    func flip(axis: TransformFlip) -> Self {
        
        switch axis {
        case .x: transform = .init(scaleX: -1, y: 1)
        case .y: transform = .init(scaleX: 1, y: -1)
        }
        
        return self
    }
    
    private var rotation: (radians: CGFloat, degrees: CGFloat) {
        let radians = CGFloat(atan2f(Float(transform.b), Float(transform.a)))
        return (radians, radiansToDegrees(value: radians))
    }
    
    private func degreesToRadians(value: CGFloat) -> CGFloat {
        return CGFloat.pi * value / 180.0
    }
    
    private func radiansToDegrees(value: CGFloat) -> CGFloat {
        return value * 180 / CGFloat.pi
    }
}
