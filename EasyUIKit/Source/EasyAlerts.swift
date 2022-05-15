//
//  EasyAlers.swift
//  Easy
//
//  Created by Shalom Shwaitzer on 09/03/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    
    func alertError() {
        
        let action = UIAlertAction(title: "Close", style: .cancel)
        
        let alert = UIAlertController(title: "Error", message: self, preferredStyle: .alert)
        alert.addAction(action)
        
        DispatchQueue.main.async {
            UIApplication.shared.topViewController?.present(alert, animated: true)
        }
    }
    
    func alert() {
        
        let action = UIAlertAction(title: "Close", style: .cancel)
        
        let alert = UIAlertController(title: nil, message: self, preferredStyle: .alert)
        alert.addAction(action)
        
        DispatchQueue.main.async {
            UIApplication.shared.topViewController?.present(alert, animated: true)
        }
    }

}

public extension UIApplication {
    var topViewController: UIViewController? {
        if let topController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                return presentedViewController
            }
            return topController
        }
        return nil
    }
}
