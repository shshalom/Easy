//
//  EasyTable.swift
//  Easy
//
//  Created by Eliran Sharabi on 26/11/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import UIKit

public extension UICollectionView {
    @discardableResult
    func register(cells: UICollectionViewCell.Type...) -> Self {
        self.register(cells: cells)
        return self
    }
    
    @discardableResult
    func register(cells: [UICollectionViewCell.Type])  -> Self {
        for cell in cells {
            self.register(cell: cell)
        }
        return self
    }
    
    @discardableResult
    func register(cell: UICollectionViewCell.Type)  -> Self {
        self.register(cell, forCellWithReuseIdentifier: cell.identifier)
        return self
    }
    
    func reuse<T: UICollectionViewCell>(cell: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as! T
    }
    
    func scrollToLastRow(inSection section: Int = 0, animated: Bool = true) {
        let numberOfRows = self.numberOfItems(inSection: section)
        if  numberOfRows > 0 {
            self.scrollToItem(at: IndexPath(row: numberOfRows - 1, section: section), at: .bottom, animated: animated)
        }
    }
}

public extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
