//
//  Created by Shalom Shwaitzer on 29/07/2018.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import UIKit
import Foundation

private var _uidatePickerDateFormatterKey: UInt = 0

extension UIDatePicker {

    @available(iOS 13.4, *)
    @discardableResult
    public func picker(style: UIDatePickerStyle) -> Self {
        self.preferredDatePickerStyle = style
        return self
    }

    @discardableResult
    public func picker(mode: UIDatePicker.Mode) -> Self {
        self.datePickerMode = mode
        return self
    }

    @discardableResult
    public func date(_ value: Date) -> Self {
        self.date = value
        return self
    }

    @discardableResult
    public func range(min: Date?, max: Date?) -> Self {
        self.maximumDate = max
        self.minimumDate = min
        return self
    }
}

extension ClosedRange where Bound == Date {
    @available(iOS 13.4, *)
    public func picker(style: UIDatePickerStyle = .wheels) -> UIDatePicker {
        Date().picker(style: style)
            .range(min: self.lowerBound, max: self.upperBound)
    }

    public func picker() -> UIDatePicker {
        Date().picker()
            .range(min: self.lowerBound, max: self.upperBound)
    }
}

extension PartialRangeFrom where Bound == Date {
    @available(iOS 13.4, *)
    public func picker(style: UIDatePickerStyle = .wheels) -> UIDatePicker {
        Date().picker(style: style)
            .range(min: self.lowerBound, max: nil)
    }

    public func picker() -> UIDatePicker {
        if #available(iOS 13.4, *) {
            return Date().picker(style: .wheels)
                .range(min: self.lowerBound, max: nil)
        } else {
            return Date().picker()
                .range(min: self.lowerBound, max: nil)
        }
    }
}

extension PartialRangeThrough where Bound == Date {
    @available(iOS 13.4, *)
    public func picker(style: UIDatePickerStyle = .wheels) -> UIDatePicker {
        Date().picker(style: style)
            .range(min: nil, max: self.upperBound)
    }

    public func picker() -> UIDatePicker {
        Date().picker()
            .range(min: nil, max: self.upperBound)
    }
}

extension Date {

    public enum Format {
        case format(String)
        case dateStyle(DateFormatter.Style)
        case timeStyle(DateFormatter.Style)
    }

    @available(iOS 13.4, *)
    public func picker(style: UIDatePickerStyle = .wheels) -> UIDatePicker {
        return UIDatePicker(frame: .zero)
            .picker(style: style)
            .date(self)
    }

    public func picker() -> UIDatePicker {
        return UIDatePicker(frame: .zero)
            .date(self)
    }

    @discardableResult
    public func string(_ format: Format...) -> String {
        let formatter = DateFormatter()
        for value in format {
            switch value {
            case let .format(string):
                formatter.dateFormat = string
            case let .dateStyle(style):
                formatter.dateStyle = style
            case let .timeStyle(style):
                formatter.timeStyle = style
            }
        }

        return formatter.string(from: self)
    }
}
