//
//  Button.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-07.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit
@IBDesignable
class Button: UIButton {

    @IBInspectable
    open var cornerRadius: CGFloat{
        get {
             return self.layer.cornerRadius
        }
        set(value) {
            self.layer.cornerRadius = value
        }
    }
    
    @IBInspectable
    open override var currentTitle: String? {
        get {
            return self.currentTitle
        }
        set(value) {
            self.currentTitle = value
        }
    }
    
    @IBInspectable
    open override var backgroundColor: UIColor?
        {
        didSet {
            layer.backgroundColor = backgroundColor?.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 4.0
        self.titleLabel?.font = primaryFont
    }
    
    

}
