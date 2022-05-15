//
//  EasyViews.swift
//  Easy
//
//  Created by Shalom Shwaitzer on 29/01/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public extension UIView {
    
    @discardableResult
    func add(subviews views: UIView...) -> Self {
        views.forEach({ addSubview($0) })
        
        return self
    }
    
    @discardableResult
    func add(subviews views: [UIView]) -> Self {
        views.forEach({ addSubview($0) })
        
        return self
    }
    
    @discardableResult @objc func alpha(_ value: CGFloat) -> Self {
        self.alpha = value
        return self
    }
    
    @discardableResult func maskToBounds(_ value: Bool) -> Self {
        self.layer.masksToBounds = value
        return self
    }
    
    @discardableResult func backgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult func wrapContent(axis: NSLayoutConstraint.Axis? = nil, priority: UILayoutPriority = UILayoutPriority.required ) -> Self {
        let both = axis == nil
        if axis == .horizontal || both {
            self.setContentCompressionResistancePriority(priority, for: .horizontal)
        }
        if axis == .vertical || both {
            self.setContentCompressionResistancePriority(priority, for: .vertical)
        }
        return self
    }
    
    @discardableResult func hugContent(axis: NSLayoutConstraint.Axis? = nil, priority: UILayoutPriority = .required) -> Self {
        let both = axis == nil
        if axis == .horizontal || both {
            self.setContentHuggingPriority(priority, for: .horizontal)
        }
        if axis == .vertical || both {
            self.setContentHuggingPriority(priority, for: .vertical)
        }
        return self
    }
    
    @discardableResult func corner(radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        self.clipsToBounds = radius != 0
        return self
    }
    
    @discardableResult func border(width: CGFloat, color: UIColor, dashed: Bool = false) -> Self {
        if dashed {
            let borderView = CAShapeLayer()
            borderView.strokeColor = color.cgColor
            borderView.lineDashPattern = [1, 1]
            borderView.frame = self.bounds
            borderView.fillColor = nil
            borderView.cornerRadius = self.layer.cornerRadius
            borderView.path = UIBezierPath(rect: self.bounds).cgPath
            self.layer.addSublayer(borderView)
        } else {
            self.layer.borderWidth = width
            self.layer.borderColor = color.cgColor
        }
        
        return self
    }
    
    @discardableResult func pressGesture(target: Any?, action: Selector) -> Self {
        let gesture = UILongPressGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(gesture)
        
        return self
    }
    
    @discardableResult func tapGesture(target: Any?, action: Selector) -> Self {
        let gesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(gesture)
        
        return self
    }
    
    @discardableResult func corners(_ corners: UIRectCorner, radius: CGFloat) -> Self {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
        
        return self
    }
    
    @discardableResult func mask(with layer: CALayer) -> Self {
        self.layer.mask = layer
        
        return self
    }
    
    @discardableResult func zPosition(value: CGFloat) -> Self {
        self.layer.zPosition = value
        return self
    }
    
    @discardableResult func clip(_ value: Bool = true) -> Self {
        self.layer.masksToBounds = value
        return self
    }
    
    @discardableResult func isUserInteraction(enabled: Bool) -> Self {
        self.isUserInteractionEnabled = enabled
        return self
    }
    
    @discardableResult func rounded() -> Self {
        self.corner(radius: frame.size.height/2)
        return self
    }
    
    var image: UIImage {
        let renderer = UIGraphicsImageRenderer(size: frame.size)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
    
    @discardableResult
    func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
    
    @discardableResult
    func tint(color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
    @discardableResult
    func removeAllSubsviews() -> Self {
        self.subviews.forEach({ $0.removeFromSuperview() })
        return self
    }
    
    @discardableResult
    func underline() -> Self {
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 0.0
        return self
    }
    
    @discardableResult
    func drawTopLine(color: UIColor = .white, height: CGFloat = 1.0) -> Self {
        let underlineLayer = CALayer()
        underlineLayer.backgroundColor = color.cgColor
        underlineLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: height)
        self.layer.addSublayer(underlineLayer)
        return self
    }
    
    var isRTL: Bool {
       return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
}

@objc public extension UIView {
    @discardableResult func isHidden(_ hidden: Bool) -> Self {
        self.isHidden = hidden
        return self
    }
    
    @discardableResult func addShadow() -> Self {
        self.shadow(style: .color(.black),
                    .offsetX(0.0),
                    .offsetY(1.0),
                    .opacity(0.2),
                    .radius(2.0))
        return self
    }
    
    @discardableResult func removeShadow() -> Self {
        self.shadow(style: .color(.clear),
                    .offsetX(0.0),
                    .offsetY(0.0),
                    .opacity(0.0),
                    .radius(0.0))
        return self
    }
    
}

public extension UIControl {
    @discardableResult func tap(target: Any?, action: Selector) -> Self {
        addTarget(target, action: action, for: .touchUpInside)
        return self
    }
}

public extension UIButton {
    
    @discardableResult func title(_ value: String, for state: UIControl.State = .normal) -> Self {
        self.setTitle(value, for: state)
        return self
    }
    
    @discardableResult func centerVertically(padding: CGFloat = 0.0) -> Self {
        
        guard let imageView = self.currentImage,
            let titleLabel = self.titleLabel?.text else { return self }
        
        let sign: CGFloat = 1
        self.titleEdgeInsets = UIEdgeInsets(top: (imageView.size.height + padding) * sign, left: -imageView.size.width, bottom: 0, right: 0)
        
        let titleSize = titleLabel.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font!])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + padding) * sign, left: 0, bottom: 0, right: -titleSize.width)
        
        return self
    }
    
    @discardableResult func font(_ font: UIFont) -> Self {
        self.titleLabel?.font = font
        return self
    }
    
    @discardableResult func titleEdge(inset: UIEdgeInsets) -> Self {
        self.titleEdgeInsets = inset
        return self
    }
    
    @discardableResult func withImage(_ image: UIImage) -> Self {
        self.setImage(image, for: .normal)
        return self
    }
    
    @discardableResult func textColor(_ color: UIColor) -> Self {
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(color.withAlphaComponent(0.5), for: .highlighted)
        return self
    }
    
    @discardableResult func contentEdgeInsets(_ inset: UIEdgeInsets) -> Self {
        self.contentEdgeInsets = inset
        return self
    }
    
    @discardableResult func withPadding(_ padding: CGFloat) -> UIButton {
        self.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        return self
    }
    
    @discardableResult func tintColor(_ color: UIColor) -> UIButton {
        self.tintColor = color
        return self
    }
    
    @discardableResult func horizontalAlignment(_ align: UIControl.ContentHorizontalAlignment) -> UIButton {
        self.contentHorizontalAlignment = align
        return self
    }
    
    @discardableResult func verticalAlignment(_ align: UIControl.ContentVerticalAlignment) -> Self {
        self.contentVerticalAlignment = align
        return self
    }
    
    @discardableResult func add(target: Any?, action: Selector, for controlEvents: UIControl.Event = .touchUpInside) -> Self {
        self.addTarget(target, action: action, for: controlEvents)
        return self
    }
    
    @discardableResult func add(target: Any?, action: Selector, for controlEvents: UIControl.Event...) -> Self {
        controlEvents.forEach({ self.addTarget(target, action: action, for: $0) })
        return self
    }
    
    @discardableResult func isEnabled(_ enabled: Bool) -> Self {
        self.isEnabled = enabled
        return self
    }
    //
    //    @discardableResult func add(action: Selector, withSender sender: Any? = nil) -> Self {
    //        self.target(forAction: action, withSender: sender)
    //        return self
    //    }
}

