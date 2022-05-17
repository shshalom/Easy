//
//  EasySnapKit.swift
//  Easy
//
//  Created by Shalom on 19/04/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
#if canImport(SnapKit)
import SnapKit
extension UIView {

    @discardableResult
    public func make(_ maker: (ConstraintMaker) -> Void) -> Self {
        self.snp.makeConstraints(maker)
        return self
    }

    @discardableResult
    public func remake(_ maker: (ConstraintMaker) -> Void) -> Self {
        self.snp.remakeConstraints(maker)
        return self
    }

    @discardableResult
    public func update(_ maker: (ConstraintMaker) -> Void) -> Self {
        self.snp.updateConstraints(maker)
        return self
    }

    @discardableResult
    public func snapEdges(inset: CGFloat = 0.0) -> Self {
        self.make { make in
            make.edges.equalToSuperview().inset(inset)
        }
    }
}

extension ConstraintMaker {
    public func aspectRatio(_ x: Int, by y: Int, self instance: ConstraintView) {
        self.width.equalTo(instance.snp.height).multipliedBy(x / y)
    }
}

extension ConstraintMakerRelatable {
    @discardableResult
    public func equalToSafeArea(for other: ConstraintRelatableTarget) -> ConstraintMakerEditable {
        return equalTo((other as! UIView).safeAreaLayoutGuide)
    }
}
#endif
