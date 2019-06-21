//
//  AlarmDetailsVM.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 6/1/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import UIKit

class AlarmDetailsVM {
    var title = "" {
        willSet {
            titleObserver?(newValue)
        }
    }
    var titleObserver: ((String) -> Void)?
    
    var alarmDetails: Alarm? {
        didSet {
            alarmDetailsObserver?(alarmDetails)
        }
    }
    var alarmDetailsObserver: ((Alarm?) -> Void)?
    
    var locations: [String] {
        if let filePath = Bundle.main.path(forResource: "PropertyList", ofType: "plist", inDirectory: nil),
            let data = FileHandle(forReadingAtPath: filePath)?.readDataToEndOfFile(),
            let value = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String: [String]],
            let list = value["locations"] {
            return list
        }
        return []
    }

}
