//
//  URLExtension.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/4/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import Foundation

extension URL {
    func getFileName() -> String {
        let filenameWithExtension = self.lastPathComponent
        let fileExtention = self.pathExtension
        let fileName = filenameWithExtension.replacingOccurrences(of: fileExtention, with: "").trimmingCharacters(in: CharacterSet(charactersIn: "."))
        return fileName
    }
}
