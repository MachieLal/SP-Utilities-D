//
//  StringExtension.swift
//  SP Utilities
//
//  Created by Swarup-Pattnaik on 5/4/19.
//  Copyright © 2019 Swarup-Pattnaik. All rights reserved.
//

import Foundation
import CryptoSwift
import CommonCrypto

extension String {
    var utf8Encoded: Data {
        return data(using: .utf8) ?? Data()
    }
    
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
    
    func localized(withValue value: String = "") -> String {
        return String.localize(self, withValue: value)
    }
    
    public static func localize(_ key: String, withValue value: String = "") -> String {
        return String.localizedStringWithFormat(NSLocalizedString(key, comment: ""), value)
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func isValidEmail() -> Bool {
        if self.isEmpty { return true } // to avoid validation check
        
        let regExPattern = "^[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}" // should match the pattern
        if let regex = try? NSRegularExpression(pattern: regExPattern) {
            let results = regex.matches(in: self, range: NSRange(location: 0, length: count))
            return !results.isEmpty
        }
        return  false
    }
    
    func parseIsoDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.date(from: self)
    }
    
    func parseSimpleDateTime() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.date(from: self)
    }
    
    func parseSimpleDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }

    func asShortDateTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        if let date = self.parseIsoDate() {
            return dateFormatter.string(from: date)
        }
        if let date = self.parseSimpleDateTime() {
            return dateFormatter.string(from: date)
        }
        return self
    }
    
    func asCommonDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        if let date = self.parseIsoDate() {
            return dateFormatter.string(from: date)
        }
        if let date = self.parseSimpleDateTime() {
            return dateFormatter.string(from: date)
        }
        return self
    }

    func asCommonDateTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        if let date = self.parseIsoDate() {
            return dateFormatter.string(from: date)
        }
        if let date = self.parseSimpleDateTime() {
            return dateFormatter.string(from: date)
        }
        return self
    }

    func asShortDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        if let date = self.parseIsoDate() {
            return dateFormatter.string(from: date)
        }
        if let date = self.parseSimpleDateTime() {
            return dateFormatter.string(from: date)
        }
        return self
    }
    
    func aesEncryption(with key: String) -> String {
        var text = ""
        do {
            let rawData = self.data(using: .utf8)
            
            let keyHash = key.data(using: .utf8)?.sha256()
            let hashBytes = keyHash!.bytes
            
            let iv: [UInt8] = AES.randomIV(AES.blockSize)
            let blockMode = CBC(iv: iv)

            let cipher = try AES(key: hashBytes, blockMode: blockMode, padding: .pkcs7)
            let rawBytes = rawData!.bytes
            let encrypted = try cipher.encrypt(rawBytes)

            text = (iv + encrypted).toBase64() ?? ""

            print("Email key String = \(key)")
            print("Password String = \(self)")
            print("Encrypted String = \(text)")
        } catch (let error) {
            print("Encrypt Error - \(error.localizedDescription)")
        }
        return text
    }
    
    func aesDecryption(with key: String) -> String {
        var text = ""
        do {
            let enc = Array(base64: self)
            
            if enc.isEmpty { return "" }
            
            let encCount = enc.count
            
            let iv: [UInt8] = Array(enc[0..<AES.blockSize])
            
            let keyUTF8 = key.data(using: .utf8)
            let keyHash = keyUTF8?.sha256()
            let hashBytes = keyHash!.bytes

            let blockMode = CBC(iv: iv)
            
            let cipher = try AES(key: hashBytes, blockMode: blockMode, padding: .pkcs5)
            
            let encBytes: [UInt8] = Array(enc[AES.blockSize..<encCount])
            
            let decrypted = try cipher.decrypt(encBytes)
            
            text = String(data: Data(decrypted), encoding: .utf8) ?? ""
            
            print("Email key String = \(key)")
            print("Encrypted Password String = \(self)")
            print("Decrypted String = \(text)")
        } catch (let error) {
            print("Decrypt Error - \(error.localizedDescription)")
        }
        return text
    }
}
