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
    
    var prototype: PokemonPrototype {
        get {
            return PokemonHelper.getPokemonPrototype(withPokemonId: self.pokemonId)!
        }
    }
    var totalCpMultiplier: Float {
        get {
            return self.cpMultiplier + self.additionalCpMultiplier
        }
    }

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
        }else {
            print(self.pokemonId.description)
        }
        if pokemonData.hasMove2 {
            self.move2 = pokemonData.move2
        }else {
            print(self.pokemonId.description)
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
        let bestAttackMoveSet = PokemonMoveHelper.getBestAttackMoveSet(forPokemon: self.pokemonId)
        let bestDefenseMoveSet = PokemonMoveHelper.getBestDefenseMoveSet(forPokemon: self.pokemonId)
        if moveSet == bestAttackMoveSet {
            self.isBestAttackMoveSet = true
        }
        if moveSet == bestDefenseMoveSet {
            self.isBestDefenseMoveSet = true
        }
    }
    
    public func getBestAttackMoveSet() -> [PokemonMove] {
        return PokemonMoveHelper.getBestAttackMoveSet(forPokemon: self.pokemonId)
    }
    
    public func getBestDefenseMoveSet() -> [PokemonMove] {
        return PokemonMoveHelper.getBestDefenseMoveSet(forPokemon: self.pokemonId)
    }
    
    public func getBaseQuickMoveSet() -> [PokemonMove]{
        return PokemonMoveHelper.getBaseQuickMoveSet(forPokemon: self.pokemonId)
    }
    
    public func getBaseMainMoveSet() -> [PokemonMove]{
        return PokemonMoveHelper.getBaseMainMoveSet(forPokemon: self.pokemonId)
    }
    
    public func getMoveSet() -> [PokemonMove]
    {
        return [move1, move2]
    }
    
    public func getLevel() -> Float
    {
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
    
    private func getPokemonPrototype() -> PokemonPrototype
    {
        let prototype = PokemonHelper.getPokemonPrototype(withPokemonId: self.pokemonId)
        return prototype!
    }
    
    public func getMaxCp() -> Int
    {
        let attack = self.individualAttack + prototype.baseAttack
        let defense = self.individualDefense + prototype.baseDefense
        let stamina = self.individualStamina + prototype.baseStamina
        let cpMultiplier =  PokemonCPHelper.getCpMultiplier(byLevel: 40)
        let cp = (Int)((Double)(attack) * pow(Double(defense), 0.5) * pow((Double)(stamina), 0.5) * pow((Double)(cpMultiplier), 2) / 10);
        return cp
    }
    
    public func getMaxCp(byLevel level: Float) -> Int
    {
        var currentLevel = level
        if currentLevel > 40.0
        {
            currentLevel = 40.0
        }
        let cpMultiplier =  PokemonCPHelper.getCpMultiplier(byLevel: currentLevel)
        let attack = self.individualAttack + prototype.baseAttack
        let defense = self.individualDefense + prototype.baseDefense
        let stamina = self.individualStamina + prototype.baseStamina
        let cp = (Int)(Double(attack) * pow(Double(defense), 0.5) * pow(Double(stamina), 0.5) * pow(Double(cpMultiplier), 2) / 10);
        return cp
    }
    
    public func getCpAfterPowerup(withLevel targetLevel: Float?, currentCp: Int?) -> Int {
        var level: Float = self.getLevel()
        if targetLevel != nil {
            level = targetLevel!
        }
        var cp: Int = self.cp
        if currentCp != nil {
            cp = currentCp!
        }
        var cpDifference: Double = 0
        if (level <= 10) {
            cpDifference = round(((Double)(cp) * 0.009426125469) / pow((Double)(self.totalCpMultiplier), 2))
        }
        else if (level <= 20) {
            cpDifference = round(((Double)(cp) * 0.008919025675) / pow((Double)(self.totalCpMultiplier), 2))
        }
        else if (level <= 30) {
            cpDifference = round(((Double)(cp) * 0.008924905903) / pow((Double)(self.totalCpMultiplier), 2));
        }else {
            cpDifference = round(((Double)(cp) * 0.00445946079) / pow((Double)(self.totalCpMultiplier), 2));
        }
        return (Int)(cpDifference) + cp
    }
    
    public func getCandyCost(forLevel targetLevel: Float) -> Int {
        var level = self.getLevel()
        var candy = 0
        while level < targetLevel {
            if level < 11 {
                candy += 1
            } else if level < 21 {
                candy += 2
            } else if level < 26 {
                candy += 3
            } else if level < 31 {
                candy += 4
            } else if level < 33 {
                candy += 6
            } else if level < 35 {
                candy += 8
            } else if level < 37 {
                candy += 10
            } else if level < 39 {
                candy += 12
            } else {
                candy += 15
            }
            level += 0.5
        }
        return candy
    }
    
    public func getStardustCost(forLevel targetLevel: Float) -> Int {
        var level = self.getLevel()
        var stardust = 0
        while level < targetLevel {
            if level <= 2.5 {
                stardust += 200
            } else if level <= 4.5 {
                stardust += 400
            } else if level <= 6.5 {
                stardust += 600
            } else if level <= 8.5 {
                stardust += 800
            } else if level <= 10.5 {
                stardust += 1000
            } else if level <= 12.5 {
                stardust += 1300
            } else if level <= 14.5 {
                stardust += 1600
            } else if level <= 16.5 {
                stardust += 1900
            } else if level <= 18.5 {
                stardust += 2200
            } else if level <= 20.5 {
                stardust += 2500
            } else if level <= 22.5 {
                stardust += 3000
            } else if level <= 24.5 {
                stardust += 3500
            } else if level <= 26.5 {
                stardust += 4000
            } else if level <= 28.5 {
                stardust += 4500
            } else if level <= 30.5 {
                stardust += 5000
            } else if level <= 32.5 {
                stardust += 6000
            } else if level <= 34.5 {
                stardust += 7000
            } else if level <= 36.5 {
                stardust += 8000
            } else if level <= 38.5 {
                stardust += 9000
            } else {
                stardust += 10000
            }
            level += 0.5
        }
        return stardust
    }
    
    
}
