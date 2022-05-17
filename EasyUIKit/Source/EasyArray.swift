//  Easy
//
//  Created by Shalom Shwaitzer on 18/08/2019.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {

    public func subtracting(_ array: [Element]) -> [Element] {
        let a = Set(self)
        let b = Set(array)
        return Array(a.subtracting(b))
    }

    public func intersection(_ array: [Element]) -> [Element] {
        let a = Set(self)
        let b = Set(array)
        return Array(a.intersection(b))
    }

    public func union(_ array: [Element]) -> [Element] {
        let a = Set(self)
        let b = Set(array)
        return Array(a.union(b))
    }

    public func isDisjoint(_ array: [Element]) -> Bool {
        let a = Set(self)
        let b = Set(array)
        return a.isDisjoint(with: b)
    }
}
