//
//  EasyURL.swift
//  Easy
//
//  Created by Eliran Sharabi on 14/05/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation
import UIKit

enum ExternalLink {
    case whatsapp(text: String)
    
    var url: URL? {
        switch self {
        case .whatsapp(let text):
            return "whatsapp://send?text=\(text.percentEncode(allowedCharacters: .urlHostAllowed))".url
        }
    }
}

public extension String {
    func percentEncode(allowedCharacters: CharacterSet) -> String {
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? ""
    }
}

public extension URL {
    func open() {
        if UIApplication.shared.canOpenURL(self) {
            UIApplication.shared.open(self, options: [:], completionHandler: nil)
        }
    }
}
