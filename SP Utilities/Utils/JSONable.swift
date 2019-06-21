//
//  JSONable.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/4/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import Foundation

protocol JSONable {
    func jsonMap() -> String
    static func getObject(fromJSON json: Data) -> Self?
    static func getListObjects(fromJSON json: Data) -> [Self]?
}

extension JSONable where Self: Codable {
    // Encode
    func jsonMap() -> String {
        guard let jsonData = try? JSONEncoder().encode(self),
            let jsonString = jsonData.utf8String()
            else { return "" }
        return jsonString
    }
    
    // Decode
    static func getObject(fromJSON json: Data) -> Self? {
        return try? JSONDecoder().decode(Self.self, from: json)
    }
    
    // Decode Array of objects
    static func getListObjects(fromJSON json: Data) -> [Self]? {
        var objects: [Self]?
        if let list = (try? JSONSerialization.jsonObject(with: json,
                                                         options: .allowFragments)) as? [Any],
            !list.isEmpty {
            objects = [Self]()
            for item in list {
                if let prettyData = try? JSONSerialization.data(withJSONObject: item, options: .prettyPrinted),
                    let dao = Self.getObject(fromJSON: prettyData) {
                    objects?.append(dao)
                }
            }
        }
        return objects
    }
    
    // Decode Dictionary of objects
    static func getDictionaryObjects(fromJSON json: Data) -> [String: Self]? {
        var objects: [String: Self]?
        if let list = (try? JSONSerialization.jsonObject(with: json,
                                                         options: .allowFragments)) as? [String: Any],
            !list.isEmpty {
            objects = [String: Self]()
            for (key,item) in list {
                if let prettyData = try? JSONSerialization.data(withJSONObject: item, options: .prettyPrinted),
                    let dao = Self.getObject(fromJSON: prettyData) {
                    objects?.updateValue(dao, forKey: key)
                }
            }
        }
        return objects
    }
    
    static func getDictionaryObjects(fromObject json: Any?) -> [String: Self]? {
        var objects: [String: Self]?
        if let list = json as? [String: Any],
            !list.isEmpty {
            objects = [String: Self]()
            for (key,item) in list {
                if let prettyData = try? JSONSerialization.data(withJSONObject: item, options: .prettyPrinted),
                    let dao = Self.getObject(fromJSON: prettyData) {
                    objects?.updateValue(dao, forKey: key)
                }
            }
        }
        return objects
    }
}
