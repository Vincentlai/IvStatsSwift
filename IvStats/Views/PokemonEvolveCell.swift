//
//  PokemonEvolveCell.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-19.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit

class PokemonEvolveCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var cpValue: UILabel!
    
    var pokemon: Pokemon?
    var evolveId: PokemonId? {
        didSet {
            self.updateUi()
        }
    }
    
    private func updateUi(){
        let prototype = PokemonHelper.getPokemonPrototype(withPokemonId: evolveId!)
        let cp = prototype!.getCpAfterEvolve(withAttack: self.pokemon!.individualAttack, defense: self.pokemon!.individualDefense, stamina: self.pokemon!.individualStamina, level: self.pokemon!.getLevel())
        if let image = UIImage(named: (prototype?.getImageName())!)
        {
            pokemonImage.image = image
        }
        pokemonName.text = prototype?.getDisplayName()
        cpValue.text = cp.description

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
