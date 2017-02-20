//
//  PokemonPrototype.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-12.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation

enum PokemonEggType
{
    case K2
    case K5
    case K10
    case Unknown
}

struct PokemonPrototype {
    var pokemonId: PokemonId
    var pokemonType: [PokemonType]
    var familyId: PokemonFamilyId
    var parentId: PokemonId
    var baseAttack: Int
    var baseDefense: Int
    var baseStamina: Int
    var height: Double
    var weight: Double
    var nextEvolve: [PokemonId]
    var candyToEvolve: Int
    var buddyDistance: Float

    public func getDisplayName() -> String {
        var name = self.pokemonId.toString()
        name = name.replacingOccurrences(of: "_MALE", with: "♂")
        name = name.replacingOccurrences(of: "_FEMALE", with: "♀")
        name = name.lowercased()
        name = name.capitalized
        return name
    }
    
    public func getImageName() -> String
    {
        let imageId = pokemonId.rawValue
        let imageName = "p" + String(Int(imageId))
        return imageName
    }
    
    public func getCpAfterEvolve(withAttack attack: Int, defense: Int, stamina: Int, level: Float) -> Int {
        var currentLevel = level
        if currentLevel > 40.0
        {
            currentLevel = 40.0
        }
        let cpMultiplier =  PokemonCPHelper.getCpMultiplier(byLevel: currentLevel)
        let attack = self.baseAttack + attack
        let defense = self.baseDefense + defense
        let stamina = self.baseStamina + stamina
        let cp = (Int)(Double(attack) * pow(Double(defense), 0.5) * pow(Double(stamina), 0.5) * pow(Double(cpMultiplier), 2) / 10);
        return cp
    }
    
    
}















