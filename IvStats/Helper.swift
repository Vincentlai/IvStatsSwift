//
//  Helper.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-20.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation
import PGoApi
class Helper{
    
    class func dateConverter(withTimestamp timestamp: Int64) -> String{
        let dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeInterval:TimeInterval = TimeInterval(timestamp/1000)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dformatter = DateFormatter()
        dformatter.dateFormat = dateFormat
        return dformatter.string(from: date)
    }
}
