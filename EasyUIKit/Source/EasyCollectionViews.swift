//
//  EasyTable.swift
//  Created by Shalom Shwaitzer

import UIKit

extension UICollectionView {
    @discardableResult
    public func register(cells: UICollectionViewCell.Type...) -> Self {
        self.register(cells: cells)
        return self
    }

    @discardableResult
    public func register(cells: [UICollectionViewCell.Type]) -> Self {
        for cell in cells {
            self.register(cell: cell)
        }
        return self
    }

    @discardableResult
    public func register(cell: UICollectionViewCell.Type) -> Self {
        self.register(cell, forCellWithReuseIdentifier: cell.cellIdentifier)
        return self
    }

    public func reuse<T: UICollectionViewCell>(cell: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cell.cellIdentifier, for: indexPath) as! T
    }

    public func scrollToLastRow(inSection section: Int = 0, animated: Bool = true) {
        let numberOfRows = self.numberOfItems(inSection: section)
        if  numberOfRows > 0 {
            self.scrollToItem(at: IndexPath(row: numberOfRows - 1, section: section), at: .bottom, animated: animated)
        }
    }

    public func content(insets: UIEdgeInsets) -> Self {
        self.contentInset = insets
        return self
    }
}

extension UICollectionViewCell {
    public static var cellIdentifier: String {
        return String(describing: self)
    }
}
