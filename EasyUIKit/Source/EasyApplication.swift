//  Easy
//
//  Created by Eliran Sharabi on 06/01/2021.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import UIKit

extension UIApplication {
    public var topViewController: UIViewController? {
        let keyWindow = UIApplication.shared.windows.first(where: \.isKeyWindow)

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            return topController
        }

        return nil
    }
}
