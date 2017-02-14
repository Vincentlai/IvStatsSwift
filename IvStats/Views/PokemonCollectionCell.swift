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
    
    var viewType: ViewType?
    
    var pokemon: Pokemon? {
        didSet {
            self.updataCell()
        }
    }
    
    private func updataCell(){
        
        if self.viewType! == .Grid {
            cpLabel.textColor = primaryTextColor
        }else {
            cpLabelInList.textColor = primaryTextColor
        }
        
        if self.viewType! == .Grid {
            self.layer.borderWidth = 0.5
            self.layer.cornerRadius = 4.0
            self.layer.borderColor = (UIColor.black).cgColor
        }
        // set cp
        let cp = String(describing: (pokemon?.cp)!)
        if self.viewType! == .Grid {
            cpLabel.text = cp
        }else {
            cpLabelInList.text = cp
        }
        // set iv
        self.setIvTextAndColor()
        // set display name
        if self.viewType! == .Grid {
            pokemonName.text = pokemon?.getDisplayName()
        }else {
            pokemonNameInList.text = pokemon?.getDisplayName()
        }
        // set image
        if let image = UIImage(named: (pokemon?.getImageName())!){
            if self.viewType! == .Grid {
                pokemonImage.image = image
            }else {
                pokemonImageInList.image = image
            }
        }
        // set favorite icon
        if self.viewType! == .Grid {
            self.setFavorite(icon: favoriteIcon)
        }else {
            self.setFavorite(icon: favoriteIconInList)
        }
    }
    
    private func setFavorite(icon: UIImageView){
        if (pokemon?.isFavorite)! {
            icon.image = icon.image!.withRenderingMode(.alwaysTemplate)
            icon.tintColor = favoriteColor
            icon.isHidden = false
        }else {
            icon.isHidden = true
        }
    }
    
    private func setIvTextAndColor(){
        let iv = (pokemon?.getIv())!
        if self.viewType == .Grid {
            ivLabel.text = pokemon?.getIvText()
            ivLabel.textColor = PokemonHelper.getPokemonIvTextColor(withIv: iv)
        }else {
            ivLabelInList.text = pokemon?.getIvText()
            ivLabelInList.textColor = PokemonHelper.getPokemonIvTextColor(withIv: iv)
        }

    }
    
    override func awakeFromNib() {

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    
}
