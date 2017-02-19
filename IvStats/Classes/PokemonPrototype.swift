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
    var nextEvolutePokemonId: PokemonId
    var nextEvolutionCandy: Int
    var secondEvolutePokemonId: PokemonId
    var secondEvolutionCandy: Int
    var baseAttack: Int
    var baseDefense: Int
    var baseStamina: Int
    var maxCp: Int
    var height: Double
    var weight: Double
    var baseCaptureRate: Double
    var baseFleeRate: Double
    var bestAttackMoveSet: [PokemonMove]
    var bestDefenseMoveSet: [PokemonMove]
    var baseQuickMoveSet: [PokemonMove]
    var baseMainMoveSet: [PokemonMove]
    var pokemonEgg: PokemonEggType

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
}















