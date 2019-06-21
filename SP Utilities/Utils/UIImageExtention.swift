//
//  UIImageExtention.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/4/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import Foundation
import UIKit
import Photos

extension UIImage {
    
    func addImagePadding(x xValue: CGFloat, y yValue: CGFloat) -> UIImage? {
        let width: CGFloat = size.width + xValue
        let height: CGFloat = size.height + yValue
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        let origin: CGPoint = CGPoint(x: (width - size.width) / 2, y: (height - size.height) / 2)
        draw(at: origin)
        let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithPadding
    }
    
    func customResized(to value: CGFloat = 0.35) -> UIImage? {
        // only accept fractions between 0 to 1
        if value <= 0 || value >= 1 { return self }
        
        let originOffset = (1 - value) * 0.5
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width, height: size.height), false, 0)
        draw(in: CGRect(x: size.width * originOffset,
                             y: size.height * originOffset,
                             width: size.width * value,
                             height: size.height * value))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    func saveImageToLibrary(completionHandler onComplete: @escaping ((_ responseURL : URL?) -> Void)) {
        var placeholder: PHObjectPlaceholder?
        PHPhotoLibrary.shared().performChanges({
            placeholder = PHAssetChangeRequest.creationRequestForAsset(from: self).placeholderForCreatedAsset
        }, completionHandler: { success, error in
            if success {
                if let placeholderObject = placeholder {
                    let result = PHAsset.fetchAssets(withLocalIdentifiers: [placeholderObject.localIdentifier], options: nil)
                    if let asset = result.firstObject {
                        asset.getURL(ofPhotoWith: asset, completionHandler: { url in
                            onComplete(url)
                        })
                    }
                }
            } else {
                onComplete(nil)
            }
            if let errorObject = error {
                print("DEBUG:::\(errorObject.localizedDescription)")
            }
        }) 
    }
}
