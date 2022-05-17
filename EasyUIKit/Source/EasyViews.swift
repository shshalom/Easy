import Foundation
import UIKit

extension UIView {

    @discardableResult
    public func add(subview view: UIView) -> Self {
        addSubview(view)

        return self
    }

    @discardableResult
    public func add(subviews views: UIView...) -> Self {
        views.forEach({ addSubview($0) })

        return self
    }

    @discardableResult
    public func add(subviews views: [UIView]) -> Self {
        views.forEach({ addSubview($0) })

        return self
    }

    @discardableResult @objc
    public func alpha(_ value: CGFloat) -> Self {
        self.alpha = value
        return self
    }

    @discardableResult
    public func maskToBounds(_ value: Bool) -> Self {
        self.layer.masksToBounds = value
        return self
    }

    @discardableResult
    public func backgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }

    /*
     ⎧‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾⎫
     →→ ⎪✋🏻==== 😠 ====🤚🏻⎪ ←←
     ⎩⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎭
     I am not gonna let you shrink me!
     */
    @discardableResult
    public func wrapContent(axis: NSLayoutConstraint.Axis? = nil, priority: UILayoutPriority = UILayoutPriority.required ) -> Self {
        let both = axis == nil
        if axis == .horizontal || both {
            self.setContentCompressionResistancePriority(priority, for: .horizontal)
        }
        if axis == .vertical || both {
            self.setContentCompressionResistancePriority(priority, for: .vertical)
        }
        return self
    }

    /*               ⎽⎽🥵⎽⎽⎽
     ⎧‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾⎫
     ✋🏻⎪ <---    ---> ⎪🤚🏻
     ⎩⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎭
     I am not gonna let you grow!
     */
    @discardableResult
    public func hugContent(axis: NSLayoutConstraint.Axis? = nil, priority: UILayoutPriority = .required) -> Self {
        let both = axis == nil
        if axis == .horizontal || both {
            self.setContentHuggingPriority(priority, for: .horizontal)
        }
        if axis == .vertical || both {
            self.setContentHuggingPriority(priority, for: .vertical)
        }
        return self
    }

    @discardableResult
    public func corner(radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        self.clipsToBounds = radius != 0
        return self
    }

    @discardableResult
    public func border(width: CGFloat, color: UIColor, dashed: Bool = false) -> Self {
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

    @discardableResult
    public func pressGesture(target: Any?, action: Selector) -> Self {
        let gesture = UILongPressGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(gesture)

        return self
    }

    @discardableResult
    public func tapGesture(target: Any?, action: Selector) -> Self {
        let gesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(gesture)

        return self
    }

    @discardableResult
    public func corners(_ corners: UIRectCorner, radius: CGFloat) -> Self {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape

        return self
    }

    @discardableResult
    public func mask(with layer: CALayer) -> Self {
        self.layer.mask = layer

        return self
    }

    @discardableResult
    public func zPosition(value: CGFloat) -> Self {
        self.layer.zPosition = value
        return self
    }

    @discardableResult
    public func clip(_ value: Bool = true) -> Self {
        self.layer.masksToBounds = value
        return self
    }

    @discardableResult
    public func isUserInteraction(enabled: Bool) -> Self {
        self.isUserInteractionEnabled = enabled
        return self
    }

    @discardableResult
    public func rounded() -> Self {
        self.corner(radius: frame.size.height / 2)
        return self
    }

    public var imageSnapshot: UIImage {
        let renderer = UIGraphicsImageRenderer(size: frame.size)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }

    @discardableResult
    @objc public func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }

    @discardableResult
    public func tint(color: UIColor) -> Self {
        self.tintColor = color
        return self
    }

    @discardableResult
    public func removeAllSubsviews() -> Self {
        self.subviews.forEach({ $0.removeFromSuperview() })
        return self
    }

    @discardableResult
    public func underline() -> Self {
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 0.0
        return self
    }

    @discardableResult
    public func drawTopLine(color: UIColor = .white, height: CGFloat = 1.0) -> Self {
        let underlineLayer = CALayer()
        underlineLayer.backgroundColor = color.cgColor
        underlineLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: height)
        self.layer.addSublayer(underlineLayer)
        return self
    }

    public var isRTL: Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }

    public func wiggle() {
        let wiggleAnim = CABasicAnimation(keyPath: "position")
        wiggleAnim.duration = 0.1
        wiggleAnim.repeatCount = 5
        wiggleAnim.autoreverses = true
        wiggleAnim.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y)
        wiggleAnim.toValue = CGPoint(x: self.center.x + 4.0, y: self.center.y)
        layer.add(wiggleAnim, forKey: "position")
    }
}

@objc extension UIView {
    @discardableResult
    public func isHidden(_ hidden: Bool) -> Self {
        self.isHidden = hidden
        return self
    }

