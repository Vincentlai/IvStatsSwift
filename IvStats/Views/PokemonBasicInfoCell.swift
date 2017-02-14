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
    
    var pokemon: Pokemon? {
        didSet
        {
            self.updatePokemon()
        }
    }
    
    private func getEggPokemon()
    {
        for index in 1...251
        {
            let id: PokemonId = PokemonId(rawValue: Int32(index))!
            if let proto = PokemonHelper.getPokemonPrototype(withPokemonId: id)
            {
                print("\(proto.pokemonId.toString())   \(proto.baseAttack)    \(proto.baseDefense)   \(proto.baseStamina)    \(proto.maxCp)")
            }
        }
    }
    
    private func updatePokemon()
    {

        // set favorite icon
        self.setFavorite(icon: favoriteIcon)
        // set cp
        let cpText = NSMutableAttributedString.init(string: "CP: " + (pokemon?.cp.description)!)
        cpText.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGray, range: NSRange.init(location: 0, length: 3))
        cpText.addAttribute(NSForegroundColorAttributeName, value: primaryTextColor, range: NSRange.init(location: 4, length: cpText.length-4))
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
