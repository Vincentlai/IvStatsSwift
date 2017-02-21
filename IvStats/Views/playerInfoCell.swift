//
//  playerInfoCell.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-20.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit

class playerInfoCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemValue: UILabel!

    public func updateUi(withItemLabel label: String, value: String, itemIconName: String)
    {
        itemLabel.text = label
        itemValue.text = value
        if let image = UIImage.init(named: itemIconName)
        {
            icon.image = image
        }
    }
}
