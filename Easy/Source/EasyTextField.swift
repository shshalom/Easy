//
//  EasyTextField.swift
//  Easy
//
//  Created by Eliran Sharabi on 06/01/2021.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import UIKit

public extension UITextField {
    @discardableResult func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult func adjustsFontSizeToFitWidth(_ adjust: Bool) -> Self {
        self.adjustsFontSizeToFitWidth = adjust
        return self
    }
    
    @discardableResult func textColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    @discardableResult func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult func leftPadding(_ value: CGFloat) -> Self {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
        return self
    }
    
    @discardableResult func secured() -> Self {
        self.isSecureTextEntry = true
        return self
    }
    
    @discardableResult func placeholder(_ value: String) -> Self {
        self.placeholder = value
        return self
    }
    
    @discardableResult func keyboard(type: UIKeyboardType) -> Self {
        keyboardType = type
        return self
    }
    
    @discardableResult func text(_ text: String) -> Self {
        self.text = text
        return self
    }

    @discardableResult func returnKey(type: UIReturnKeyType) -> Self {
        self.returnKeyType = type
        return self
    }
    
    @discardableResult func textContent(type: UITextContentType) -> Self {
        self.textContentType = type
        return self
    }
    
    @discardableResult func delegate(_ delegate: UITextFieldDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult func addDoneButtonToKeyboard() -> Self {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
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

