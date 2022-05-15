//
//  EasyTextView.swift
//  Easy
//
//  Created by Shalom on 12/04/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import UIKit

public extension UITextView {
    
    @discardableResult
    func allowAnyEditing(_ value: Bool) -> Self {
        allowsEditingTextAttributes = value
        isEditable = value
        return self
    }
    
    @discardableResult
    func isEditable(_ value: Bool) -> Self {
        isEditable = value
        return self
    }
    
    @discardableResult
    func allowsEditingTextAttributes(_ value: Bool) -> Self {
        allowsEditingTextAttributes = value
        return self
    }
    
    @discardableResult
    func isSelectable(_ value: Bool) -> Self {
        isSelectable = value
        return self
    }
    
    @discardableResult
    func text(html: String) -> Self {
        
        guard let data = html.data(using: .utf8) else { return self }
        do {
            attributedText = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                          .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return self
        }
        
        return self
    }
    
    @discardableResult
    func text(_ value: String) -> Self {
        text = value
        return self
    }
    
    @discardableResult
    func text(attributed value: NSAttributedString) -> Self {
        attributedText = value
        return self
    }
    
}
