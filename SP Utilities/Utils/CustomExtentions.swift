//
//  CustomExtentions.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/4/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import Foundation
import UIKit
import Photos

public var printerDateFormater : DateFormatter?

//public func print(_ items: Any...) {
//    let date = Date();
//    
//    if printerDateFormater == nil{
//        printerDateFormater = DateFormatter();
//        printerDateFormater!.setLocalizedDateFormatFromTemplate("dd-MM-yyyy HH:mm:ss.SSS");
//    }
//    
//    var thread = Thread.current.isMainThread ? "main" : "not-main"
//    if let name = Thread.current.name, !name.isEmpty {
//        thread = name
//    }
//    
//    let output = items.map { "\(printerDateFormater!.string(from: date)): \(thread): \($0)" }
//    print(output)
//}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}

extension Data {
    func utf8String() -> String? {
        return String(data: self, encoding: .utf8)
    }
}

extension UIButton {
      
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

extension UITableView {
    public func deselectAllRows() {
        self.indexPathsForSelectedRows?.forEach { [unowned self] indexPath in
            self.cellForRow(at: indexPath)?.accessoryType = .none
            self.deselectRow(at: indexPath, animated: false)
        }
    }
}
extension PHAsset {
    func getURL(ofPhotoWith mPhasset: PHAsset, completionHandler : @escaping ((_ responseURL : URL?) -> Void)) {

        if mPhasset.mediaType == .image {
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return true
            }
            mPhasset.requestContentEditingInput(with: options, completionHandler: { (contentEditingInput, _) in
                completionHandler(contentEditingInput!.fullSizeImageURL)
            })
        } else if mPhasset.mediaType == .video {
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            PHImageManager.default().requestAVAsset(forVideo: mPhasset, options: options, resultHandler: { (asset, _, _) in
                if let urlAsset = asset as? AVURLAsset {
                    let localVideoUrl = urlAsset.url
                    completionHandler(localVideoUrl)
                } else {
                    completionHandler(nil)
                }
            })
        }

    }
}