public extension UIImageView {
    
    @discardableResult func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
}

public extension String {
    var label: UILabel {
        let label = UILabel()
        label.text = self
        return label
    }
    
    var textField: UITextField {
        let tf = UITextField()
        tf.text = self
        return tf
    }
    
    var button: UIButton {
        return button(withType: .system)
    }
    
    var barButton: UIBarButtonItem {
        return UIBarButtonItem(title: self, style: .plain, target: nil, action: nil)
    }
    
    func tabBarButton(tag: Int = 0) -> UITabBarItem {
        return UITabBarItem(title: self, image: nil, tag: tag)
    }
    
    func button(withType type: UIButton.ButtonType) -> UIButton {
        let button = UIButton(type: type)
        button.setTitle(self, for: .normal)
        return button
    }
    
    var image: UIImage? {
        if self.isEmpty {
            return UIImage()
        }
        return UIImage(named: self)
    }
    
    var url: URL? {
        return URL(string: self)
    }
    
    var phoneUrl: URL? {
        return URL(string: "tel://\(self)")
    }
    
    func log() {
        print(self)
    }
}

func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSMutableAttributedString {
    let string = NSMutableAttributedString(attributedString: lhs)
    string.append(rhs)
    return string
}

public extension NSAttributedString {
    var label: UILabel {
        let label = UILabel()
        label.attributedText = self
        return label
    }
    
