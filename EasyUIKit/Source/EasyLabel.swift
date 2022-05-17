//
//  EasyLabel.swift
//  Easy
//
//  Created by Eliran Sharabi on 06/01/2021.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import UIKit

@objc extension UILabel {
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    public func minimumFontSize(_ size: CGFloat) -> UILabel {
        self.minimumScaleFactor = size / self.font.pointSize
        return self
    }

    @discardableResult
    public func adjustsFontSizeToFitWidth(_ adjust: Bool) -> UILabel {
        self.adjustsFontSizeToFitWidth = adjust
        return self
    }

    @discardableResult
    public func textColor(_ color: UIColor) -> UILabel {
        self.textColor = color
        return self
    }

    @discardableResult
    public func numberOfLines(_ number: Int) -> UILabel {
        self.numberOfLines = number
        return self
    }

    @discardableResult
    public func multiline() -> UILabel {
        self.numberOfLines = 0
        return self
    }

    @discardableResult
    public func textAlignment(_ textAlignment: NSTextAlignment) -> UILabel {
        self.textAlignment = textAlignment
        return self
    }

    @discardableResult
    public func preferred(maxWidth value: CGFloat) -> Self {
        self.preferredMaxLayoutWidth = value
        return self
    }

    @discardableResult
    public func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
        self.lineBreakMode = mode
        return self
    }

    @discardableResult
    public func lineSpacing(_ spacing: CGFloat = 0, lineHeightMultiple: CGFloat = 0.0) -> UILabel {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = spacing
        paragraph.lineHeightMultiple = lineHeightMultiple
        paragraph.alignment = textAlignment

        let text: NSMutableAttributedString
        if let attributedText = attributedText {
            text = NSMutableAttributedString(attributedString: attributedText)
        } else {
            text = NSMutableAttributedString(string: self.text ?? "")
        }

        text.addAttributes([NSAttributedString.Key.paragraphStyle: paragraph], range: NSRange(location: 0, length: text.length))
        self.attributedText = text

        return self
    }

    @discardableResult
    public func letterSpacing(_ spacing: CGFloat) -> UILabel {
        let text: NSMutableAttributedString
        if let attributedText = attributedText {
            text = NSMutableAttributedString(attributedString: attributedText)
        } else {
            text = NSMutableAttributedString(string: self.text ?? "")
        }

        // swiftlint:disable:next compiler_protocol_init
        let value = NSNumber(floatLiteral: Double(spacing))

        text.addAttribute(NSAttributedString.Key.kern, value: value, range: NSRange(location: 0, length: text.length))
        self.attributedText = text.copy() as? NSAttributedString

        return self
    }

    public var isEmpty: Bool {
        return self.text?.isEmpty ?? true
    }

    @discardableResult
    public func rtlAlignment() -> Self {
        self.textAlignment = isRTL ? .left : .right
        return self
    }
}
