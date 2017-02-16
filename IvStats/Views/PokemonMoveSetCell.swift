//
//  PokemonMoveSetCell.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-13.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit
import Cartography
class PokemonMoveSetCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var moveLabel: UILabel!
    
    @IBOutlet weak var dpsLabel: UILabel!
    
//    @IBOutlet weak var attackIcon: UIImageView!
//    @IBOutlet weak var defenseIcon: UIImageView!
    var attackIcon: UIImageView?
    var defenseIcon: UIImageView?
    
    var move: PokemonMove?
    {
        didSet{
            self.updateUI()
        }
    }
    
    private func updateUI()
    {
        let bgColor: UIColor = PokemonMoveHelper.getMoveTypeColor(forMove: move!)
        typeLabel.backgroundColor = bgColor
        let type = PokemonMoveHelper.getMoveType(forMove: self.move!)
        typeLabel.text = PokemonHelper.getTypeDisplayName(forType: type)
        moveLabel.text = PokemonMoveHelper.getMoveDisplayName(forMove: self.move!)
        let dpsText = NSMutableAttributedString.init(string: "DPS " + PokemonMoveHelper.getMoveDPS(forMove: self.move!).description)
        let range = NSRange.init(location: 0, length: 3)
        dpsText.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGray, range: range)
        if let font = UIFont.init(name: secondaryLabelFontFamily, size: secondaryLabelFontSize)
        {
            dpsText.addAttribute(NSFontAttributeName, value: font, range: range)
        }
        dpsText.addAttribute(NSForegroundColorAttributeName, value: primaryTextColor, range: NSRange.init(location: 4, length: dpsText.length-4))
        dpsLabel.attributedText = dpsText
    }
    
    public func addIcon(isBestAttack: Bool, isBestDefense: Bool)
    {
        if isBestAttack && isBestDefense
        {
            let attackIcon = UIImageView()
            self.contentView.addSubview(attackIcon)
            let defenseIcon = UIImageView()
            self.contentView.addSubview(defenseIcon)
            constrain(attackIcon, defenseIcon){
                (topView, buttomView) in
                topView.top == topView.superview!.top + 2.33
                topView.bottom == buttomView.top - 5
                topView.width == 20
                topView.height == 20
                topView.leading == topView.superview!.leading + 20
            }
            attackIcon.image = #imageLiteral(resourceName: "attack")
            constrain(defenseIcon){
                (view) in
                view.bottom == view.superview!.bottom - 2.67
                view.width == 20
                view.height == 20
                view.leading == view.superview!.leading + 20
            }
            defenseIcon.image = #imageLiteral(resourceName: "defense")
        }
        else if isBestAttack || isBestDefense
        {
            let view = UIImageView()
            self.contentView.addSubview(view)
            constrain(view){
                (view) in
                view.top == view.superview!.top + 15
                view.bottom == view.superview!.bottom - 15
                view.width == 20
                view.height == 20
                view.leading == view.superview!.leading + 20
            }
            if isBestAttack
            {
                view.image = #imageLiteral(resourceName: "attack")
            }else {
                view.image = #imageLiteral(resourceName: "defense")
            }
            
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
