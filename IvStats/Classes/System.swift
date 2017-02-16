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
    public var primaryColor = UIColor(red: 254/255, green: 108/255, blue: 111/255, alpha: 1)
    public var backgroundColor = UIColor(red: 254/255, green: 108/255, blue: 111/255, alpha: 1)
    //rgb(124, 120, 134)
    public var primaryTextColor = UIColor(red: 124/255, green: 120/255, blue: 134/255, alpha: 1)
    //rgb(189, 186, 193)
    public var secondaryTextColor = UIColor(red: 189/255, green: 186/255, blue: 193/255, alpha: 1)
    public var whiteTextColor = UIColor.white
    // rgb(63, 81, 181)
    public var googleColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1)
    public var lightBgColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)

    // forestgreen #228B22 rgb(34,139,34)
    public var highIvColor = Helper.createUIColorFromRGBA(withR: 34, g: 139, b: 34, a: 1)
    // orange #FFA500 rgb(255,165,0)
    public var mediumIvColor = UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1)
    // firebrick #B22222 rgb(178,34,34)
    public var lowIvColor = UIColor(red: 178/255, green: 34/255, blue: 34/255, alpha: 1)
    public var trashIvColor = UIColor.black
    // gold #FFD700 rgb(255,215,0)
    public var favoriteColor = UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1)

    // initialize font
    public var primaryFontFamily = "Helvetica"
    public var primaryFontSize: CGFloat = 18.0
    public var primaryFont = UIFont(name: primaryFontFamily, size: primaryFontSize)!
    public var secondaryLabelFontFamily = "Kailasa"
    public var secondaryLabelFontSize: CGFloat = 15.0

    //rgb(168, 168, 120)
    public var normalTypeColor = Helper.createUIColorFromRGBA(withR: 168, g: 168, b: 120, a: 1)
    //rgb(192, 32, 56)
    public var fightTypeColor = Helper.createUIColorFromRGBA(withR: 192, g: 32, b: 56, a: 1)
    //rgb(168, 144, 240)
    public var flyingTypeColor = Helper.createUIColorFromRGBA(withR: 168, g: 144, b: 240, a: 1)
    //rgb(160, 64, 160)
    public var poisonTypeColor = Helper.createUIColorFromRGBA(withR: 160, g: 64, b: 160, a: 1)
    //rgb(224, 192, 104)
    public var groundTypeColor = Helper.createUIColorFromRGBA(withR: 224, g: 192, b: 104, a: 1)
    //rgb(184, 160, 56)
    public var rockTypeColor = Helper.createUIColorFromRGBA(withR: 184, g: 160, b: 56, a: 1)
    //rgb(168, 184, 32)
    public var bugTypeColor = Helper.createUIColorFromRGBA(withR: 168, g: 184, b: 32, a: 1)
    //rgb(112, 88, 152)
    public var ghostTypeColor = Helper.createUIColorFromRGBA(withR: 112, g: 88, b: 152, a: 1)
    //rgb(184, 184, 208)
    public var steelTypeColor = Helper.createUIColorFromRGBA(withR: 184, g: 184, b: 208, a: 1)
    //rgb(240, 128, 48)
    public var fireTypeColor = Helper.createUIColorFromRGBA(withR: 240, g: 128, b: 48, a: 1)
    //rgb(104, 144, 240)
    public var waterTypeColor = Helper.createUIColorFromRGBA(withR: 104, g: 144, b: 240, a: 1)
    //rgb(120, 200, 80)
    public var grassTypeColor = Helper.createUIColorFromRGBA(withR: 120, g: 200, b: 80, a: 1)
    //rgb(248, 208, 48)
    public var electricTypeColor = Helper.createUIColorFromRGBA(withR: 248, g: 208, b: 48, a: 1)
    //rgb(248, 88, 136)
    public var psychicTypeColor = Helper.createUIColorFromRGBA(withR: 248, g: 88, b: 136, a: 1)
    //rgb(152, 216, 216)
    public var iceTypeColor = Helper.createUIColorFromRGBA(withR: 152, g: 216, b: 216, a: 1)
    //rgb(112, 56, 248)
    public var dragonTypeColor = Helper.createUIColorFromRGBA(withR: 112, g: 56, b: 248, a: 1)
    //rgb(112, 88, 72)
    public var darkTypeColor = Helper.createUIColorFromRGBA(withR: 112, g: 88, b: 72, a: 1)
    //rgb(238, 153, 172)
    public var fairyTypeColor = Helper.createUIColorFromRGBA(withR: 238, g: 153, b: 172, a: 1)











