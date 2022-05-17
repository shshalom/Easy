//  Easy
//
//  Created by Shalom Shwaitzer on 29/07/2018.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import UIKit
import Foundation

extension UIImage {

    public var view: UIImageView {
        return UIImageView(image: self)
    }

    public var button: UIButton {
        return button(with: .system)
    }

    public var barButton: UIBarButtonItem {
        return UIBarButtonItem(image: self, style: .plain, target: nil, action: nil)
    }

    public var barCustomButton: UIBarButtonItem {
        let button = self.button(with: .custom)
        return UIBarButtonItem(customView: button)
    }

    public func tabBarButton(tag: Int = 0) -> UITabBarItem {
        return UITabBarItem(title: nil, image: self, tag: tag)
    }

    public func button(with type: UIButton.ButtonType) -> UIButton {
        let button = UIButton(type: type)
        button.frame = CGRect(origin: .zero, size: self.size)
        button.setImage(self, for: .normal)
        return button
    }

    public var template: UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }

    public func scale(toSize newSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(cgImage, in: newRect)
            if let img = context.makeImage() {
                newImage = UIImage(cgImage: img)
            }
            UIGraphicsEndImageContext()
        }
        return newImage
    }
}
