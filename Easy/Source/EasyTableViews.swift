//
//  EasyTableViews.swift
//  Easy
//
//  Created by Shalom on 17/03/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import UIKit

public extension UITableView {
    
    @discardableResult
    func register(headers: UITableViewHeaderFooterView.Type...) -> Self {
        self.register(headers: headers )
        return self
    }
    
    @discardableResult
    func register(headers: [UITableViewHeaderFooterView.Type]) -> Self {
        for header in headers {
            self.register(header: header)
        }
        return self
    }
    
    @discardableResult
    func register(header: UITableViewHeaderFooterView.Type) -> Self {
        self.register(header, forHeaderFooterViewReuseIdentifier: header.identifier)
        return self
    }
    
    @discardableResult
    func register(cells: UITableViewCell.Type...) -> Self {
        self.register(cells: cells)
        return self
    }
    
    @discardableResult
    func register(cells: [UITableViewCell.Type]) -> Self {
        for cell in cells {
            self.register(cell: cell)
        }
        return self
    }
    
    @discardableResult
    func register(cell: UITableViewCell.Type) -> Self {
        self.register(cell, forCellReuseIdentifier: cell.identifier)
        return self
    }
    
    @discardableResult
    func reuse<T: UITableViewCell>(cell: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: cell.identifier) as! T
    }
    
    @discardableResult
    func reuse<T: UITableViewHeaderFooterView>(header view: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: view.identifier) as! T
    }
    
    @discardableResult
    func rowHeight(estimated value: CGFloat, automatic: Bool) -> Self {
        self.estimatedRowHeight = value
        self.rowHeight = automatic ? UITableView.automaticDimension : value
        return self
    }
    
    @discardableResult
    func sectionHeader(height: CGFloat) -> Self {
        self.sectionHeaderHeight = height
        return self
    }
    
    @discardableResult
    func separator(style: UITableViewCell.SeparatorStyle) -> Self {
        self.separatorStyle = style
        return self
    }
    
    @discardableResult
    func separator(inset: UIEdgeInsets) -> Self {
        self.separatorInset = inset
        return self
    }
    
    @discardableResult
    func separator(color: UIColor) -> Self {
        self.separatorColor = color
        return self
    }
    
    func hideFooterView() -> Self {
        self.tableFooterView = UIView()
        return self
    }

    func scrollToLastRow(inSection section: Int = 0, animated: Bool = true) {
        let numberOfRows = self.numberOfRows(inSection: section)
        if  numberOfRows > 0 {
            self.scrollToRow(at: IndexPath(row: numberOfRows - 1, section: section), at: .bottom, animated: animated)
        }
    }
}

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

public extension UITableViewHeaderFooterView {
    static var identifier: String {
        return String(describing: self)
    }
}

public extension Int {
    var indexSet: IndexSet {
        return .init(arrayLiteral: self)
    }
}

public extension IndexPath {
    var cacheKey: String {
        return String(describing: self)
    }
}
