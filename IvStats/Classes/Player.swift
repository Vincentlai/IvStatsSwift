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
    
    var nickname: String?
    var level: Int?
    var team: String?
    var maxPokemonStorage: Int?
    var maxItemStorage: Int?
    var pokecoin: Int?
    var startdust: Int?
    var createDate: String?
    
    init(withPlayerData playerData: Pogoprotos.Data.PlayerData){
        super.init()
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

    }
    
}
