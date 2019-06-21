//
//  MainTabBarVM.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/4/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import Foundation
import RxSwift

class MainTabBarVM {
    func getTitleForSelectedIndex(_ index: Int) -> String {
        switch index {
        case TabBarScreenIndex.alarms.rawValue:
            return AppConstant.alarmsTitle
        case TabBarScreenIndex.maps.rawValue:
            return AppConstant.mapsTitle
        default: return ""
        }
    }
}
