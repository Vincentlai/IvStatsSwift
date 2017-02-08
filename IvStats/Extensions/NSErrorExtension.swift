//
//  NSErrorExtension.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-29.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation


extension NSError {
    
    convenience init(code: Int, description: String) {
        self.init(domain: "ivstat.com", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    convenience init(domain: String, code: Int, description: String) {
        self.init(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
}


typealias ErrorCode = Int

extension ErrorCode {
    
    func nserror() -> NSError {
        return Error.error(withCode: self)
    }
}

struct Error {
    
    static let Domain = "ivstats.com"
    
    struct Code {
        
        static let Common = 0
        
        static let Login         = 1000
        static let Authorization = 1001
        static let Connection    = 1002
        static let ResovePlayerData = 1003
        static let ResoceInventoryData = 1004
    }
    
    static func error(withCode code: Int) -> NSError {
        
        return NSError(code: code, description: Error.message(withCode: code))
    }
    
    
    static func message(withCode code: Int) -> String {
        
        var message = ""
        
        switch code {
            
        case Error.Code.Login:
            message = NSLocalizedString(
                "Login failed. Please make sure you have entered the correct Authorization Token or (Username and Password).",
                comment: "Login failed")
            
        case Error.Code.Authorization:
            message = NSLocalizedString(
                "Authorization failed. Please login again.",
                comment: "Authorization failed")
            
        case Error.Code.Connection:
            message = NSLocalizedString(
                "Connection failed. Please try again later.",
                comment: "Connection failed")
            
        case Error.Code.ResovePlayerData:
            message = NSLocalizedString(
                "Failed to resolve player data. Please try again later.",
                comment: "Failed to resolve player data")
            
        case Error.Code.ResoceInventoryData:
            message = NSLocalizedString(
                "Failed to resolve inventory data. Please try again later.",
                comment: "Failed to resolve inventory data")
            
        default:
            message = NSLocalizedString(
                "Unknown error. Please login again to solve this problem.",
                comment: "Common error")
        }
        
        return message// + " (\(code))"
    }
}