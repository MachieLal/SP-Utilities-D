//
//  AlarmsVM.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/17/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import Foundation

class AlarmsVM {
    var alarms: [String] = [] {
        willSet {
            alarmsObserver?(newValue)
        }
    }
    
    var alarmsObserver: (([String]) -> Void)?
    
    func populateData() {
        if let filePath = Bundle.main.path(forResource: "PropertyList", ofType: "plist", inDirectory: nil),
            let data = FileManager.default.contents(atPath: filePath),
            let value = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String: [String]],
            let list = value["alarms"] {
            print("list---\(String(describing: value))")
            
            alarms.append(contentsOf: list)
        }
    }
}
