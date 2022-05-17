//  Easy
//
//  Created by Shalom Shwaitzer on 29/07/2018.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import UIKit
extension UIButton {

    @discardableResult
    public func title(_ value: String, for state: UIControl.State = .normal) -> Self {
        self.setTitle(value, for: state)
        return self
    }

    @discardableResult
    public func centerVertically(padding: CGFloat = 0.0) -> Self {

        guard let imageView = self.currentImage,
            let titleLabel = self.titleLabel?.text else { return self }

        let sign: CGFloat = 1
        self.titleEdgeInsets = UIEdgeInsets(top: (imageView.size.height + padding) * sign, left: -imageView.size.width, bottom: 0, right: 0)

        let titleSize = titleLabel.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font!])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + padding) * sign, left: 0, bottom: 0, right: -titleSize.width)

        return self
    }

    @discardableResult
        public func textAlignment(_ value: NSTextAlignment) -> Self {

        var ta = UIControl.ContentHorizontalAlignment.center

        switch value {
        case .left: ta = .leading
        case .right: ta = .trailing
        case .center: ta = .center
        default:
            break
        }

        self.contentHorizontalAlignment = ta
        return self
    }

    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.titleLabel?.font = font
        return self
    }

    @discardableResult
    public func titleEdge(inset: UIEdgeInsets) -> Self {
        self.titleEdgeInsets = inset
        return self
    }

    @discardableResult
    public func imageEdge(inset: UIEdgeInsets) -> Self {
        self.imageEdgeInsets = inset
        return self
    }

    @discardableResult
    public func withImage(_ image: UIImage, for state: UIControl.State = .normal) -> Self {
        self.setImage(image, for: state)
        return self
    }

    @discardableResult
    public func withTitle(_ title: String, for state: UIControl.State = .normal) -> Self {
        self.setTitle(title, for: state)
        return self
    }

    @discardableResult
    public func textColor(_ color: UIColor) -> Self {
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(color.withAlphaComponent(0.5), for: .highlighted)
        return self
    }

    @discardableResult
    public func textColor(_ color: UIColor, for state: UIControl.State) -> Self {
        self.setTitleColor(color, for: state)
        return self
    }

    @discardableResult
    public func contentEdgeInsets(_ inset: UIEdgeInsets) -> Self {
        self.contentEdgeInsets = inset
        return self
    }

    @discardableResult
    public func withPadding(_ padding: CGFloat) -> UIButton {
        self.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        return self
    }

    @discardableResult
    public func tintColor(_ color: UIColor) -> UIButton {
        self.tintColor = color
        return self
    }

    @discardableResult
    public func horizontalAlignment(_ align: UIControl.ContentHorizontalAlignment) -> UIButton {
        self.contentHorizontalAlignment = align
        return self
    }

    @discardableResult
    public func verticalAlignment(_ align: UIControl.ContentVerticalAlignment) -> Self {
        self.contentVerticalAlignment = align
        return self
    }

    @available(iOS 14.0, *)
    @discardableResult
    func add(action: UIAction, for event: UIControl.Event) -> Self {
        addAction(action, for: event)
        return self
    }

    @discardableResult
    public func add(target: Any?, action: Selector, for controlEvents: UIControl.Event = .touchUpInside) -> Self {
        self.addTarget(target, action: action, for: controlEvents)
        return self
    }

    @discardableResult
    public func add(target: Any?, action: Selector, for controlEvents: UIControl.Event...) -> Self {
        controlEvents.forEach({ self.addTarget(target, action: action, for: $0) })
        return self
    }

    @discardableResult
    public func isEnabled(_ enabled: Bool) -> Self {
        self.isEnabled = enabled
        return self
    }

    @discardableResult
    public func add(action: Selector, withSender sender: Any? = nil) -> Self {
        self.target(forAction: action, withSender: sender)
        return self
    }

    @discardableResult
    override public func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.imageView?.contentMode = contentMode
        return self
    }

    @discardableResult
    public func isSelected(_ value: Bool) -> Self {
        isSelected = value
        return self
    }
}

private var _uibuttonActionKey: UInt8 = 8

extension UIButton {

    public struct Action {

        public typealias Block = (Action) -> Void

        public var title: String = ""
        public var handler: Block?

        public init(title: String, _ handler: @escaping Block) {
            self.title = title
            self.handler = handler
        }

        public init(handler: @escaping Block) {
            self.handler = handler
        }
    }

    private var _action: Action? {
        get { objc_getAssociatedObject(self, &_uibuttonActionKey) as? Action }
        set { objc_setAssociatedObject(self, &_uibuttonActionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    @discardableResult
    public func add(action handler: @escaping Action.Block, for event: UIControl.Event) -> Self {
        let action = Action(handler: handler)
        add(action: action, for: event)
        return self
    }

    @discardableResult
    public func add(action: Action, for event: UIControl.Event) -> Self {
        self._action = action
        addTarget(self, action: #selector(performAction), for: event)
        return self
    }

    @objc func performAction() {
        guard let action = _action else { return }
        action.handler?(action)
    }
}
