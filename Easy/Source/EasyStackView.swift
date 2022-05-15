//
//  EasyStackView.swift
//  Easy
//
//  Created by Shalom on 19/04/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import UIKit

public typealias Spacer = UIStackView.Spacer
public typealias Divider = UIStackView.Divider
    
public extension UIStackView {
    
    class Spacer: UIView {
        
        public init(_ value: CGFloat = 0) {
            super.init(frame: value.cgSize.asRect)
            if value == 0 {
                self.hugContent(axis: .horizontal, priority: 1.priority)
            }
        }
        
        public init(_ axis: NSLayoutConstraint.Axis = .horizontal, _ value: CGFloat = 0) {
            super.init(frame: value.cgSize.asRect)
            if value == 0 {
                self.hugContent(axis: axis, priority: 1.priority)
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override public var intrinsicContentSize: CGSize {
            self.frame.size
        }
    }
    
    class Divider: UIView {
        public init(_ axis: NSLayoutConstraint.Axis = .horizontal) {
            super.init(frame: .zero)
            backgroundColor(.lightGray)
            if axis == .horizontal {
                make({ $0.height.equalTo(1) })
            } else {
                make({ $0.width.equalTo(1) })
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    @discardableResult
    func axis(_ axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        
        return self
    }
    
    @discardableResult
    func spacing(_ value: CGFloat) -> Self {
        self.spacing = value
        return self
    }
    
    @discardableResult
    func alignment(_ value: UIStackView.Alignment) -> Self {
        self.alignment = value
        return self
    }
    
    @discardableResult
    func distribution(_ value: UIStackView.Distribution) -> Self {
        self.distribution = value
        return self
    }
    
    @discardableResult
    func isBaselineRelativeArrangement(_ value: Bool) -> Self {
        self.isBaselineRelativeArrangement = value
        return self
    }
    
    @discardableResult
    func margins(_ value: UIEdgeInsets) -> Self {
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = value
        
        return self
    }
    
    @discardableResult
    func margins(_ value: CGFloat) -> Self {
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = .init(top: value, left: value, bottom: value, right: value)
        
        return self
    }
}

public extension Array {
    
    func stack(_ axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        
        for element in self {
            var view: UIView!
            if element is String {
                view = UIView().hugContent(axis: .horizontal, priority: 1.priority)
            } else if element is Spacer {
                view = (element as! UIView)
                
                if axis == .vertical {
                   view.frame.size.width = 0
                } else {
                    view.frame.size.height = 0
                }
            } else if let element = element as? UIView {
                view = element
            }
            
            stackView.addArrangedSubview(view)
        }
        
        return stackView
    }
    
    func view() -> UIView {
        let view = UIView()
        for element in self where element is UIView {
            if let v = element as? UIView {
                view.addSubview(v)
                v.snapEdges()
            }
        }
        
        return view
    }
}

public extension UIStackView {
    func removeAll() {
        self.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func addArranged(subviews: UIView...) {
        subviews.forEach { addArrangedSubview($0) }
    }
    
    func addArranged(subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }
}
