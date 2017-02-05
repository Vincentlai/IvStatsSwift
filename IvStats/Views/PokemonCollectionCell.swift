//
//  PokemonCollectionCell.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-25.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit

class PokemonCollectionCell: UICollectionViewCell {
    
    

    @IBOutlet weak var cpLabel: UILabel!
    @IBOutlet weak var ivLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
  
    
    @IBOutlet weak var ivLabelInList: UILabel!
    @IBOutlet weak var cpLabelInList: UILabel!
    @IBOutlet weak var favoriteIconInList: UIImageView!
    @IBOutlet weak var pokemonImageInList: UIImageView!
    @IBOutlet weak var pokemonNameInList: UILabel!
    var pokemon: Pokemon? {
        didSet {
            self.updataCell()
        }
    }
    
    private func updataCell(){
        // set cp
        let cp = String(describing: (pokemon?.cp)!)
        cpLabelInList.text = cp
        // set ib
        let iv = (pokemon?.getIv())! * 100
        ivLabelInList.text = String(format: "%.1f%%", (pokemon?.getIv())! * 100)
        self.setIvColor(withIv: iv)
        // set display name
        pokemonNameInList.text = pokemon?.getDisplayName()
        // set image
        let imageId = pokemon?.pokemonId.rawValue
        let imageName = "p" + String(Int(imageId!))
        if let image = UIImage(named: imageName){
            pokemonImageInList.image = image
        }
        // set favorite icon
        if (pokemon?.isFavorite)! {
            favoriteIconInList.image = favoriteIconInList.image!.withRenderingMode(.alwaysTemplate)
            favoriteIconInList.tintColor = favoriteColor
            favoriteIconInList.isHidden = false
        }else {
            favoriteIconInList.isHidden = true
        }
    }
    
    
    private func setIvColor(withIv iv: Double){
        if iv >= 80 {
            ivLabelInList.textColor = highIvColor
        }else if iv < 80 && iv >= 40 {
            ivLabelInList.textColor = mediumIvColor
        }else if iv < 40 && iv >= 20 {
            ivLabelInList.textColor = lowIvColor
        }else {
            ivLabelInList.textColor = UIColor.black
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

//        self.layer.borderWidth = 0.5
//        self.layer.cornerRadius = 4.0
//        self.layer.borderColor = (UIColor.black).cgColor
        cpLabelInList.textColor = primaryTextColor

    }
    
    
}
