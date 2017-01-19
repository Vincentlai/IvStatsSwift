//
//  System.swift
//  IvStats
//
//  Created by LaiQiang on 2016-12-30.
//  Copyright © 2016 LaiQiang. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

    // initialize colors
    public var primaryColor = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
    public var backgroundColor = UIColor(red: 254/255, green: 108/255, blue: 111/255, alpha: 1)
    //rgb(124, 120, 134)
    public var primaryTextColor = UIColor(red: 124/255, green: 120/255, blue: 134/255, alpha: 1)
    //rgb(189, 186, 193)
    public var secondaryTextColor = UIColor(red: 189/255, green: 186/255, blue: 193/255, alpha: 1)
    public var whiteTextColor = UIColor.white
    // rgb(63, 81, 181)
    public var googleColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1)
    
    // initialize font
    public var primaryFontFamily = "Helvetica"
    public var primaryFontSize: CGFloat = 18.0
    public var primaryFont = UIFont(name: primaryFontFamily, size: primaryFontSize)!

    public func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
