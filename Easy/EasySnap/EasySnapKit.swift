//
//  EasySnapKit.swift
//  Easy
//
//  Created by Shalom on 19/04/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import SnapKit

public extension UIView {
    
    @discardableResult
    func make(_ maker: (ConstraintMaker) -> Void) -> Self {
        self.snp.makeConstraints(maker)
        return self
    }
    
    @discardableResult
    func remake(_ maker: (ConstraintMaker) -> Void) -> Self {
        self.snp.remakeConstraints(maker)
        return self
    }
    
    @discardableResult
    func update(_ maker: (ConstraintMaker) -> Void) -> Self {
        self.snp.updateConstraints(maker)
        return self
    }
    
    @discardableResult
    func snapEdges(inset: CGFloat = 0.0) -> Self {
        self.make { make in
            make.edges.equalToSuperview().inset(inset)
        }
    }
}

public extension ConstraintMakerRelatable {
    @discardableResult
    func equalToSafeAreaOrTo(_ other: ConstraintRelatableTarget) -> ConstraintMakerEditable {
        if #available(iOS 11, *) {
            return equalTo((other as! UIView).safeAreaLayoutGuide)
        } else {
            return equalTo(other as! UIView)
        }
    }
}
