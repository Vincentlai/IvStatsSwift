//
//  Pokemon.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-22.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation
import PGoApi

enum Pokeball {
    case Pokeball
    case Masterball
    case PokeballUnset
}

typealias PokemonId = Pogoprotos.Enums.PokemonId
typealias PokemonType = Pogoprotos.Enums.PokemonType
typealias PokemonMove = Pogoprotos.Enums.PokemonMove
typealias PokemonFamilyId = Pogoprotos.Enums.PokemonFamilyId

class Pokemon: NSObject{
    
    var id: UInt64 = UInt64(0)
    var pokemonId: PokemonId = PokemonId.missingno
    var cp: Int = 0
    var stamina: Int = 0
    var staminaMax: Int = 0
    var move1: PokemonMove = PokemonMove.moveUnset
    var move2: PokemonMove = PokemonMove.moveUnset
    var height: Float = 0
    var weight: Float = 0
    var individualAttack: Int = 0
    var individualDefense: Int = 0
    var individualStamina: Int = 0
    var cpMultiplier: Float = 0
    var pokeball: Pokeball = Pokeball.PokeballUnset
    var capturedCellId: UInt64 = UInt64(0)
    var creationTime: String = ""
    var creationTimeInMs: UInt64 = UInt64(0)
    var isFavorite: Bool = false
    var nickname: String = ""
    var battlesAttacked: Int = 0
    var battlesDefended: Int = 0
    var numUpgrades: Int = 0
    var additionalCpMultiplier:Float = Float(0)
    
    var isBestAttackMoveSet: Bool = false
    var isBestDefenseMoveSet: Bool = false

    init(withPokemonData pokemonData: Pogoprotos.Data.PokemonData) {
        super.init()
        if pokemonData.hasId {
            self.id = pokemonData.id
        }
        if pokemonData.hasPokemonId {
            self.pokemonId = pokemonData.pokemonId
        }
        if pokemonData.hasCp {
            self.cp = Int(pokemonData.cp)
        }
        if pokemonData.hasStamina {
            self.stamina = Int(pokemonData.stamina)
        }
        if pokemonData.hasStaminaMax {
            self.staminaMax = Int(pokemonData.staminaMax)
        }
        if pokemonData.hasMove1 {
            self.move1 = pokemonData.move1
        }
        if pokemonData.hasMove2 {
            self.move2 = pokemonData.move2
        }
        if pokemonData.hasHeightM {
            self.height = pokemonData.heightM
        }
        if pokemonData.hasHeightM {
            self.height = pokemonData.heightM
        }
        if pokemonData.hasWeightKg {
            self.weight = pokemonData.weightKg
        }
        if pokemonData.hasIndividualAttack {
            self.individualAttack = Int(pokemonData.individualAttack)
        }
        if pokemonData.hasIndividualDefense {
            self.individualDefense = Int(pokemonData.individualDefense)
        }
        if pokemonData.hasIndividualStamina {
            self.individualStamina = Int(pokemonData.individualStamina)
        }
        if pokemonData.hasCpMultiplier {
            self.cpMultiplier = pokemonData.cpMultiplier
        }
        if pokemonData.hasCapturedCellId {
            self.capturedCellId = pokemonData.capturedCellId
        }
        if pokemonData.hasBattlesAttacked {
            self.battlesAttacked = Int(pokemonData.battlesAttacked)
        }
        if pokemonData.hasBattlesDefended {
            self.battlesDefended = Int(pokemonData.battlesDefended)
        }
        if pokemonData.hasNumUpgrades {
            self.numUpgrades = Int(pokemonData.numUpgrades)
        }
        if pokemonData.hasFavorite && pokemonData.favorite == 1{
            self.isFavorite = true
        }
        if pokemonData.hasNickname {
            self.nickname = pokemonData.nickname
        }
        if pokemonData.hasCreationTimeMs {
            self.creationTimeInMs = pokemonData.creationTimeMs
            self.creationTime = Helper.dateConverter(withTimestamp: Int64(pokemonData.creationTimeMs))
        }
        if pokemonData.hasAdditionalCpMultiplier {
            self.additionalCpMultiplier = pokemonData.additionalCpMultiplier
        }
        self.setMoveStats()
    }
    
    private func setMoveStats()
    {
        let moveSet = self.getMoveSet()
        let pokemonPorototype = PokemonHelper.getPokemonPrototype(withPokemonId: self.pokemonId)
        if moveSet == (pokemonPorototype?.bestAttackMoveSet)! {
            self.isBestAttackMoveSet = true
        }
        if moveSet == (pokemonPorototype?.bestDefenseMoveSet)! {
            self.isBestDefenseMoveSet = true
        }
    }
    
    public func getMoveSet() -> [PokemonMove]
    {
        return [move1, move2]
    }
    
    public func getLevel() -> Float
    {
        let totalCpMultiplier = cpMultiplier + additionalCpMultiplier
        var level: Float = Float(0)
        if totalCpMultiplier < 0.736
        {
            level = 58.35178527 * totalCpMultiplier * totalCpMultiplier - 2.838007664 * totalCpMultiplier + 0.8539209906;
        }
        else
        {
            level = 171.0112688 * totalCpMultiplier - 95.20425243;
        }
        return round((level) * 2) / 2.0;
    }
    
    public func getImageName() -> String
    {
        let imageId = pokemonId.rawValue
        let imageName = "p" + String(Int(imageId))
        return imageName
    }
    
    public func getIv() -> Double {
        return Double(self.individualStamina + self.individualDefense + self.individualAttack) / 45.0 * 100.0
    }
    
    public func getIvText() -> String
    {
        return String(format: "%.1f%%", getIv())
    }
    
    public func getDisplayName() -> String {
        if self.nickname == "" {
            var name = self.pokemonId.toString()
            name = name.replacingOccurrences(of: "_MALE", with: "♂")
            name = name.replacingOccurrences(of: "_FEMALE", with: "♀")
            name = name.lowercased()
            name = name.capitalized
            return name
        }else {
            return self.nickname
        }
    }
    
    public func getMaxCp() -> Int
    {
        let cpMultiplier =  PokemonCPHelper.getCpMultiplier(byLevel: 40)
        let cp = (Int)((Double)(individualAttack) * pow(Double(individualDefense), 0.5) * pow((Double)(individualStamina), 0.5) * pow((Double)(cpMultiplier), 2) / 10);
        return cp
    }
    
    public func getMaxCp(byLevel level: CGFloat) -> Int
    {
        var currentLevel = level
        if currentLevel > 40.0
        {
            currentLevel = 40.0
        }
        let cpMultiplier =  PokemonCPHelper.getCpMultiplier(byLevel: currentLevel)
        let cp = (Int)(Double(individualAttack) * pow(Double(individualDefense), 0.5) * pow(Double(individualStamina), 0.5) * pow(Double(cpMultiplier), 2) / 10);
        return cp
    }
}
