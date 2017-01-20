//
//  HUD.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-19.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension MBProgressHUD {
    var HUDBackgroundColor: UIColor{
        return UIColor.init(white: 0, alpha: 0.5)
    }
    public func setHud(withtitle title: String, detailText: String?) {
        self.label.text = title
        self.bezelView.color = HUDBackgroundColor
        self.backgroundView.style = .solidColor
        if(detailText != nil){
            self.detailsLabel.text = detailText
        }
    }
}
    

    
