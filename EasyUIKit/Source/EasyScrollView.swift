//
//  EasyScrollView.swift
//  Easy
//
//  Created by Eliran Sharabi on 06/01/2021.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import UIKit

public extension UIScrollView {
    @discardableResult
    func isScroll(enabled: Bool) -> Self {
        self.isScrollEnabled = enabled
        return self
    }
    
    @discardableResult
    func isPaging(enabled: Bool) -> Self {
        self.isPagingEnabled = enabled
        return self
    }
    
    @discardableResult
    func contentInset(_ value: UIEdgeInsets) -> Self {
        self.contentInset = value
        return self
    }
    
    @discardableResult
    func show(verticalScrollIndicator value: Bool) -> Self {
        self.showsVerticalScrollIndicator = value
        return self
    }
    
    @discardableResult
    func show(horizontalScrollIndicator value: Bool) -> Self {
        self.showsHorizontalScrollIndicator = value
        return self
    }
    
    func show(scrollIndicators value: Bool) -> Self {
        show(horizontalScrollIndicator: value)
        show(verticalScrollIndicator: value)
        return self
    }
    
    @discardableResult
    func verticalBouncedWhenNeeded() -> Self {
        self.alwaysBounceVertical = false
        return self
    }
    
    @discardableResult
    func horizontalBouncedWhenNeeded() -> Self {
        self.alwaysBounceHorizontal = false
        return self
    }
    
    func setOffsetToBottom(animated: Bool) {
        self.setContentOffset(CGPoint(x: 0, y: self.contentSize.height - self.frame.size.height), animated: true)
    }
}
