//
//  EasyBundles.swift
//  Easy
//
//  Created by Eliran Sharabi on 13/04/2020.
//  Copyright © 2020 Shalom Shwaitzer & Eliran Sharabi. All rights reserved.
//

import Foundation

public extension JSONDecoder {
    func decode<T: Decodable>(type: T.Type, from json: String) throws -> T {
        guard let url = json.resourceURL(withExtension: "json") else {
            fatalError("no mock file")
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(type, from: data)
    }
}

public extension String {
    func decode<T: Decodable>(as type: T.Type) throws -> T {
        return try JSONDecoder().decode(type: type, from: self)
    }
    
    func resourceURL(withExtension: String) -> URL? {
        return Bundle.main.url(forResource: self, withExtension: withExtension)
    }
}
