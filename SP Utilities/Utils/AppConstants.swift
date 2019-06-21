//
//  AppConstants.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/5/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import Foundation
import UIKit

enum AppConstant {
    // String Identifier constants
    static let success = "success"
    static let showMainTabBarVC = "showMTBVC"
    
    // Localized String constants
    static let unknownError = NSLocalizedString("unknown_error", comment: "Unknown Error")
    static let internalError = NSLocalizedString("internal_error", comment: "Internal Error")
    static let loginTitle = NSLocalizedString("login_title", comment: "Login")
    static let hamburgerTitle = NSLocalizedString("Menu", comment: "")
    static let alarmsTitle = NSLocalizedString("Alarms", comment: "")
    static let mapsTitle = NSLocalizedString("Map", comment: "")
    
    // UI constants
    static let textFieldAccessoryButtonDimension = CGRect(x:-10, y:0, width:35, height:22)
    static let loadingIndicatorDimension = CGRect(x: 0, y: 0, width: 150, height:150)
    
    // Numbers

}
