//
//  EasyPageControl.swift
//  Easy
//
//  Created by Shalom on 08/04/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import UIKit

public extension UIPageControl {
    
    @discardableResult
    func currentPage(_ value: Int) -> Self {
        self.currentPage = value
        return self
    }
    
    @discardableResult
    func hidesForSinglePage(_ value: Bool) -> Self {
        self.hidesForSinglePage = value
        return self
    }
    
    @discardableResult
    func currentPageIndicatorTint(color: UIColor) -> Self {
        self.currentPageIndicatorTintColor = color
        return self
    }
    
    @discardableResult
    func pageIndicatorTint(color: UIColor) -> Self {
        self.pageIndicatorTintColor = color
        return self
    }
    
    @discardableResult
    func tintAdjustment(mode: TintAdjustmentMode) -> Self {
        self.tintAdjustmentMode = mode
        return self
    }
    
    @discardableResult
    func numberOfPages(_ value: Int) -> Self {
        self.numberOfPages = value
        return self
    }
}
