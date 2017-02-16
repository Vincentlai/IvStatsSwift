//
//  NSErrorExtension.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-29.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation
import PGoApi

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


class ExceptionHelper {
    class func toString(withException exception: PGoApiExceptions) -> String
    {
        switch exception {
        case .noApiMethodsCalled : return NSLocalizedString(
            "No Api Methods Called",
            comment: "Failed to resolve inventory data")
        case .banned: return NSLocalizedString(
            "The account has been banned",
            comment: "Failed to resolve inventory data")
        case .notLoggedIn: return NSLocalizedString(
            "No user is logged in",
            comment: "Failed to resolve inventory data")
        case .authTokenExpired: return NSLocalizedString(
            "Auth Token is expired",
            comment: "Failed to resolve inventory data")
        case .noAuth: return NSLocalizedString(
            "No auth found",
            comment: "Failed to resolve inventory data")
        case .delayRequired: return NSLocalizedString(
            "Delay Required",
            comment: "Failed to resolve inventory data")
        case .invalidRequest: return NSLocalizedString(
            "Invalid Request",
            comment: "Failed to resolve inventory data")
        case .sessionInvalidated: return NSLocalizedString(
            "Session Invalidated",
            comment: "Failed to resolve inventory data")
        case .unknown: return NSLocalizedString(
            "Unknown Error",
            comment: "Failed to resolve inventory data")
        case .captchaRequired: return NSLocalizedString(
            "Captcha Required",
            comment: "Failed to resolve inventory data")
        }
    }
    class func getCode(withException exception: PGoApiExceptions) -> Int
    {
        switch exception {
        case .noApiMethodsCalled : return 1005
        case .banned: return 1006
        case .notLoggedIn: return 1007
        case .authTokenExpired: return 1008
        case .noAuth: return 1009
        case .delayRequired: return 1010
        case .invalidRequest: return 1011
        case .sessionInvalidated: return 1012
        case .unknown: return 1013
        case .captchaRequired: return 1014
        }
    }
}

struct IvStatsException {
    var Exception: PGoApiExceptions
    public func nserror() -> NSError {
        let code = ExceptionHelper.getCode(withException: Exception)
        let description = ExceptionHelper.toString(withException: Exception)
        return NSError(code: code, description: description)
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
