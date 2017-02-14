//
//  Helper.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-20.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation
import PGoApi
import UIKit
class Helper{
    
    class func createUIColorFromRGBA(withR r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor
    {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    class func dateConverter(withTimestamp timestamp: Int64) -> String{
        let dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeInterval:TimeInterval = TimeInterval(timestamp/1000)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dformatter = DateFormatter()
        dformatter.dateFormat = dateFormat
        return dformatter.string(from: date)
    }
    
    class func getPokemonCellWidth() -> Int {
        let screenWidth = UIScreen.main.bounds.width
        let defaultPokemonCellWidth = 110
        let inset = 5
        let pokemonCellNumber = 3
        let minItemSpace = 5
        let totalCellWidth = defaultPokemonCellWidth * pokemonCellNumber
        let actualWidth = totalCellWidth + minItemSpace * (pokemonCellNumber - 1) + inset * 2
        if CGFloat(actualWidth) > screenWidth {
            return 100
        }else {
            return defaultPokemonCellWidth
        }    
    }
}
