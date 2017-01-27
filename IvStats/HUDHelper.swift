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

class HUDHelper{
    
    private var hudBackgroundColor = UIColor.init(white: 0.7, alpha: 0.5)
    
    class func createHud(withView parentView : UIView, title: String?, detailText: String?, delegate : MBProgressHUDDelegate) -> MBProgressHUD{
        // Clear & remove any previous HUD
        for view in parentView.subviews {
            if let previousHUD = view as? MBProgressHUD {
                previousHUD.removeFromSuperview()
                break
            }
        }
        
        // Init HUD
        let HUD = MBProgressHUD.init(view: parentView)
        
        // Add HUD into view
        parentView.addSubview(HUD)
        
        if title != nil && title != ""
        {
            HUD.label.text = title!
        }
        
        if detailText != nil && title != ""
        {
            HUD.detailsLabel.text = detailText!
        }


        return HUD
    }
}


    