    var button: UIButton {
        let button = UIButton(type: .custom)
        button.setAttributedTitle(self, for: .normal)
        return button
    }
    
    var barButton: UIBarButtonItem {
        let barButton = UIBarButtonItem()
        button.setAttributedTitle(self, for: .normal)
        button.setAttributedTitle(self, for: .selected)
        return barButton
    }
}

public extension UIImage {
    var view: UIImageView {
        return UIImageView(image: self)
    }
    
    var button: UIButton {
        return button(with: .system)
    }
    
    var barButton: UIBarButtonItem {
        return UIBarButtonItem(image: self, style: .plain, target: nil, action: nil)
    }
    
    var barCustomButton: UIBarButtonItem {
        let button = self.button(with: .custom)
        return UIBarButtonItem(customView: button)
    }
    
    func tabBarButton(tag: Int = 0) -> UITabBarItem {
        return UITabBarItem(title: nil, image: self, tag: tag)
    }
    
    func button(with type: UIButton.ButtonType) -> UIButton {
        let button = UIButton(type: type)
        button.frame = CGRect(origin: .zero, size: self.size)
        button.setImage(self, for: .normal)
        return button
    }
    
    var template: UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }
    
    func scale(toSize newSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(cgImage, in: newRect)
            if let img = context.makeImage() {
                newImage = UIImage(cgImage: img)
            }
            UIGraphicsEndImageContext()
        }
        return newImage
    }
}

public extension UIBarButtonItem {
    
    @discardableResult func tap(target: Any?, action: Selector) -> Self {
        self.action = action
        self.target = target as AnyObject
        return self
    }
    
    @discardableResult func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
    @discardableResult func font(_ font: UIFont, for state: UIControl.State? = nil) -> Self {
        var atts = self.titleTextAttributes(for: state ?? .normal) ?? [:]
        atts.updateValue(font, forKey: NSAttributedString.Key.font)
        
        self.setTitleTextAttributes(atts, for: state ?? .normal)
        if state == nil {
            self.setTitleTextAttributes(atts, for: .highlighted)
        }
        return self
    }
    
    @discardableResult func textColor(_ color: UIColor, for state: UIControl.State? = nil) -> Self {
        var atts = self.titleTextAttributes(for: state ?? .normal) ?? [:]
        atts.updateValue(color, forKey: NSAttributedString.Key.foregroundColor)
        
        self.setTitleTextAttributes(atts, for: state ?? .normal)
        if state == nil {
            self.setTitleTextAttributes(atts, for: .highlighted)
        }
        return self
    }
    
    @discardableResult
    func accessibility(label: String) -> Self {
        accessibilityLabel = label
        accessibilityHint = label
        return self
    }
}

public extension Array where Element: UITabBarItem {
    
    var tabBar: UITabBar {
        let tb = UITabBar()
        tb.items = self
        tb.itemPositioning = .automatic
        
        return tb
    }
}

public extension UIColor {
    func image(ofSize size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

public extension Int {
    var priority: UILayoutPriority {
        return UILayoutPriority(rawValue: Float(self))
    }
}

public extension UIViewController {
    func insideNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}

public extension ConstraintMaker {
     func aspectRatio(_ x: Int, by y: Int, self instance: ConstraintView) {
        self.width.equalTo(instance.snp.height).multipliedBy(x / y)
    }
}
