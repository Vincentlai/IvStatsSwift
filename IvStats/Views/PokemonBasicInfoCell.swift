//
//  PokemonBasicInfoCell.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-13.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit

class PokemonBasicInfoCell: UITableViewCell {

    @IBOutlet weak var cpValue: UILabel!
    @IBOutlet weak var levelValue: UILabel!
    @IBOutlet weak var ivValue: UILabel!
    @IBOutlet weak var hpValue: UILabel!
    @IBOutlet weak var attackValue: UILabel!
    @IBOutlet weak var defenseValue: UILabel!
    @IBOutlet weak var staminaValue: UILabel!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var favoriteIcon: UIImageView!
    
    @IBOutlet weak var type1: UILabel!
    @IBOutlet weak var type2: UILabel!
    @IBOutlet weak var bestMoveIcon1: UIImageView!
    @IBOutlet weak var bestMoveIcon2: UIImageView!
    @IBOutlet weak var candyValue: UILabel!
    @IBOutlet weak var maxCpValue: UILabel!
    @IBOutlet weak var captureDataValue: UILabel!
     
    var pokemon: Pokemon? {
        didSet
        {
            self.updatePokemon()
        }
    }
    var pokemonPrototype: PokemonPrototype? {
        didSet
        {
            self.updatePokemonType()
        }
    }
    
    private func updatePokemon()
    {

        // set favorite icon
        self.setFavorite(icon: favoriteIcon)
        // set cp
        let cpText = NSMutableAttributedString.init(string: "CP " + (pokemon?.cp.description)!)
        let range = NSRange.init(location: 0, length: 2)
        cpText.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGray, range: range)
        if let font = UIFont.init(name: secondaryLabelFontFamily, size: secondaryLabelFontSize)
        {
            cpText.addAttribute(NSFontAttributeName, value: font, range: range)
        }
        cpText.addAttribute(NSForegroundColorAttributeName, value: primaryTextColor, range: NSRange.init(location: 3, length: cpText.length-4))
        cpValue.attributedText = cpText
        // set image
        if let image = UIImage(named: (pokemon?.getImageName())!)
        {
            pokemonImage.image = image
        }
        // set iv
        ivValue.text = pokemon?.getIvText()
        ivValue.textColor = PokemonHelper.getPokemonIvTextColor(withIv: (pokemon?.getIv())!)
        // set hp
        hpValue.text = pokemon?.stamina.description
        // set level
        levelValue.text = pokemon?.getLevel().description
        // set attack defense stamina
        attackValue.text = pokemon?.individualAttack.description
        defenseValue.text = pokemon?.individualDefense.description
        staminaValue.text = pokemon?.individualStamina.description
    }
    
    public func setBestMoveIcons(isBestAttackMoveSet: Bool, isBestDefenseMoveSet: Bool)
    {
        if isBestAttackMoveSet && isBestDefenseMoveSet{
            bestMoveIcon1.image = #imageLiteral(resourceName: "attack")
            bestMoveIcon2.image = #imageLiteral(resourceName: "defense")
            bestMoveIcon1.isHidden = false
            bestMoveIcon2.isHidden = false
        } else if isBestAttackMoveSet {
            bestMoveIcon1.image = #imageLiteral(resourceName: "attack")
            bestMoveIcon1.isHidden = false
            bestMoveIcon2.isHidden = true
        } else if isBestDefenseMoveSet {
            bestMoveIcon1.image = #imageLiteral(resourceName: "defense")
            bestMoveIcon1.isHidden = false
            bestMoveIcon2.isHidden = true
        }
    }
    
    public func setPokemonCandy(withCandy candy: Int32)
    {
        candyValue.text = candy.description
    }
    
    public func setMaxCp(withMaxCp maxCp: Int)
    {
        if maxCp == 0 {
            maxCpValue.text = "N/A"
        } else {
            maxCpValue.text = maxCp.description
        }
    }
    
    public func setCaptureDate(withCaptureDate date: String)
    {
        if date == ""
        {
            captureDataValue.text = "N/A"
        }else {
            captureDataValue.text = date
        }
    }
    
    private func updatePokemonType()
    {
        type1.isHidden = true
        type2.isHidden = true
        let types = self.pokemonPrototype?.pokemonType
        if (types?.count)! < 1 {
            return
        }
        let firstType = types![0]
        var bgColor: UIColor = PokemonHelper.getTypeColor(withPokemonType: firstType)
        type1.backgroundColor = bgColor
        var type = PokemonHelper.getTypeDisplayName(forType: firstType)
        type1.text = type
        type1.isHidden = false
        if (types?.count)! == 2 {
            let secondType = types![1]
            bgColor = PokemonHelper.getTypeColor(withPokemonType: secondType)
            type2.backgroundColor = bgColor
            type = PokemonHelper.getTypeDisplayName(forType: secondType)
            type2.text = type
            type2.isHidden = false
        }
    }
    
    private func setFavorite(icon: UIImageView)
    {
        if (pokemon?.isFavorite)! {
            icon.image = icon.image!.withRenderingMode(.alwaysTemplate)
            icon.tintColor = favoriteColor
            icon.isHidden = false
        }else {
            icon.isHidden = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
