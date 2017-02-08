//
//  SortViewCell.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-05.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit
@IBDesignable
class SortViewCell: UITableViewCell {

    @IBOutlet weak var sortName: UILabel!
    
    @IBOutlet weak var checkIcon: UIImageView!
    
    var sort: Sort? {
        didSet {
            self.updateUi()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateUi() {
        sortName.text = sort?.toString()
        checkIcon.image = checkIcon.image!.withRenderingMode(.alwaysTemplate)
        checkIcon.tintColor = primaryColor
        if sort!.enable {
            checkIcon.isHidden = false
        }else {
            checkIcon.isHidden = true
        }
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        checkIcon.isHidden = !checkIcon.isHidden
//    }
    
}
