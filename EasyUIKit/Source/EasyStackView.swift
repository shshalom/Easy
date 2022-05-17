//
//  EasyStackView.swift
//  Easy
//
//  Created by Shalom on 19/04/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import UIKit
#if canImport(SnapKit)
import SnapKit
#endif

public typealias Spacer = UIStackView.Spacer
public typealias Divider = UIStackView.Divider

extension UIStackView.Spacer {
    public class H: Spacer {
        convenience init() {
            self.init(.horizontal)
        }
    }

    public class V: Spacer {
        convenience init() {
            self.init(.vertical)
        }
    }
}

extension UIStackView {

    public class Spacer: UIView {

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
#if canImport(SnapKit)
    public class Divider: UIView {
        public init(_ axis: NSLayoutConstraint.Axis = .horizontal) {
            super.init(frame: .zero)
            backgroundColor(.lightGray)
            if axis == .horizontal {
                snp.makeConstraints({ $0.height.equalTo(1) })
            } else {
                snp.makeConstraints({ $0.width.equalTo(1) })
            }
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
#endif

    @discardableResult
    public func axis(_ axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis

        return self
    }

    @discardableResult
    public func spacing(_ value: CGFloat) -> Self {
        self.spacing = value
        return self
    }

    @discardableResult
    public func alignment(_ value: UIStackView.Alignment) -> Self {
        self.alignment = value
        return self
    }

    @discardableResult
    public func distribution(_ value: UIStackView.Distribution) -> Self {
        self.distribution = value
        return self
    }

    @discardableResult
    public func isBaselineRelativeArrangement(_ value: Bool) -> Self {
        self.isBaselineRelativeArrangement = value
        return self
    }

    @discardableResult
    public func margins(_ value: UIEdgeInsets) -> Self {
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = value

        return self
    }

    @discardableResult
    public func margins(_ value: CGFloat) -> Self {
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = .init(top: value, left: value, bottom: value, right: value)

        return self
    }
}

extension Array where Element: UIView {

    public func stack(_ axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis

        for element in self {
            if element is Spacer {
                if axis == .vertical {
                    element.frame.size.width = 0
                } else {
                    element.frame.size.height = 0
                }
            }

            stackView.addArrangedSubview(element)
        }

        return stackView
    }

    public func view() -> UIView {
        let view = UIView()
        for element in self {
            view.addSubview(element)
            element.snp.makeConstraints({ $0.edges.equalToSuperview() })
        }

        return view
    }
}

extension UIStackView {
    public func removeAll() {
        self.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }

    @discardableResult
    public func addArranged(subviews: UIView...) -> Self {
        subviews.forEach(addArrangedSubview(_:))
        return self
    }

    @discardableResult
    public func addArranged(subviews: [UIView]) -> Self {
        subviews.forEach(addArrangedSubview(_:))
        return self
    }

    @discardableResult
    public func addArranged(view: UIView) -> Self {
        addArrangedSubview(view)
        return self
    }

    @discardableResult
    public func insertArranged(views: [UIView], at index: Int) -> Self {
        var index = index
        views.forEach({
            self.insertArrangedSubview($0, at: index)
            index += 1
        })
        return self
    }

    @discardableResult
    public func insertArranged(view: UIView, at index: Int) -> Self {
        self.insertArrangedSubview(view, at: index)
        return self
    }
}
