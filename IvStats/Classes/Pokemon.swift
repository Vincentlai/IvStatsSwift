//
//  Pokemon.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-22.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation
import PGoApi

struct Move {
    var name: String
}

enum Pokeball {
    case Pokeball
    case Masterball
    case PokeballUnset
}

typealias PokemonId = Pogoprotos.Enums.PokemonId

class Pokemon: NSObject{
    
    var id: UInt64 = UInt64(0)
    var pokemonId: PokemonId = PokemonId.missingno
    var cp: Int = 0
    var stamina: Int = 0
    var staminaMax: Int = 0
    var move1: Move = Move(name: "")
    var move2: Move = Move(name: "")
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
            self.move1 = Move(name: pokemonData.move1.toString())
        }
        if pokemonData.hasMove2 {
            self.move2 = Move(name: pokemonData.move2.toString())
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
    }
    
    public func getIv() -> Double {
        return Double(self.individualStamina + self.individualDefense + self.individualAttack) / 45.0
    }
    
    public func getDisplayName() -> String {
        if self.nickname == "" {
            return self.pokemonId.toString()
        }else {
            return self.nickname
        }
    }
}
