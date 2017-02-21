//
//  User.swift
//  IvStats
//
//  Created by LaiQiang on 2017-01-16.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation
import PGoApi

class Player: NSObject{
    
    var nickname: String = "Player"
    var team: String = "N/A"
    var maxPokemonStorage: Int = 0
    var maxItemStorage: Int = 0
    var pokecoin: Int32 = 0
    var stardust: Int32 = 0
    var createDate: String = "N/A"
    var level: Int32 = Int32(0)
    var experience: Int64 = Int64(0)
    var nextLevelXp: Int64 = Int64(0)
    var kmWalked: Float = 0.0
    var pokemonsEncountered: Int32 = Int32(0)
    var uniquePokedexEntries: Int32 = Int32(0)
    var pokemonsCaptured: Int32 = Int32(0)
    var evolutions: Int32 = Int32(0)
    var pokeStopVisits: Int32 = Int32(0)
    var pokeballsThrown: Int32 = Int32(0)
    var eggsHatched: Int32 = Int32(0)
    var bigMagikarpCaught: Int32 = Int32(0)
    var battleAttackWon: Int32 = Int32(0)
    var battleAttackTotal: Int32 = Int32(0)
    var battleDefendedWon:Int32 = Int32(0)
    var battleTrainingWon: Int32 = Int32(0)
    var battleTrainingTotal: Int32 = Int32(0)
    var prestigeRaisedTotal: Int32 = Int32(0)
    var prestigeDroppedTotal: Int32 = Int32(0)
    var pokemonDeployed: Int32 = Int32(0)
    
    override init(){
        super.init()
    }
    public func updataPlayer(withPlayerStats playerStats: Pogoprotos.Data.Player.PlayerStats) {
        if playerStats.hasLevel {
            level = playerStats.level
        }
        if playerStats.hasExperience {
            experience = playerStats.experience
        }
        if playerStats.hasNextLevelXp {
            nextLevelXp = playerStats.nextLevelXp
        }
        if playerStats.hasKmWalked {
            kmWalked = playerStats.kmWalked
        }
        if playerStats.hasPokemonsEncountered {
            pokemonsEncountered = playerStats.pokemonsEncountered
        }
        if playerStats.hasUniquePokedexEntries {
            uniquePokedexEntries = playerStats.uniquePokedexEntries
        }
        if playerStats.hasPokemonsCaptured {
            pokemonsCaptured = playerStats.pokemonsCaptured
        }
        if playerStats.hasEvolutions {
            evolutions = playerStats.evolutions
        }
        if playerStats.hasPokeStopVisits {
            pokeStopVisits = playerStats.pokeStopVisits
        }
        if playerStats.hasPokeballsThrown {
            pokeballsThrown = playerStats.pokeballsThrown
        }
        if playerStats.hasEggsHatched {
            eggsHatched = playerStats.eggsHatched
        }
        if playerStats.hasBigMagikarpCaught {
            bigMagikarpCaught = playerStats.bigMagikarpCaught
        }
        if playerStats.hasBattleAttackWon {
            battleAttackWon = playerStats.battleAttackWon
        }
        if playerStats.hasBattleAttackTotal {
            battleAttackTotal = playerStats.battleAttackTotal
        }
        if playerStats.hasBattleDefendedWon {
            battleDefendedWon = playerStats.battleDefendedWon
        }
        if playerStats.hasBattleTrainingWon {
            battleTrainingWon = playerStats.battleTrainingWon
        }
        if playerStats.hasBattleTrainingTotal {
            battleTrainingTotal = playerStats.battleTrainingTotal
        }
        if playerStats.hasPrestigeRaisedTotal {
            prestigeRaisedTotal = playerStats.prestigeRaisedTotal
        }
        if playerStats.hasPrestigeDroppedTotal {
            prestigeDroppedTotal = playerStats.prestigeDroppedTotal
        }
        if playerStats.hasPokemonDeployed {
            pokemonDeployed = playerStats.pokemonDeployed
        }
    }
    
    public func updatePlayer(withPlayerData playerData: Pogoprotos.Data.PlayerData)
    {
        if playerData.hasUsername
        {
            self.nickname = playerData.username
        }
        if playerData.hasTeam
        {
            self.team = playerData.team.toString()
        }
        if playerData.hasMaxItemStorage
        {
            self.maxItemStorage = Int(playerData.maxItemStorage)
        }
        if playerData.hasMaxPokemonStorage
        {
            self.maxPokemonStorage = Int(playerData.maxPokemonStorage)
        }
        if playerData.hasCreationTimestampMs
        {
            self.createDate = Helper.dateConverter(withTimestamp: playerData.creationTimestampMs)
        }
        let currencies = playerData.currencies
        if currencies.count == 0 {
            return
        }
        for item in currencies {
            if item.name.lowercased() == "stardust"
            {
                self.stardust = item.amount
            }else if item.name.lowercased() == "pokecoin"
            {
                self.pokecoin = item.amount
            }
        }

    }

    public func getBattleStats() -> [String]
    {
        var battleStats: [String] = []
        battleStats.append(self.battleAttackTotal.description)
        battleStats.append(self.battleAttackWon.description)
        battleStats.append(self.battleTrainingTotal.description)
        battleStats.append(self.battleTrainingWon.description)
        battleStats.append(self.prestigeRaisedTotal.description)
        battleStats.append(self.prestigeDroppedTotal.description)
        return battleStats
    }
    
    public func getPokemonStats() -> [String]
    {
        var pokemonStats: [String] = []
        pokemonStats.append(pokemonList.count.description)
        pokemonStats.append(self.evolutions.description)
        pokemonStats.append(self.pokeballsThrown.description)
        pokemonStats.append(self.pokemonDeployed.description)
        pokemonStats.append(self.pokemonsCaptured.description)
        pokemonStats.append(self.pokemonsEncountered.description)
        return pokemonStats
    }
    
    public func getPlayerInfo() -> [String]
    {
        var playerInfo: [String] = []
        playerInfo.append(self.level.description)
        playerInfo.append(self.stardust.description)
        playerInfo.append(self.experience.description)
//        playerInfo.append(self.nextLevelXp.description)
        playerInfo.append(self.kmWalked.description)
        playerInfo.append(self.pokeStopVisits.description)
        return playerInfo
    }
    
}
