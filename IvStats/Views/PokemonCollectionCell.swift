//
//  PokemonCollectionCell.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-25.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit

class PokemonCollectionCell: UICollectionViewCell {
    
    var pokemonName: UILabel!
    var isGridView: Bool!
    
    open var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame.size = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setCellView()
        
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setCellView()
    }

    public func setCellView() {
        self.pokemonName = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        self.pokemonName.numberOfLines = 1;
        self.pokemonName.textColor = primaryTextColor
        self.contentView.addSubview(self.pokemonName)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4.0
        self.layer.borderColor = (UIColor.black).cgColor
    }
    
    
}