    @discardableResult
    public func addShadow() -> Self {
        self.shadow(style: .color(.black),
                    .offsetX(0.0),
                    .offsetY(1.0),
                    .opacity(0.2),
                    .radius(2.0))
        return self
    }

    @discardableResult
    public func removeShadow() -> Self {
        self.shadow(style: .color(.clear),
                    .offsetX(0.0),
                    .offsetY(0.0),
                    .opacity(0.0),
                    .radius(0.0))
        return self
    }
}

extension UIControl {
    @discardableResult
    public func action(_ handler: @escaping UIActionHandler, for event: Event = .touchUpInside) -> Self {
        if #available(iOS 14.0, *) {
            addAction(.init(handler: handler), for: event)
        } else {
            // Fallback on earlier versions
        }
        return self
    }
}

extension UIImageView {

    @discardableResult
    public func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
}

extension String {
    public var label: UILabel {
        let label = UILabel()
        label.text = self
        return label
    }

    public var textField: UITextField {
        let tf = UITextField()
        tf.text = self
        return tf
    }

    public var button: UIButton {
        return button(withType: .system)
    }

    public var barButton: UIBarButtonItem {
        return UIBarButtonItem(title: self, style: .plain, target: nil, action: nil)
    }

    public func tabBarButton(tag: Int = 0) -> UITabBarItem {
        return UITabBarItem(title: self, image: nil, tag: tag)
    }

    public func button(withType type: UIButton.ButtonType) -> UIButton {
        let button = UIButton(type: type)
        button.setTitle(self, for: .normal)
        return button
    }

    public var image: UIImage? {
        if self.isEmpty {
            return UIImage()
        }
        return UIImage(named: self)
    }

    public var url: URL? {
        return URL(string: self)
    }

    public var phoneUrl: URL? {
        return URL(string: "tel://\(self)")
    }

    public var isHtml: Bool {
        self.range(of: #"<([a-z][a-z0-9]*)\b[^>]*>(.*?)<\/\1>"#, options: .regularExpression) != nil
    }

    public var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8),
                                              options: [
                                                .documentType: NSAttributedString.DocumentType.html,
                                                .characterEncoding: String.Encoding.utf8.rawValue,
                                              ],
                                              documentAttributes: nil).string

        return decoded ?? self
    }

    public var stripHtml: String {
        self.replacingOccurrences(of: #"<(.|\n)*?>"#, with: "", options: .regularExpression)
    }

    public func log() {
        print(self)
    }
}

// Exist else where.
// func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSMutableAttributedString {
//     let string = NSMutableAttributedString(attributedString: lhs)
//     string.append(rhs)
//     return string
// }

extension NSAttributedString {
    public var label: UILabel {
        let label = UILabel()
        label.attributedText = self
        return label
    }

    public var button: UIButton {
        let button = UIButton(type: .custom)
        button.setAttributedTitle(self, for: .normal)
        return button
    }

    public var barButton: UIBarButtonItem {
        let barButton = UIBarButtonItem()
        button.setAttributedTitle(self, for: .normal)
        button.setAttributedTitle(self, for: .selected)
        return barButton
    }
}

extension UIBarButtonItem {

    @discardableResult
    public func tap(target: Any?, action: Selector) -> Self {
        self.action = action
        self.target = target as AnyObject
        return self
    }

    @discardableResult
    public func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }

    @discardableResult
    public func font(_ font: UIFont, for state: UIControl.State? = nil) -> Self {
        var atts = self.titleTextAttributes(for: state ?? .normal) ?? [:]
        atts.updateValue(font, forKey: NSAttributedString.Key.font)

        self.setTitleTextAttributes(atts, for: state ?? .normal)
        if state == nil {
            self.setTitleTextAttributes(atts, for: .highlighted)
        }
        return self
    }

    @discardableResult
    public func textColor(_ color: UIColor, for state: UIControl.State? = nil) -> Self {
        var atts = self.titleTextAttributes(for: state ?? .normal) ?? [:]
        atts.updateValue(color, forKey: NSAttributedString.Key.foregroundColor)

        self.setTitleTextAttributes(atts, for: state ?? .normal)
        if state == nil {
            self.setTitleTextAttributes(atts, for: .highlighted)
        }
        return self
    }

    @discardableResult
    public func accessibility(label: String) -> Self {
        accessibilityLabel = label
        accessibilityHint = label
        return self
    }
}

extension Array where Element: UITabBarItem {

    public var tabBar: UITabBar {
        let tb = UITabBar()
        tb.items = self
        tb.itemPositioning = .automatic

        return tb
    }
}

extension UIColor {
    public func image(ofSize size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

extension Int {
    public var priority: UILayoutPriority {
        return UILayoutPriority(rawValue: Float(self))
    }
}

extension UIViewController {
    public func insideNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
