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
        let iv = (pokemon?.getIv())! * 100
        self.setIvTextAndColor(withIv: iv)
        // set display name
        if self.viewType! == .Grid {
            pokemonName.text = pokemon?.getDisplayName()
        }else {
            pokemonNameInList.text = pokemon?.getDisplayName()
        }
        // set image
        let imageId = pokemon?.pokemonId.rawValue
        let imageName = "p" + String(Int(imageId!))
        if let image = UIImage(named: imageName){
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
    
    private func setIvTextAndColor(withIv iv: Double){
        if self.viewType == .Grid {
            ivLabel.text = String(format: "%.1f%%", (pokemon?.getIv())! * 100)
            if iv >= 80 {
                ivLabel.textColor = highIvColor
            }else if iv < 80 && iv >= 40 {
                ivLabel.textColor = mediumIvColor
            }else if iv < 40 && iv >= 20 {
                ivLabel.textColor = lowIvColor
            }else {
                ivLabel.textColor = UIColor.black
            }
        }else {
            ivLabelInList.text = String(format: "%.1f%%", (pokemon?.getIv())! * 100)
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

    }
    
    override func awakeFromNib() {

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    
}
