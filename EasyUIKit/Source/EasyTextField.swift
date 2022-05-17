//
//  EasyTextField.swift
//  Easy
//
//  Created by Eliran Sharabi on 06/01/2021.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import UIKit

extension UITextField {
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    public func adjustsFontSizeToFitWidth(_ adjust: Bool) -> Self {
        self.adjustsFontSizeToFitWidth = adjust
        return self
    }

    @discardableResult
    public func textColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    public func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }

    @discardableResult
    public func leftPadding(_ value: CGFloat) -> Self {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always

        return self
    }

    @discardableResult
    public func secured() -> Self {
        self.isSecureTextEntry = true
        return self
    }

    @discardableResult
    public func placeholder(_ value: String) -> Self {
        self.placeholder = value
        return self
    }

    @discardableResult
    public func keyboard(type: UIKeyboardType) -> Self {
        keyboardType = type
        return self
    }

    @discardableResult
    public func autocorrect(_ value: Bool) -> Self {
        autocorrectionType = value ? .yes : .no
        return self
    }

    @discardableResult
    public func text(_ text: String) -> Self {
        self.text = text
        return self
    }

    @discardableResult
    public func returnKey(type: UIReturnKeyType) -> Self {
        self.returnKeyType = type
        return self
    }

    @discardableResult
    public func textContent(type: UITextContentType) -> Self {
        self.textContentType = type
        return self
    }

    @discardableResult
    public func rightView(mode: ViewMode) -> Self {
        self.rightViewMode = mode
        return self
    }

    @discardableResult
    public func clearButton(mode: ViewMode) -> Self {
        self.clearButtonMode = mode
        return self
    }

    @discardableResult
    public func rightView(_ view: UIView, mode: ViewMode = .always) -> Self {
        self.rightView = view
        self.rightViewMode = mode
        return self
    }

    @discardableResult
    public func leftView(_ view: UIView, padding: CGFloat = 0, mode: ViewMode = .always) -> Self {

        let v = UIView().add(subviews: view)
        v.frame = view.bounds
        v.frame.size.width += padding
        self.leftView = v
        self.leftViewMode = mode
        return self
    }

    @discardableResult
    public func delegate(_ delegate: UITextFieldDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    public func addDoneButtonToKeyboard() -> Self {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resignFirstResponder))
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
        return self
    }
}
