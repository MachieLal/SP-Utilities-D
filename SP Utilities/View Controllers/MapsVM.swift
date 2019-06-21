//
//  MapsVM.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/17/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MapKit

class MapsVM {
    let locationmanager = CLLocationManager()
    
    func requestLocationAuthorization() {
        locationmanager.requestLocation()
    }
}
