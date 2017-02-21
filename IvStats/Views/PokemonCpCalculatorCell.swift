//
//  PokemonCpCalculatorCell.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-16.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import UIKit

class PokemonCpCalculatorCell: UITableViewCell {

    
    @IBOutlet weak var levelValue: UILabel!
    
    @IBOutlet weak var levelSlideBar: UISlider!
    @IBOutlet weak var minLevelValue: UILabel!
    @IBOutlet weak var cpValue: UILabel!
    @IBOutlet weak var candyValue: UILabel!
    @IBOutlet weak var stardustValue: UILabel!
    
    let step: Float = 0.5
    var pokemon: Pokemon? {
        didSet {
            self.minLevel = self.pokemon!.getLevel()
            self.targetLevel = self.minLevel
            self.cp = self.pokemon!.cp
            self.updateUI()
        }
    }
    var minLevel: Float = 0
    let maxLevel: Float = 40
    var targetLevel: Float = 0
    var cp: Int = 0
    var candy: Int = 0
    var stardust: Int = 0
    
    private func updateUI()
    {
        minLevelValue.text = self.minLevel.description
        levelSlideBar.minimumValue = self.minLevel
        levelSlideBar.maximumValue = self.maxLevel
        levelValue.text = self.targetLevel.description
        cpValue.text = self.cp.description
        candyValue.text = self.candy.description
        stardustValue.text = self.stardust.description
    }
    
    @IBAction func levelValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        if roundedValue > 40 || roundedValue < self.minLevel {
            return
        }
        sender.value = roundedValue
        self.targetLevel = roundedValue
        self.cp = self.pokemon!.getMaxCp(byLevel: self.targetLevel)
        self.candy = self.pokemon!.getCandyCost(forLevel: self.targetLevel)
        self.stardust = self.pokemon!.getStardustCost(forLevel: targetLevel)
        self.updateUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
