//
//  Alarm.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 6/7/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import UIKit
import MapKit

final class Alarm: JSONable, Codable {    
    private let name: String
    private let date: Date
    private let location: String

    init(name: String, date: Date, location: String) {
        self.name = name
        self.date = date
        self.location = location
    }
    
}
