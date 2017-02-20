//
//  PokemonHelper.swift
//  IvStats
//
//  Created by LaiQiang on 2017-02-06.
//  Copyright © 2017 LaiQiang. All rights reserved.
//

import Foundation
import UIKit
class PokemonHelper {
    
    
    class func getCandy(forPokemonFamily family: PokemonFamilyId) -> Int32
    {
        var candyNumber: Int32 = 0
        candyList.forEach { (candy) in
            if candy.familyId == family {
                candyNumber = candy.candy
            }
        }
        return candyNumber
    }
    
    class func isBestAttackMove(withMove move: PokemonMove, pokemon: PokemonId) -> Bool
    {
        let bestAttackMoveSet = PokemonMoveHelper.getBestAttackMoveSet(forPokemon: pokemon)
        if bestAttackMoveSet.contains(move){
            return true
        }else{
            return false
        }
    }
    
    class func isBestDefenseMove(withMove move: PokemonMove, pokemon: PokemonId) -> Bool
    {
        let bestDefenseMoveSet = PokemonMoveHelper.getBestDefenseMoveSet(forPokemon: pokemon)

        if bestDefenseMoveSet.contains(move){
            return true
        }else{
            return false
        }
    }
    
    class func getPokemonIvTextColor(withIv iv:Double) -> UIColor
    {
        if iv >= 80 {
            return highIvColor
        }else if iv < 80 && iv >= 40 {
            return mediumIvColor
        }else if iv < 40 && iv >= 20 {
            return lowIvColor
        }else {
            return trashIvColor
        }
    }
    
    class func getTypeDisplayName(forType type: PokemonType) -> String
    {
        var name = type.toString()
        name = name.replacingOccurrences(of: "POKEMON_TYPE_", with: "")
        name = name.lowercased()
        name = name.capitalized
        return name
    }
    
    class func getTypeColor(withPokemonType type: PokemonType) -> UIColor
    {
        switch type {
        case .pokemonTypeNormal: return normalTypeColor
        case .pokemonTypeFighting: return fightTypeColor
        case .pokemonTypeFlying: return flyingTypeColor
        case .pokemonTypePoison: return poisonTypeColor
        case .pokemonTypeGround: return groundTypeColor
        case .pokemonTypeRock: return rockTypeColor
        case .pokemonTypeBug: return bugTypeColor
        case .pokemonTypeGhost: return ghostTypeColor
        case .pokemonTypeSteel: return steelTypeColor
        case .pokemonTypeFire: return fireTypeColor
        case .pokemonTypeWater: return waterTypeColor
        case .pokemonTypeGrass: return grassTypeColor
        case .pokemonTypeElectric: return electricTypeColor
        case .pokemonTypePsychic: return psychicTypeColor
        case .pokemonTypeIce: return iceTypeColor
        case .pokemonTypeDragon: return dragonTypeColor
        case .pokemonTypeDark: return darkTypeColor
        case .pokemonTypeFairy: return fairyTypeColor
        default:
            return primaryColor
        }
    }
    
    class func doSortPokemon(sortType: SortType?, reverse: Bool?)
    {
        if sortType == nil || reverse == nil{
            return
        }
        switch sortType! {
        case .Cp:
            if !reverse! {
                pokemonList.sort(by: { (first, second) -> Bool in
                    if first.cp > second.cp {
                        return true
                    }else if first.cp < second.cp {
                        return false
                    }else {
                        if first.getIv() > second.getIv() {
                            return true
                        }else {
                            return false
                        }
                    }
                })
            }else {
                pokemonList.sort(by: { (first, second) -> Bool in
                    if first.cp > second.cp {
                        return false
                    }else if first.cp < second.cp {
                        return true
                    }else {
                        if first.getIv() > second.getIv() {
                            return true
                        }else {
                            return false
                        }
                    }
                })
            }
            break
        case .Favorite:
            if !reverse! {
                pokemonList.sort(by: { (first, second) -> Bool in
                    if first.isFavorite && !second.isFavorite {
                        return true
                    }else if !first.isFavorite && second.isFavorite {
                        return false
                    }else {
                        if first.getIv() > second.getIv() {
                            return true
                        }else if first.getIv() < second.getIv(){
                            return false
                        }else {
                            if first.cp > second.cp {
                                return true
                            }else {
                                return false
                            }
                        }
                    }
                })
            }else {
                pokemonList.sort(by: { (first, second) -> Bool in
                    if first.isFavorite && !second.isFavorite {
                        return false
                    }else if !first.isFavorite && second.isFavorite {
                        return true
                    }else {
                        if first.getIv() > second.getIv() {
                            return true
                        }else if first.getIv() < second.getIv(){
                            return false
                        }else {
                            if first.cp > second.cp {
                                return true
                            }else {
                                return false
                            }
                        }
                    }
                })
            }
            break
        case .Iv:
            if !reverse! {
                pokemonList.sort(by: { (first, second) -> Bool in
                    if first.getIv() > second.getIv(){
                        return true
                    }else if first.getIv() < second.getIv(){
                        return false
                    }else {
                        if first.cp > second.cp {
                            return true
                        }else {
                            return false
                        }
                    }
                })
            }else {
                pokemonList.sort(by: { (first, second) -> Bool in
                    if first.getIv() > second.getIv(){
                        return false
                    }else if first.getIv() < second.getIv(){
                        return true
                    }else {
                        if first.cp > second.cp {
                            return true
                        }else {
                            return false
                        }
                    }
                })
            }
            break
        case .MaxCp:
            if !reverse! {
                pokemonList.sort(by: { (first, second) -> Bool in
                    if first.getMaxCp() > second.getMaxCp() {
                        return true
                    }else if first.getMaxCp() < second.getMaxCp(){
                        return false
                    }else {
                        if first.getIv() > second.getIv() {
                            return true
                        }else if first.getIv() < second.getIv(){
                            return false
                        }else {
                            if first.cp > second.cp {
                                return true
                            }else {
                                return false
                            }
                        }
                    }
                })
            }else {
                pokemonList.sort(by: { (first, second) -> Bool in
                    if first.getMaxCp() > second.getMaxCp() {
                        return false
                    }else if first.getMaxCp() < second.getMaxCp(){
                        return true
                    }else {
                        if first.getIv() > second.getIv() {
                            return true
                        }else if first.getIv() < second.getIv(){
                            return false
                        }else {
                            if first.cp > second.cp {
                                return true
                            }else {
                                return false
                            }
                        }
                    }
                })
            }
            break
        case .Name:
            if !reverse! {
                pokemonList.sort(by: { (first, second) -> Bool in
                    if first.getDisplayName() < second.getDisplayName(){
                        return true
                    }else if first.getDisplayName() == second.getDisplayName(){
                        if first.getIv() > second.getIv() {
                            return true
                        }else if first.getIv() < second.getIv(){
                            return false
                        }else {
                            if first.cp > second.cp {
                                return true
                            }else {
                                return false
                            }
                        }
                    }
                    else {
                        return false
                    }
                })
            }else {
                pokemonList.sort(by: { (first, second) -> Bool in
                    if first.getDisplayName() < second.getDisplayName(){
                        return false
                    }else if first.getDisplayName() == second.getDisplayName(){
                        if first.getIv() > second.getIv() {
                            return true
                        }else if first.getIv() < second.getIv(){
                            return false
                        }else {
                            if first.cp > second.cp {
                                return true
                            }else {
                                return false
                            }
                        }
                    }
                    else {
                        return true
                    }
                })
            }
            break
        case .Recent:
            if !reverse! {
                pokemonList.sort(by: { (first, second) -> Bool in
                    return first.creationTimeInMs > second.creationTimeInMs
                })
            }else {
                pokemonList.sort(by: { (first, second) -> Bool in
                    return first.creationTimeInMs < second.creationTimeInMs
                })
            }
            break
        case .Number:
            if !reverse! {
                pokemonList.sort(by: { (first, second) -> Bool in
                    if first.pokemonId.rawValue > second.pokemonId.rawValue{
                        return true
                    }else if first.pokemonId.rawValue < second.pokemonId.rawValue{
                        return false
                    }else {
                        if first.getIv() > second.getIv() {
                            return true
                        }else if first.getIv() < second.getIv(){
                            return false
                        }else {
                            if first.cp > second.cp {
                                return true
                            }else {
                                return false
                            }
                        }
                    }
                })
            }else {
                pokemonList.sort(by: { (first, second) -> Bool in
                    if first.pokemonId.rawValue > second.pokemonId.rawValue{
                        return false
                    }else if first.pokemonId.rawValue < second.pokemonId.rawValue{
                        return true
                    }else {
                        if first.getIv() > second.getIv() {
                            return true
                        }else if first.getIv() < second.getIv(){
                            return false
                        }else {
                            if first.cp > second.cp {
                                return true
                            }else {
                                return false
                            }
                        }
                    }
                })
            }
            break
        default :
            break
        }
    }
    
    class func getPokemonPrototype(withPokemonId pokemonId: PokemonId) -> PokemonPrototype?
    {
        return pokemonPrototypeDictionary[pokemonId]
    }
    
    static let pokemonPrototypeDictionary: [PokemonId: PokemonPrototype] =
        [
            .missingno: PokemonPrototype.init(pokemonId: .missingno, pokemonType: [], familyId: .familyUnset, parentId: .missingno, baseAttack: 0, baseDefense: 0, baseStamina: 0, height: 0, weight: 0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 0),
            .bulbasaur: PokemonPrototype.init(pokemonId: .bulbasaur, pokemonType: [.pokemonTypeGrass, .pokemonTypePoison], familyId: .familyBulbasaur, parentId: .missingno, baseAttack: 118, baseDefense: 118, baseStamina: 90, height: 0.0875, weight: 0.8625, nextEvolve: [.ivysaur], candyToEvolve: 25, buddyDistance: 3.0),
            .ivysaur: PokemonPrototype.init(pokemonId: .ivysaur, pokemonType: [.pokemonTypeGrass, .pokemonTypePoison], familyId: .familyBulbasaur, parentId: .bulbasaur, baseAttack: 151, baseDefense: 151, baseStamina: 120, height: 0.125, weight: 1.625, nextEvolve: [.venusaur], candyToEvolve: 100, buddyDistance: 3.0),
            .venusaur: PokemonPrototype.init(pokemonId: .venusaur, pokemonType: [.pokemonTypeGrass, .pokemonTypePoison], familyId: .familyBulbasaur, parentId: .ivysaur, baseAttack: 198, baseDefense: 198, baseStamina: 160, height: 0.25, weight: 12.5, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .charmander: PokemonPrototype.init(pokemonId: .charmander, pokemonType: [.pokemonTypeFire], familyId: .familyCharmander, parentId: .missingno, baseAttack: 116, baseDefense: 96, baseStamina: 78, height: 0.075, weight: 1.0625, nextEvolve: [.charmeleon], candyToEvolve: 25, buddyDistance: 3.0),
            .charmeleon: PokemonPrototype.init(pokemonId: .charmeleon, pokemonType: [.pokemonTypeFire], familyId: .familyCharmander, parentId: .charmander, baseAttack: 158, baseDefense: 129, baseStamina: 116, height: 0.1375, weight: 2.375, nextEvolve: [.charizard], candyToEvolve: 100, buddyDistance: 3.0),
            .charizard: PokemonPrototype.init(pokemonId: .charizard, pokemonType: [.pokemonTypeFire, .pokemonTypeFlying], familyId: .familyCharmander, parentId: .charmeleon, baseAttack: 223, baseDefense: 176, baseStamina: 156, height: 0.2125, weight: 11.3125, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .squirtle: PokemonPrototype.init(pokemonId: .squirtle, pokemonType: [.pokemonTypeWater], familyId: .familySquirtle, parentId: .missingno, baseAttack: 94, baseDefense: 122, baseStamina: 88, height: 0.0625, weight: 1.125, nextEvolve: [.wartortle], candyToEvolve: 25, buddyDistance: 3.0),
            .wartortle: PokemonPrototype.init(pokemonId: .wartortle, pokemonType: [.pokemonTypeWater], familyId: .familySquirtle, parentId: .squirtle, baseAttack: 126, baseDefense: 155, baseStamina: 118, height: 0.125, weight: 2.8125, nextEvolve: [.blastoise], candyToEvolve: 100, buddyDistance: 3.0),
            .blastoise: PokemonPrototype.init(pokemonId: .blastoise, pokemonType: [.pokemonTypeWater], familyId: .familySquirtle, parentId: .wartortle, baseAttack: 171, baseDefense: 210, baseStamina: 158, height: 0.2, weight: 10.6875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .caterpie: PokemonPrototype.init(pokemonId: .caterpie, pokemonType: [.pokemonTypeBug], familyId: .familyCaterpie, parentId: .missingno, baseAttack: 55, baseDefense: 62, baseStamina: 90, height: 0.0375, weight: 0.3625, nextEvolve: [.metapod], candyToEvolve: 12, buddyDistance: 1.0),
            .metapod: PokemonPrototype.init(pokemonId: .metapod, pokemonType: [.pokemonTypeBug], familyId: .familyCaterpie, parentId: .caterpie, baseAttack: 45, baseDefense: 94, baseStamina: 100, height: 0.0875, weight: 1.2375, nextEvolve: [.butterfree], candyToEvolve: 50, buddyDistance: 1.0),
            .butterfree: PokemonPrototype.init(pokemonId: .butterfree, pokemonType: [.pokemonTypeBug, .pokemonTypeFlying], familyId: .familyCaterpie, parentId: .metapod, baseAttack: 167, baseDefense: 151, baseStamina: 120, height: 0.1375, weight: 4.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .weedle: PokemonPrototype.init(pokemonId: .weedle, pokemonType: [.pokemonTypeBug, .pokemonTypePoison], familyId: .familyWeedle, parentId: .missingno, baseAttack: 63, baseDefense: 55, baseStamina: 80, height: 0.0375, weight: 0.4, nextEvolve: [.kakuna], candyToEvolve: 12, buddyDistance: 1.0),
            .kakuna: PokemonPrototype.init(pokemonId: .kakuna, pokemonType: [.pokemonTypeBug, .pokemonTypePoison], familyId: .familyWeedle, parentId: .weedle, baseAttack: 46, baseDefense: 86, baseStamina: 90, height: 0.075, weight: 1.25, nextEvolve: [.beedrill], candyToEvolve: 50, buddyDistance: 1.0),
            .beedrill: PokemonPrototype.init(pokemonId: .beedrill, pokemonType: [.pokemonTypeBug, .pokemonTypePoison], familyId: .familyWeedle, parentId: .kakuna, baseAttack: 169, baseDefense: 150, baseStamina: 130, height: 0.125, weight: 3.6875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .pidgey: PokemonPrototype.init(pokemonId: .pidgey, pokemonType: [.pokemonTypeNormal, .pokemonTypeFlying], familyId: .familyPidgey, parentId: .missingno, baseAttack: 85, baseDefense: 76, baseStamina: 80, height: 0.0375, weight: 0.225, nextEvolve: [.pidgeotto], candyToEvolve: 12, buddyDistance: 1.0),
            .pidgeotto: PokemonPrototype.init(pokemonId: .pidgeotto, pokemonType: [.pokemonTypeNormal, .pokemonTypeFlying], familyId: .familyPidgey, parentId: .pidgey, baseAttack: 117, baseDefense: 108, baseStamina: 126, height: 0.1375, weight: 3.75, nextEvolve: [.pidgeot], candyToEvolve: 50, buddyDistance: 1.0),
            .pidgeot: PokemonPrototype.init(pokemonId: .pidgeot, pokemonType: [.pokemonTypeNormal, .pokemonTypeFlying], familyId: .familyPidgey, parentId: .pidgeotto, baseAttack: 166, baseDefense: 157, baseStamina: 166, height: 0.1875, weight: 4.9375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .rattata: PokemonPrototype.init(pokemonId: .rattata, pokemonType: [.pokemonTypeNormal], familyId: .familyRattata, parentId: .missingno, baseAttack: 103, baseDefense: 70, baseStamina: 60, height: 0.0375, weight: 0.4375, nextEvolve: [.raticate], candyToEvolve: 25, buddyDistance: 1.0),
            .raticate: PokemonPrototype.init(pokemonId: .raticate, pokemonType: [.pokemonTypeNormal], familyId: .familyRattata, parentId: .rattata, baseAttack: 161, baseDefense: 144, baseStamina: 110, height: 0.0875, weight: 2.3125, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .spearow: PokemonPrototype.init(pokemonId: .spearow, pokemonType: [.pokemonTypeNormal, .pokemonTypeFlying], familyId: .familySpearow, parentId: .missingno, baseAttack: 112, baseDefense: 61, baseStamina: 80, height: 0.0375, weight: 0.25, nextEvolve: [.fearow], candyToEvolve: 50, buddyDistance: 1.0),
            .fearow: PokemonPrototype.init(pokemonId: .fearow, pokemonType: [.pokemonTypeNormal, .pokemonTypeFlying], familyId: .familySpearow, parentId: .spearow, baseAttack: 182, baseDefense: 135, baseStamina: 130, height: 0.15, weight: 4.75, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .ekans: PokemonPrototype.init(pokemonId: .ekans, pokemonType: [.pokemonTypePoison], familyId: .familyEkans, parentId: .missingno, baseAttack: 110, baseDefense: 102, baseStamina: 70, height: 0.25, weight: 0.8625, nextEvolve: [.arbok], candyToEvolve: 50, buddyDistance: 3.0),
            .arbok: PokemonPrototype.init(pokemonId: .arbok, pokemonType: [.pokemonTypePoison], familyId: .familyEkans, parentId: .ekans, baseAttack: 167, baseDefense: 158, baseStamina: 120, height: 0.4375, weight: 8.125, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .pikachu: PokemonPrototype.init(pokemonId: .pikachu, pokemonType: [.pokemonTypeElectric], familyId: .familyPikachu, parentId: .pichu, baseAttack: 112, baseDefense: 101, baseStamina: 70, height: 0.05, weight: 0.75, nextEvolve: [.raichu], candyToEvolve: 50, buddyDistance: 1.0),
            .raichu: PokemonPrototype.init(pokemonId: .raichu, pokemonType: [.pokemonTypeElectric], familyId: .familyPikachu, parentId: .pikachu, baseAttack: 193, baseDefense: 165, baseStamina: 120, height: 0.1, weight: 3.75, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .sandshrew: PokemonPrototype.init(pokemonId: .sandshrew, pokemonType: [.pokemonTypeGround], familyId: .familySandshrew, parentId: .missingno, baseAttack: 126, baseDefense: 145, baseStamina: 100, height: 0.075, weight: 1.5, nextEvolve: [.sandslash], candyToEvolve: 50, buddyDistance: 3.0),
            .sandslash: PokemonPrototype.init(pokemonId: .sandslash, pokemonType: [.pokemonTypeGround], familyId: .familySandshrew, parentId: .sandshrew, baseAttack: 182, baseDefense: 202, baseStamina: 150, height: 0.125, weight: 3.6875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .nidoranFemale: PokemonPrototype.init(pokemonId: .nidoranFemale, pokemonType: [.pokemonTypePoison], familyId: .familyNidoranFemale, parentId: .missingno, baseAttack: 86, baseDefense: 94, baseStamina: 110, height: 0.05, weight: 0.875, nextEvolve: [.nidorina], candyToEvolve: 25, buddyDistance: 3.0),
            .nidorina: PokemonPrototype.init(pokemonId: .nidorina, pokemonType: [.pokemonTypePoison], familyId: .familyNidoranFemale, parentId: .nidoranFemale, baseAttack: 117, baseDefense: 126, baseStamina: 140, height: 0.1, weight: 2.5, nextEvolve: [.nidoqueen], candyToEvolve: 100, buddyDistance: 3.0),
            .nidoqueen: PokemonPrototype.init(pokemonId: .nidoqueen, pokemonType: [.pokemonTypePoison, .pokemonTypeGround], familyId: .familyNidoranFemale, parentId: .nidorina, baseAttack: 180, baseDefense: 174, baseStamina: 180, height: 0.1625, weight: 7.5, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .nidoranMale: PokemonPrototype.init(pokemonId: .nidoranMale, pokemonType: [.pokemonTypePoison], familyId: .familyNidoranMale, parentId: .missingno, baseAttack: 105, baseDefense: 76, baseStamina: 92, height: 0.0625, weight: 1.125, nextEvolve: [.nidorino], candyToEvolve: 25, buddyDistance: 3.0),
            .nidorino: PokemonPrototype.init(pokemonId: .nidorino, pokemonType: [.pokemonTypePoison], familyId: .familyNidoranMale, parentId: .nidoranMale, baseAttack: 137, baseDefense: 112, baseStamina: 122, height: 0.1125, weight: 2.4375, nextEvolve: [.nidoking], candyToEvolve: 100, buddyDistance: 3.0),
            .nidoking: PokemonPrototype.init(pokemonId: .nidoking, pokemonType: [.pokemonTypePoison, .pokemonTypeGround], familyId: .familyNidoranMale, parentId: .nidorino, baseAttack: 204, baseDefense: 157, baseStamina: 162, height: 0.175, weight: 7.75, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .clefairy: PokemonPrototype.init(pokemonId: .clefairy, pokemonType: [.pokemonTypeFairy], familyId: .familyClefairy, parentId: .cleffa, baseAttack: 107, baseDefense: 116, baseStamina: 140, height: 0.075, weight: 0.9375, nextEvolve: [.clefable], candyToEvolve: 50, buddyDistance: 1.0),
            .clefable: PokemonPrototype.init(pokemonId: .clefable, pokemonType: [.pokemonTypeFairy], familyId: .familyClefairy, parentId: .clefairy, baseAttack: 178, baseDefense: 171, baseStamina: 190, height: 0.1625, weight: 5.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .vulpix: PokemonPrototype.init(pokemonId: .vulpix, pokemonType: [.pokemonTypeFire], familyId: .familyVulpix, parentId: .missingno, baseAttack: 96, baseDefense: 122, baseStamina: 76, height: 0.075, weight: 1.2375, nextEvolve: [.ninetales], candyToEvolve: 50, buddyDistance: 3.0),
            .ninetales: PokemonPrototype.init(pokemonId: .ninetales, pokemonType: [.pokemonTypeFire], familyId: .familyVulpix, parentId: .vulpix, baseAttack: 169, baseDefense: 204, baseStamina: 146, height: 0.1375, weight: 2.4875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .jigglypuff: PokemonPrototype.init(pokemonId: .jigglypuff, pokemonType: [.pokemonTypeNormal, .pokemonTypeFairy], familyId: .familyJigglypuff, parentId: .igglybuff, baseAttack: 80, baseDefense: 44, baseStamina: 230, height: 0.0625, weight: 0.6875, nextEvolve: [.wigglytuff], candyToEvolve: 50, buddyDistance: 1.0),
            .wigglytuff: PokemonPrototype.init(pokemonId: .wigglytuff, pokemonType: [.pokemonTypeNormal, .pokemonTypeFairy], familyId: .familyJigglypuff, parentId: .jigglypuff, baseAttack: 156, baseDefense: 93, baseStamina: 280, height: 0.125, weight: 1.5, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .zubat: PokemonPrototype.init(pokemonId: .zubat, pokemonType: [.pokemonTypePoison, .pokemonTypeFlying], familyId: .familyZubat, parentId: .missingno, baseAttack: 83, baseDefense: 76, baseStamina: 80, height: 0.1, weight: 0.9375, nextEvolve: [.golbat], candyToEvolve: 50, buddyDistance: 1.0),
            .golbat: PokemonPrototype.init(pokemonId: .golbat, pokemonType: [.pokemonTypePoison, .pokemonTypeFlying], familyId: .familyZubat, parentId: .zubat, baseAttack: 161, baseDefense: 153, baseStamina: 150, height: 0.2, weight: 6.875, nextEvolve: [.crobat], candyToEvolve: 0, buddyDistance: 1.0),
            .oddish: PokemonPrototype.init(pokemonId: .oddish, pokemonType: [.pokemonTypeGrass, .pokemonTypePoison], familyId: .familyOddish, parentId: .missingno, baseAttack: 131, baseDefense: 116, baseStamina: 90, height: 0.0625, weight: 0.675, nextEvolve: [.gloom], candyToEvolve: 25, buddyDistance: 3.0),
            .gloom: PokemonPrototype.init(pokemonId: .gloom, pokemonType: [.pokemonTypeGrass, .pokemonTypePoison], familyId: .familyOddish, parentId: .oddish, baseAttack: 153, baseDefense: 139, baseStamina: 120, height: 0.1, weight: 1.075, nextEvolve: [.vileplume, .bellossom], candyToEvolve: 100, buddyDistance: 3.0),
            .vileplume: PokemonPrototype.init(pokemonId: .vileplume, pokemonType: [.pokemonTypeGrass, .pokemonTypePoison], familyId: .familyOddish, parentId: .gloom, baseAttack: 202, baseDefense: 170, baseStamina: 150, height: 0.15, weight: 2.325, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .paras: PokemonPrototype.init(pokemonId: .paras, pokemonType: [.pokemonTypeBug, .pokemonTypeGrass], familyId: .familyParas, parentId: .missingno, baseAttack: 121, baseDefense: 99, baseStamina: 70, height: 0.0375, weight: 0.675, nextEvolve: [.parasect], candyToEvolve: 50, buddyDistance: 3.0),
            .parasect: PokemonPrototype.init(pokemonId: .parasect, pokemonType: [.pokemonTypeBug, .pokemonTypeGrass], familyId: .familyParas, parentId: .paras, baseAttack: 165, baseDefense: 146, baseStamina: 120, height: 0.125, weight: 3.6875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .venonat: PokemonPrototype.init(pokemonId: .venonat, pokemonType: [.pokemonTypeBug, .pokemonTypePoison], familyId: .familyVenonat, parentId: .missingno, baseAttack: 100, baseDefense: 102, baseStamina: 120, height: 0.125, weight: 3.75, nextEvolve: [.venomoth], candyToEvolve: 50, buddyDistance: 3.0),
            .venomoth: PokemonPrototype.init(pokemonId: .venomoth, pokemonType: [.pokemonTypeBug, .pokemonTypePoison], familyId: .familyVenonat, parentId: .venonat, baseAttack: 179, baseDefense: 150, baseStamina: 140, height: 0.1875, weight: 1.5625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .diglett: PokemonPrototype.init(pokemonId: .diglett, pokemonType: [.pokemonTypeGround], familyId: .familyDiglett, parentId: .missingno, baseAttack: 109, baseDefense: 88, baseStamina: 20, height: 0.025, weight: 0.1, nextEvolve: [.dugtrio], candyToEvolve: 50, buddyDistance: 3.0),
            .dugtrio: PokemonPrototype.init(pokemonId: .dugtrio, pokemonType: [.pokemonTypeGround], familyId: .familyDiglett, parentId: .diglett, baseAttack: 167, baseDefense: 147, baseStamina: 70, height: 0.0875, weight: 4.1625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .meowth: PokemonPrototype.init(pokemonId: .meowth, pokemonType: [.pokemonTypeNormal], familyId: .familyMeowth, parentId: .missingno, baseAttack: 92, baseDefense: 81, baseStamina: 80, height: 0.05, weight: 0.525, nextEvolve: [.persian], candyToEvolve: 50, buddyDistance: 3.0),
            .persian: PokemonPrototype.init(pokemonId: .persian, pokemonType: [.pokemonTypeNormal], familyId: .familyMeowth, parentId: .meowth, baseAttack: 150, baseDefense: 139, baseStamina: 130, height: 0.125, weight: 4.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .psyduck: PokemonPrototype.init(pokemonId: .psyduck, pokemonType: [.pokemonTypeWater], familyId: .familyPsyduck, parentId: .missingno, baseAttack: 122, baseDefense: 96, baseStamina: 100, height: 0.1, weight: 2.45, nextEvolve: [.golduck], candyToEvolve: 50, buddyDistance: 3.0),
            .golduck: PokemonPrototype.init(pokemonId: .golduck, pokemonType: [.pokemonTypeWater], familyId: .familyPsyduck, parentId: .psyduck, baseAttack: 191, baseDefense: 163, baseStamina: 160, height: 0.2125, weight: 9.575, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .mankey: PokemonPrototype.init(pokemonId: .mankey, pokemonType: [.pokemonTypeFighting], familyId: .familyMankey, parentId: .missingno, baseAttack: 148, baseDefense: 87, baseStamina: 80, height: 0.0625, weight: 3.5, nextEvolve: [.primeape], candyToEvolve: 50, buddyDistance: 3.0),
            .primeape: PokemonPrototype.init(pokemonId: .primeape, pokemonType: [.pokemonTypeFighting], familyId: .familyMankey, parentId: .mankey, baseAttack: 207, baseDefense: 144, baseStamina: 130, height: 0.125, weight: 4.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .growlithe: PokemonPrototype.init(pokemonId: .growlithe, pokemonType: [.pokemonTypeFire], familyId: .familyGrowlithe, parentId: .missingno, baseAttack: 136, baseDefense: 96, baseStamina: 110, height: 0.0875, weight: 2.375, nextEvolve: [.arcanine], candyToEvolve: 50, buddyDistance: 3.0),
            .arcanine: PokemonPrototype.init(pokemonId: .arcanine, pokemonType: [.pokemonTypeFire], familyId: .familyGrowlithe, parentId: .growlithe, baseAttack: 227, baseDefense: 166, baseStamina: 180, height: 0.2375, weight: 19.375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .poliwag: PokemonPrototype.init(pokemonId: .poliwag, pokemonType: [.pokemonTypeWater], familyId: .familyPoliwag, parentId: .missingno, baseAttack: 101, baseDefense: 82, baseStamina: 80, height: 0.075, weight: 1.55, nextEvolve: [.poliwhirl], candyToEvolve: 25, buddyDistance: 3.0),
            .poliwhirl: PokemonPrototype.init(pokemonId: .poliwhirl, pokemonType: [.pokemonTypeWater], familyId: .familyPoliwag, parentId: .poliwag, baseAttack: 130, baseDefense: 130, baseStamina: 130, height: 0.125, weight: 2.5, nextEvolve: [.poliwrath, .politoed], candyToEvolve: 100, buddyDistance: 3.0),
            .poliwrath: PokemonPrototype.init(pokemonId: .poliwrath, pokemonType: [.pokemonTypeWater, .pokemonTypeFighting], familyId: .familyPoliwag, parentId: .poliwhirl, baseAttack: 182, baseDefense: 187, baseStamina: 180, height: 0.1625, weight: 6.75, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .abra: PokemonPrototype.init(pokemonId: .abra, pokemonType: [.pokemonTypePsychic], familyId: .familyAbra, parentId: .missingno, baseAttack: 195, baseDefense: 103, baseStamina: 50, height: 0.1125, weight: 2.4375, nextEvolve: [.kadabra], candyToEvolve: 25, buddyDistance: 3.0),
            .kadabra: PokemonPrototype.init(pokemonId: .kadabra, pokemonType: [.pokemonTypePsychic], familyId: .familyAbra, parentId: .abra, baseAttack: 232, baseDefense: 138, baseStamina: 80, height: 0.1625, weight: 7.0625, nextEvolve: [.alakazam], candyToEvolve: 100, buddyDistance: 3.0),
            .alakazam: PokemonPrototype.init(pokemonId: .alakazam, pokemonType: [.pokemonTypePsychic], familyId: .familyAbra, parentId: .kadabra, baseAttack: 271, baseDefense: 194, baseStamina: 110, height: 0.1875, weight: 6.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .machop: PokemonPrototype.init(pokemonId: .machop, pokemonType: [.pokemonTypeFighting], familyId: .familyMachop, parentId: .missingno, baseAttack: 137, baseDefense: 88, baseStamina: 140, height: 0.1, weight: 2.4375, nextEvolve: [.machoke], candyToEvolve: 25, buddyDistance: 3.0),
            .machoke: PokemonPrototype.init(pokemonId: .machoke, pokemonType: [.pokemonTypeFighting], familyId: .familyMachop, parentId: .machop, baseAttack: 177, baseDefense: 130, baseStamina: 160, height: 0.1875, weight: 8.8125, nextEvolve: [.machamp], candyToEvolve: 100, buddyDistance: 3.0),
            .machamp: PokemonPrototype.init(pokemonId: .machamp, pokemonType: [.pokemonTypeFighting], familyId: .familyMachop, parentId: .machoke, baseAttack: 234, baseDefense: 162, baseStamina: 180, height: 0.2, weight: 16.25, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .bellsprout: PokemonPrototype.init(pokemonId: .bellsprout, pokemonType: [.pokemonTypeGrass, .pokemonTypePoison], familyId: .familyBellsprout, parentId: .missingno, baseAttack: 139, baseDefense: 64, baseStamina: 100, height: 0.0875, weight: 0.5, nextEvolve: [.weepinbell], candyToEvolve: 25, buddyDistance: 3.0),
            .weepinbell: PokemonPrototype.init(pokemonId: .weepinbell, pokemonType: [.pokemonTypeGrass, .pokemonTypePoison], familyId: .familyBellsprout, parentId: .bellsprout, baseAttack: 172, baseDefense: 95, baseStamina: 130, height: 0.125, weight: 0.8, nextEvolve: [.victreebel], candyToEvolve: 100, buddyDistance: 3.0),
            .victreebel: PokemonPrototype.init(pokemonId: .victreebel, pokemonType: [.pokemonTypeGrass, .pokemonTypePoison], familyId: .familyBellsprout, parentId: .weepinbell, baseAttack: 207, baseDefense: 138, baseStamina: 160, height: 0.2125, weight: 1.9375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .tentacool: PokemonPrototype.init(pokemonId: .tentacool, pokemonType: [.pokemonTypeWater, .pokemonTypePoison], familyId: .familyTentacool, parentId: .missingno, baseAttack: 97, baseDefense: 182, baseStamina: 80, height: 0.1125, weight: 5.6875, nextEvolve: [.tentacruel], candyToEvolve: 50, buddyDistance: 3.0),
            .tentacruel: PokemonPrototype.init(pokemonId: .tentacruel, pokemonType: [.pokemonTypeWater, .pokemonTypePoison], familyId: .familyTentacool, parentId: .tentacool, baseAttack: 166, baseDefense: 237, baseStamina: 160, height: 0.2, weight: 6.875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .geodude: PokemonPrototype.init(pokemonId: .geodude, pokemonType: [.pokemonTypeRock, .pokemonTypeGround], familyId: .familyGeodude, parentId: .missingno, baseAttack: 132, baseDefense: 163, baseStamina: 80, height: 0.05, weight: 2.5, nextEvolve: [.graveler], candyToEvolve: 25, buddyDistance: 1.0),
            .graveler: PokemonPrototype.init(pokemonId: .graveler, pokemonType: [.pokemonTypeRock, .pokemonTypeGround], familyId: .familyGeodude, parentId: .geodude, baseAttack: 164, baseDefense: 196, baseStamina: 110, height: 0.125, weight: 13.125, nextEvolve: [.golem], candyToEvolve: 100, buddyDistance: 1.0),
            .golem: PokemonPrototype.init(pokemonId: .golem, pokemonType: [.pokemonTypeRock, .pokemonTypeGround], familyId: .familyGeodude, parentId: .graveler, baseAttack: 211, baseDefense: 229, baseStamina: 160, height: 0.175, weight: 37.5, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .ponyta: PokemonPrototype.init(pokemonId: .ponyta, pokemonType: [.pokemonTypeFire], familyId: .familyPonyta, parentId: .missingno, baseAttack: 170, baseDefense: 132, baseStamina: 100, height: 0.125, weight: 3.75, nextEvolve: [.rapidash], candyToEvolve: 50, buddyDistance: 3.0),
            .rapidash: PokemonPrototype.init(pokemonId: .rapidash, pokemonType: [.pokemonTypeFire], familyId: .familyPonyta, parentId: .ponyta, baseAttack: 207, baseDefense: 167, baseStamina: 130, height: 0.2125, weight: 11.875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .slowpoke: PokemonPrototype.init(pokemonId: .slowpoke, pokemonType: [.pokemonTypeWater, .pokemonTypePsychic], familyId: .familySlowpoke, parentId: .missingno, baseAttack: 109, baseDefense: 109, baseStamina: 180, height: 0.15, weight: 4.5, nextEvolve: [.slowbro, .slowking], candyToEvolve: 50, buddyDistance: 3.0),
            .slowbro: PokemonPrototype.init(pokemonId: .slowbro, pokemonType: [.pokemonTypeWater, .pokemonTypePsychic], familyId: .familySlowpoke, parentId: .slowpoke, baseAttack: 177, baseDefense: 194, baseStamina: 190, height: 0.2, weight: 9.8125, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .magnemite: PokemonPrototype.init(pokemonId: .magnemite, pokemonType: [.pokemonTypeElectric, .pokemonTypeSteel], familyId: .familyMagnemite, parentId: .missingno, baseAttack: 165, baseDefense: 128, baseStamina: 50, height: 0.0375, weight: 0.75, nextEvolve: [.magneton], candyToEvolve: 50, buddyDistance: 3.0),
            .magneton: PokemonPrototype.init(pokemonId: .magneton, pokemonType: [.pokemonTypeElectric, .pokemonTypeSteel], familyId: .familyMagnemite, parentId: .magnemite, baseAttack: 223, baseDefense: 182, baseStamina: 100, height: 0.125, weight: 7.5, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .farfetchd: PokemonPrototype.init(pokemonId: .farfetchd, pokemonType: [.pokemonTypeNormal, .pokemonTypeFlying], familyId: .familyFarfetchd, parentId: .missingno, baseAttack: 124, baseDefense: 118, baseStamina: 104, height: 0.1, weight: 1.875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .doduo: PokemonPrototype.init(pokemonId: .doduo, pokemonType: [.pokemonTypeNormal, .pokemonTypeFlying], familyId: .familyDoduo, parentId: .missingno, baseAttack: 158, baseDefense: 88, baseStamina: 70, height: 0.175, weight: 4.9, nextEvolve: [.dodrio], candyToEvolve: 50, buddyDistance: 3.0),
            .dodrio: PokemonPrototype.init(pokemonId: .dodrio, pokemonType: [.pokemonTypeNormal, .pokemonTypeFlying], familyId: .familyDoduo, parentId: .doduo, baseAttack: 218, baseDefense: 145, baseStamina: 120, height: 0.225, weight: 10.65, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .seel: PokemonPrototype.init(pokemonId: .seel, pokemonType: [.pokemonTypeWater], familyId: .familySeel, parentId: .missingno, baseAttack: 85, baseDefense: 128, baseStamina: 130, height: 0.1375, weight: 11.25, nextEvolve: [.dewgong], candyToEvolve: 50, buddyDistance: 3.0),
            .dewgong: PokemonPrototype.init(pokemonId: .dewgong, pokemonType: [.pokemonTypeWater, .pokemonTypeIce], familyId: .familySeel, parentId: .seel, baseAttack: 139, baseDefense: 184, baseStamina: 180, height: 0.2125, weight: 15.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .grimer: PokemonPrototype.init(pokemonId: .grimer, pokemonType: [.pokemonTypePoison], familyId: .familyGrimer, parentId: .missingno, baseAttack: 135, baseDefense: 90, baseStamina: 160, height: 0.1125, weight: 3.75, nextEvolve: [.muk], candyToEvolve: 50, buddyDistance: 3.0),
            .muk: PokemonPrototype.init(pokemonId: .muk, pokemonType: [.pokemonTypePoison], familyId: .familyGrimer, parentId: .grimer, baseAttack: 190, baseDefense: 184, baseStamina: 210, height: 0.15, weight: 3.75, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .shellder: PokemonPrototype.init(pokemonId: .shellder, pokemonType: [.pokemonTypeWater], familyId: .familyShellder, parentId: .missingno, baseAttack: 116, baseDefense: 168, baseStamina: 60, height: 0.0375, weight: 0.5, nextEvolve: [.cloyster], candyToEvolve: 50, buddyDistance: 3.0),
            .cloyster: PokemonPrototype.init(pokemonId: .cloyster, pokemonType: [.pokemonTypeWater, .pokemonTypeIce], familyId: .familyShellder, parentId: .shellder, baseAttack: 186, baseDefense: 323, baseStamina: 100, height: 0.1875, weight: 16.5625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .gastly: PokemonPrototype.init(pokemonId: .gastly, pokemonType: [.pokemonTypeGhost, .pokemonTypePoison], familyId: .familyGastly, parentId: .missingno, baseAttack: 186, baseDefense: 70, baseStamina: 60, height: 0.1625, weight: 0.0125, nextEvolve: [.haunter], candyToEvolve: 25, buddyDistance: 3.0),
            .haunter: PokemonPrototype.init(pokemonId: .haunter, pokemonType: [.pokemonTypeGhost, .pokemonTypePoison], familyId: .familyGastly, parentId: .gastly, baseAttack: 223, baseDefense: 112, baseStamina: 90, height: 0.2, weight: 0.0125, nextEvolve: [.gengar], candyToEvolve: 100, buddyDistance: 3.0),
            .gengar: PokemonPrototype.init(pokemonId: .gengar, pokemonType: [.pokemonTypeGhost, .pokemonTypePoison], familyId: .familyGastly, parentId: .haunter, baseAttack: 261, baseDefense: 156, baseStamina: 120, height: 0.1875, weight: 5.0625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .onix: PokemonPrototype.init(pokemonId: .onix, pokemonType: [.pokemonTypeRock, .pokemonTypeGround], familyId: .familyOnix, parentId: .missingno, baseAttack: 85, baseDefense: 288, baseStamina: 70, height: 1.1, weight: 26.25, nextEvolve: [.steelix], candyToEvolve: 0, buddyDistance: 5.0),
            .drowzee: PokemonPrototype.init(pokemonId: .drowzee, pokemonType: [.pokemonTypePsychic], familyId: .familyDrowzee, parentId: .missingno, baseAttack: 89, baseDefense: 158, baseStamina: 120, height: 0.125, weight: 4.05, nextEvolve: [.hypno], candyToEvolve: 50, buddyDistance: 3.0),
            .hypno: PokemonPrototype.init(pokemonId: .hypno, pokemonType: [.pokemonTypePsychic], familyId: .familyDrowzee, parentId: .drowzee, baseAttack: 144, baseDefense: 215, baseStamina: 170, height: 0.2, weight: 9.45, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .krabby: PokemonPrototype.init(pokemonId: .krabby, pokemonType: [.pokemonTypeWater], familyId: .familyKrabby, parentId: .missingno, baseAttack: 181, baseDefense: 156, baseStamina: 60, height: 0.05, weight: 0.8125, nextEvolve: [.kingler], candyToEvolve: 50, buddyDistance: 3.0),
            .kingler: PokemonPrototype.init(pokemonId: .kingler, pokemonType: [.pokemonTypeWater], familyId: .familyKrabby, parentId: .krabby, baseAttack: 240, baseDefense: 214, baseStamina: 110, height: 0.1625, weight: 7.5, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .voltorb: PokemonPrototype.init(pokemonId: .voltorb, pokemonType: [.pokemonTypeElectric], familyId: .familyVoltorb, parentId: .missingno, baseAttack: 109, baseDefense: 114, baseStamina: 80, height: 0.0625, weight: 1.3, nextEvolve: [.electrode], candyToEvolve: 50, buddyDistance: 3.0),
            .electrode: PokemonPrototype.init(pokemonId: .electrode, pokemonType: [.pokemonTypeElectric], familyId: .familyVoltorb, parentId: .voltorb, baseAttack: 173, baseDefense: 179, baseStamina: 120, height: 0.15, weight: 8.325, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .exeggcute: PokemonPrototype.init(pokemonId: .exeggcute, pokemonType: [.pokemonTypeGrass, .pokemonTypePsychic], familyId: .familyExeggcute, parentId: .missingno, baseAttack: 107, baseDefense: 140, baseStamina: 120, height: 0.05, weight: 0.3125, nextEvolve: [.exeggutor], candyToEvolve: 50, buddyDistance: 3.0),
            .exeggutor: PokemonPrototype.init(pokemonId: .exeggutor, pokemonType: [.pokemonTypeGrass, .pokemonTypePsychic], familyId: .familyExeggcute, parentId: .exeggcute, baseAttack: 233, baseDefense: 158, baseStamina: 190, height: 0.25, weight: 15.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .cubone: PokemonPrototype.init(pokemonId: .cubone, pokemonType: [.pokemonTypeGround], familyId: .familyCubone, parentId: .missingno, baseAttack: 90, baseDefense: 165, baseStamina: 100, height: 0.05, weight: 0.8125, nextEvolve: [.marowak], candyToEvolve: 50, buddyDistance: 3.0),
            .marowak: PokemonPrototype.init(pokemonId: .marowak, pokemonType: [.pokemonTypeGround], familyId: .familyCubone, parentId: .cubone, baseAttack: 144, baseDefense: 200, baseStamina: 120, height: 0.125, weight: 5.625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .hitmonlee: PokemonPrototype.init(pokemonId: .hitmonlee, pokemonType: [.pokemonTypeFighting], familyId: .familyTyrogue, parentId: .missingno, baseAttack: 224, baseDefense: 211, baseStamina: 100, height: 0.1875, weight: 6.225, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .hitmonchan: PokemonPrototype.init(pokemonId: .hitmonchan, pokemonType: [.pokemonTypeFighting], familyId: .familyTyrogue, parentId: .missingno, baseAttack: 193, baseDefense: 212, baseStamina: 100, height: 0.175, weight: 6.275, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .lickitung: PokemonPrototype.init(pokemonId: .lickitung, pokemonType: [.pokemonTypeNormal], familyId: .familyLickitung, parentId: .missingno, baseAttack: 108, baseDefense: 137, baseStamina: 180, height: 0.15, weight: 8.1875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .koffing: PokemonPrototype.init(pokemonId: .koffing, pokemonType: [.pokemonTypePoison], familyId: .familyKoffing, parentId: .missingno, baseAttack: 119, baseDefense: 164, baseStamina: 80, height: 0.075, weight: 0.125, nextEvolve: [.weezing], candyToEvolve: 50, buddyDistance: 3.0),
            .weezing: PokemonPrototype.init(pokemonId: .weezing, pokemonType: [.pokemonTypePoison], familyId: .familyKoffing, parentId: .koffing, baseAttack: 174, baseDefense: 221, baseStamina: 130, height: 0.15, weight: 1.1875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .rhyhorn: PokemonPrototype.init(pokemonId: .rhyhorn, pokemonType: [.pokemonTypeGround, .pokemonTypeRock], familyId: .familyRhyhorn, parentId: .missingno, baseAttack: 140, baseDefense: 157, baseStamina: 160, height: 0.125, weight: 14.375, nextEvolve: [.rhydon], candyToEvolve: 50, buddyDistance: 3.0),
            .rhydon: PokemonPrototype.init(pokemonId: .rhydon, pokemonType: [.pokemonTypeGround, .pokemonTypeRock], familyId: .familyRhyhorn, parentId: .rhyhorn, baseAttack: 222, baseDefense: 206, baseStamina: 210, height: 0.2375, weight: 15.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .chansey: PokemonPrototype.init(pokemonId: .chansey, pokemonType: [.pokemonTypeNormal], familyId: .familyChansey, parentId: .missingno, baseAttack: 60, baseDefense: 176, baseStamina: 500, height: 0.1375, weight: 4.325, nextEvolve: [.blissey], candyToEvolve: 0, buddyDistance: 5.0),
            .tangela: PokemonPrototype.init(pokemonId: .tangela, pokemonType: [.pokemonTypeGrass], familyId: .familyTangela, parentId: .missingno, baseAttack: 183, baseDefense: 205, baseStamina: 130, height: 0.125, weight: 4.375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .kangaskhan: PokemonPrototype.init(pokemonId: .kangaskhan, pokemonType: [.pokemonTypeNormal], familyId: .familyKangaskhan, parentId: .missingno, baseAttack: 181, baseDefense: 165, baseStamina: 210, height: 0.275, weight: 10.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .horsea: PokemonPrototype.init(pokemonId: .horsea, pokemonType: [.pokemonTypeWater], familyId: .familyHorsea, parentId: .missingno, baseAttack: 129, baseDefense: 125, baseStamina: 60, height: 0.05, weight: 1.0, nextEvolve: [.seadra], candyToEvolve: 50, buddyDistance: 3.0),
            .seadra: PokemonPrototype.init(pokemonId: .seadra, pokemonType: [.pokemonTypeWater], familyId: .familyHorsea, parentId: .horsea, baseAttack: 187, baseDefense: 182, baseStamina: 110, height: 0.15, weight: 3.125, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .goldeen: PokemonPrototype.init(pokemonId: .goldeen, pokemonType: [.pokemonTypeWater], familyId: .familyGoldeen, parentId: .missingno, baseAttack: 123, baseDefense: 115, baseStamina: 90, height: 0.075, weight: 1.875, nextEvolve: [.seaking], candyToEvolve: 50, buddyDistance: 3.0),
            .seaking: PokemonPrototype.init(pokemonId: .seaking, pokemonType: [.pokemonTypeWater], familyId: .familyGoldeen, parentId: .goldeen, baseAttack: 175, baseDefense: 154, baseStamina: 160, height: 0.1625, weight: 4.875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .staryu: PokemonPrototype.init(pokemonId: .staryu, pokemonType: [.pokemonTypeWater], familyId: .familyStaryu, parentId: .missingno, baseAttack: 137, baseDefense: 112, baseStamina: 60, height: 0.1, weight: 4.3125, nextEvolve: [.starmie], candyToEvolve: 50, buddyDistance: 3.0),
            .starmie: PokemonPrototype.init(pokemonId: .starmie, pokemonType: [.pokemonTypeWater, .pokemonTypePsychic], familyId: .familyStaryu, parentId: .staryu, baseAttack: 210, baseDefense: 184, baseStamina: 120, height: 0.1375, weight: 10.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .mrMime: PokemonPrototype.init(pokemonId: .mrMime, pokemonType: [.pokemonTypePsychic, .pokemonTypeFairy], familyId: .familyMrMime, parentId: .missingno, baseAttack: 192, baseDefense: 233, baseStamina: 80, height: 0.1625, weight: 6.8125, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .scyther: PokemonPrototype.init(pokemonId: .scyther, pokemonType: [.pokemonTypeBug, .pokemonTypeFlying], familyId: .familyScyther, parentId: .missingno, baseAttack: 218, baseDefense: 170, baseStamina: 140, height: 0.1875, weight: 7.0, nextEvolve: [.scizor], candyToEvolve: 0, buddyDistance: 5.0),
            .jynx: PokemonPrototype.init(pokemonId: .jynx, pokemonType: [.pokemonTypeIce, .pokemonTypePsychic], familyId: .familyJynx, parentId: .smoochum, baseAttack: 223, baseDefense: 182, baseStamina: 130, height: 0.175, weight: 5.075, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .electabuzz: PokemonPrototype.init(pokemonId: .electabuzz, pokemonType: [.pokemonTypeElectric], familyId: .familyElectabuzz, parentId: .elekid, baseAttack: 198, baseDefense: 173, baseStamina: 130, height: 0.1375, weight: 3.75, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .magmar: PokemonPrototype.init(pokemonId: .magmar, pokemonType: [.pokemonTypeFire], familyId: .familyMagmar, parentId: .magby, baseAttack: 206, baseDefense: 169, baseStamina: 130, height: 0.1625, weight: 5.5625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .pinsir: PokemonPrototype.init(pokemonId: .pinsir, pokemonType: [.pokemonTypeBug], familyId: .familyPinsir, parentId: .missingno, baseAttack: 238, baseDefense: 197, baseStamina: 130, height: 0.1875, weight: 6.875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .tauros: PokemonPrototype.init(pokemonId: .tauros, pokemonType: [.pokemonTypeNormal], familyId: .familyTauros, parentId: .missingno, baseAttack: 198, baseDefense: 197, baseStamina: 150, height: 0.175, weight: 11.05, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .magikarp: PokemonPrototype.init(pokemonId: .magikarp, pokemonType: [.pokemonTypeWater], familyId: .familyMagikarp, parentId: .missingno, baseAttack: 29, baseDefense: 102, baseStamina: 40, height: 0.1125, weight: 1.25, nextEvolve: [.gyarados], candyToEvolve: 400, buddyDistance: 1.0),
            .gyarados: PokemonPrototype.init(pokemonId: .gyarados, pokemonType: [.pokemonTypeWater, .pokemonTypeFlying], familyId: .familyMagikarp, parentId: .magikarp, baseAttack: 237, baseDefense: 197, baseStamina: 190, height: 0.8125, weight: 29.375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .lapras: PokemonPrototype.init(pokemonId: .lapras, pokemonType: [.pokemonTypeWater, .pokemonTypeIce], familyId: .familyLapras, parentId: .missingno, baseAttack: 165, baseDefense: 180, baseStamina: 260, height: 0.3125, weight: 27.5, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .ditto: PokemonPrototype.init(pokemonId: .ditto, pokemonType: [.pokemonTypeNormal], familyId: .familyDitto, parentId: .missingno, baseAttack: 91, baseDefense: 91, baseStamina: 96, height: 0.0375, weight: 0.5, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .eevee: PokemonPrototype.init(pokemonId: .eevee, pokemonType: [.pokemonTypeNormal], familyId: .familyEevee, parentId: .missingno, baseAttack: 104, baseDefense: 121, baseStamina: 110, height: 0.0375, weight: 0.8125, nextEvolve: [.vaporeon, .jolteon, .flareon, .espeon, .umbreon], candyToEvolve: 25, buddyDistance: 5.0),
            .vaporeon: PokemonPrototype.init(pokemonId: .vaporeon, pokemonType: [.pokemonTypeWater], familyId: .familyEevee, parentId: .eevee, baseAttack: 205, baseDefense: 177, baseStamina: 260, height: 0.125, weight: 3.625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .jolteon: PokemonPrototype.init(pokemonId: .jolteon, pokemonType: [.pokemonTypeElectric], familyId: .familyEevee, parentId: .eevee, baseAttack: 232, baseDefense: 201, baseStamina: 130, height: 0.1, weight: 3.0625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .flareon: PokemonPrototype.init(pokemonId: .flareon, pokemonType: [.pokemonTypeFire], familyId: .familyEevee, parentId: .eevee, baseAttack: 246, baseDefense: 204, baseStamina: 130, height: 0.1125, weight: 3.125, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .porygon: PokemonPrototype.init(pokemonId: .porygon, pokemonType: [.pokemonTypeNormal], familyId: .familyPorygon, parentId: .missingno, baseAttack: 153, baseDefense: 139, baseStamina: 130, height: 0.1, weight: 4.5625, nextEvolve: [.porygon2], candyToEvolve: 0, buddyDistance: 3.0),
            .omanyte: PokemonPrototype.init(pokemonId: .omanyte, pokemonType: [.pokemonTypeRock, .pokemonTypeWater], familyId: .familyOmanyte, parentId: .missingno, baseAttack: 155, baseDefense: 174, baseStamina: 70, height: 0.05, weight: 0.9375, nextEvolve: [.omastar], candyToEvolve: 50, buddyDistance: 5.0),
            .omastar: PokemonPrototype.init(pokemonId: .omastar, pokemonType: [.pokemonTypeRock, .pokemonTypeWater], familyId: .familyOmanyte, parentId: .omanyte, baseAttack: 207, baseDefense: 227, baseStamina: 140, height: 0.125, weight: 4.375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .kabuto: PokemonPrototype.init(pokemonId: .kabuto, pokemonType: [.pokemonTypeRock, .pokemonTypeWater], familyId: .familyKabuto, parentId: .missingno, baseAttack: 148, baseDefense: 162, baseStamina: 60, height: 0.0625, weight: 1.4375, nextEvolve: [.kabutops], candyToEvolve: 50, buddyDistance: 5.0),
            .kabutops: PokemonPrototype.init(pokemonId: .kabutops, pokemonType: [.pokemonTypeRock, .pokemonTypeWater], familyId: .familyKabuto, parentId: .kabuto, baseAttack: 220, baseDefense: 203, baseStamina: 120, height: 0.1625, weight: 5.0625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .aerodactyl: PokemonPrototype.init(pokemonId: .aerodactyl, pokemonType: [.pokemonTypeRock, .pokemonTypeFlying], familyId: .familyAerodactyl, parentId: .missingno, baseAttack: 221, baseDefense: 164, baseStamina: 160, height: 0.225, weight: 7.375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .snorlax: PokemonPrototype.init(pokemonId: .snorlax, pokemonType: [.pokemonTypeNormal], familyId: .familySnorlax, parentId: .missingno, baseAttack: 190, baseDefense: 190, baseStamina: 320, height: 0.2625, weight: 57.5, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .articuno: PokemonPrototype.init(pokemonId: .articuno, pokemonType: [.pokemonTypeIce, .pokemonTypeFlying], familyId: .familyArticuno, parentId: .missingno, baseAttack: 192, baseDefense: 249, baseStamina: 180, height: 0.2125, weight: 6.925, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .zapdos: PokemonPrototype.init(pokemonId: .zapdos, pokemonType: [.pokemonTypeElectric, .pokemonTypeFlying], familyId: .familyZapdos, parentId: .missingno, baseAttack: 253, baseDefense: 188, baseStamina: 180, height: 0.2, weight: 6.575, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .moltres: PokemonPrototype.init(pokemonId: .moltres, pokemonType: [.pokemonTypeFire, .pokemonTypeFlying], familyId: .familyMoltres, parentId: .missingno, baseAttack: 251, baseDefense: 184, baseStamina: 180, height: 0.25, weight: 7.5, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .dratini: PokemonPrototype.init(pokemonId: .dratini, pokemonType: [.pokemonTypeDragon], familyId: .familyDratini, parentId: .missingno, baseAttack: 119, baseDefense: 94, baseStamina: 82, height: 0.225, weight: 0.4125, nextEvolve: [.dragonair], candyToEvolve: 25, buddyDistance: 5.0),
            .dragonair: PokemonPrototype.init(pokemonId: .dragonair, pokemonType: [.pokemonTypeDragon], familyId: .familyDratini, parentId: .dratini, baseAttack: 163, baseDefense: 138, baseStamina: 122, height: 0.5, weight: 2.0625, nextEvolve: [.dragonite], candyToEvolve: 100, buddyDistance: 5.0),
            .dragonite: PokemonPrototype.init(pokemonId: .dragonite, pokemonType: [.pokemonTypeDragon, .pokemonTypeFlying], familyId: .familyDratini, parentId: .dragonair, baseAttack: 263, baseDefense: 201, baseStamina: 182, height: 0.275, weight: 26.25, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .mewtwo: PokemonPrototype.init(pokemonId: .mewtwo, pokemonType: [.pokemonTypePsychic], familyId: .familyMewtwo, parentId: .missingno, baseAttack: 330, baseDefense: 200, baseStamina: 212, height: 0.25, weight: 15.25, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .mew: PokemonPrototype.init(pokemonId: .mew, pokemonType: [.pokemonTypePsychic], familyId: .familyMew, parentId: .missingno, baseAttack: 210, baseDefense: 210, baseStamina: 200, height: 0.05, weight: 0.5, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .chikorita: PokemonPrototype.init(pokemonId: .chikorita, pokemonType: [.pokemonTypeGrass], familyId: .familyChikorita, parentId: .missingno, baseAttack: 92, baseDefense: 122, baseStamina: 90, height: 0.11125, weight: 0.8, nextEvolve: [.bayleef], candyToEvolve: 25, buddyDistance: 3.0),
            .bayleef: PokemonPrototype.init(pokemonId: .bayleef, pokemonType: [.pokemonTypeGrass], familyId: .familyChikorita, parentId: .chikorita, baseAttack: 122, baseDefense: 155, baseStamina: 120, height: 0.14875, weight: 1.975, nextEvolve: [.meganium], candyToEvolve: 100, buddyDistance: 3.0),
            .meganium: PokemonPrototype.init(pokemonId: .meganium, pokemonType: [.pokemonTypeGrass], familyId: .familyChikorita, parentId: .bayleef, baseAttack: 168, baseDefense: 202, baseStamina: 160, height: 0.225, weight: 12.5625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .cyndaquil: PokemonPrototype.init(pokemonId: .cyndaquil, pokemonType: [.pokemonTypeFire], familyId: .familyCyndaquil, parentId: .missingno, baseAttack: 116, baseDefense: 96, baseStamina: 78, height: 0.06375, weight: 0.9875, nextEvolve: [.quilava], candyToEvolve: 25, buddyDistance: 3.0),
            .quilava: PokemonPrototype.init(pokemonId: .quilava, pokemonType: [.pokemonTypeFire], familyId: .familyCyndaquil, parentId: .cyndaquil, baseAttack: 158, baseDefense: 129, baseStamina: 116, height: 0.11125, weight: 2.375, nextEvolve: [.typhlosion], candyToEvolve: 100, buddyDistance: 3.0),
            .typhlosion: PokemonPrototype.init(pokemonId: .typhlosion, pokemonType: [.pokemonTypeFire], familyId: .familyCyndaquil, parentId: .quilava, baseAttack: 223, baseDefense: 176, baseStamina: 156, height: 0.2125, weight: 9.9375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .totodile: PokemonPrototype.init(pokemonId: .totodile, pokemonType: [.pokemonTypeWater], familyId: .familyTotodile, parentId: .missingno, baseAttack: 117, baseDefense: 116, baseStamina: 100, height: 0.07625, weight: 1.1875, nextEvolve: [.croconaw], candyToEvolve: 25, buddyDistance: 3.0),
            .croconaw: PokemonPrototype.init(pokemonId: .croconaw, pokemonType: [.pokemonTypeWater], familyId: .familyTotodile, parentId: .totodile, baseAttack: 150, baseDefense: 151, baseStamina: 130, height: 0.13625, weight: 3.125, nextEvolve: [.feraligatr], candyToEvolve: 100, buddyDistance: 3.0),
            .feraligatr: PokemonPrototype.init(pokemonId: .feraligatr, pokemonType: [.pokemonTypeWater], familyId: .familyTotodile, parentId: .croconaw, baseAttack: 205, baseDefense: 197, baseStamina: 170, height: 0.28875, weight: 11.1, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .sentret: PokemonPrototype.init(pokemonId: .sentret, pokemonType: [.pokemonTypeNormal], familyId: .familySentret, parentId: .missingno, baseAttack: 79, baseDefense: 77, baseStamina: 70, height: 0.09875, weight: 0.75, nextEvolve: [.furret], candyToEvolve: 25, buddyDistance: 1.0),
            .furret: PokemonPrototype.init(pokemonId: .furret, pokemonType: [.pokemonTypeNormal], familyId: .familySentret, parentId: .sentret, baseAttack: 148, baseDefense: 130, baseStamina: 170, height: 0.225, weight: 4.0625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .hoothoot: PokemonPrototype.init(pokemonId: .hoothoot, pokemonType: [.pokemonTypeNormal, .pokemonTypeFlying], familyId: .familyHoothoot, parentId: .missingno, baseAttack: 67, baseDefense: 101, baseStamina: 120, height: 0.08875, weight: 2.65, nextEvolve: [.noctowl], candyToEvolve: 50, buddyDistance: 1.0),
            .noctowl: PokemonPrototype.init(pokemonId: .noctowl, pokemonType: [.pokemonTypeNormal, .pokemonTypeFlying], familyId: .familyHoothoot, parentId: .hoothoot, baseAttack: 145, baseDefense: 179, baseStamina: 200, height: 0.2, weight: 5.1, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .ledyba: PokemonPrototype.init(pokemonId: .ledyba, pokemonType: [.pokemonTypeBug, .pokemonTypeFlying], familyId: .familyLedyba, parentId: .missingno, baseAttack: 72, baseDefense: 142, baseStamina: 80, height: 0.12375, weight: 1.35, nextEvolve: [.ledian], candyToEvolve: 25, buddyDistance: 1.0),
            .ledian: PokemonPrototype.init(pokemonId: .ledian, pokemonType: [.pokemonTypeBug, .pokemonTypeFlying], familyId: .familyLedyba, parentId: .ledyba, baseAttack: 107, baseDefense: 209, baseStamina: 110, height: 0.175, weight: 4.45, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .spinarak: PokemonPrototype.init(pokemonId: .spinarak, pokemonType: [.pokemonTypeBug, .pokemonTypePoison], familyId: .familySpinarak, parentId: .missingno, baseAttack: 105, baseDefense: 73, baseStamina: 80, height: 0.06375, weight: 1.0625, nextEvolve: [.ariados], candyToEvolve: 50, buddyDistance: 1.0),
            .ariados: PokemonPrototype.init(pokemonId: .ariados, pokemonType: [.pokemonTypeBug, .pokemonTypePoison], familyId: .familySpinarak, parentId: .spinarak, baseAttack: 161, baseDefense: 128, baseStamina: 140, height: 0.13625, weight: 4.1875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .crobat: PokemonPrototype.init(pokemonId: .crobat, pokemonType: [.pokemonTypePoison, .pokemonTypeFlying], familyId: .familyZubat, parentId: .golbat, baseAttack: 194, baseDefense: 178, baseStamina: 170, height: 0.225, weight: 9.375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .chinchou: PokemonPrototype.init(pokemonId: .chinchou, pokemonType: [.pokemonTypeWater, .pokemonTypeElectric], familyId: .familyChinchou, parentId: .missingno, baseAttack: 106, baseDefense: 106, baseStamina: 150, height: 0.06375, weight: 1.5, nextEvolve: [.lanturn], candyToEvolve: 50, buddyDistance: 3.0),
            .lanturn: PokemonPrototype.init(pokemonId: .lanturn, pokemonType: [.pokemonTypeWater, .pokemonTypeElectric], familyId: .familyChinchou, parentId: .chinchou, baseAttack: 146, baseDefense: 146, baseStamina: 250, height: 0.14875, weight: 2.8125, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .pichu: PokemonPrototype.init(pokemonId: .pichu, pokemonType: [.pokemonTypeElectric], familyId: .familyPikachu, parentId: .missingno, baseAttack: 77, baseDefense: 63, baseStamina: 40, height: 0.0375, weight: 0.25, nextEvolve: [.pikachu], candyToEvolve: 25, buddyDistance: 1.0),
            .cleffa: PokemonPrototype.init(pokemonId: .cleffa, pokemonType: [.pokemonTypeFairy], familyId: .familyClefairy, parentId: .missingno, baseAttack: 75, baseDefense: 91, baseStamina: 100, height: 0.0375, weight: 0.375, nextEvolve: [.clefairy], candyToEvolve: 25, buddyDistance: 1.0),
            .igglybuff: PokemonPrototype.init(pokemonId: .igglybuff, pokemonType: [.pokemonTypeNormal, .pokemonTypeFairy], familyId: .familyJigglypuff, parentId: .missingno, baseAttack: 69, baseDefense: 34, baseStamina: 180, height: 0.0375, weight: 0.125, nextEvolve: [.jigglypuff], candyToEvolve: 25, buddyDistance: 1.0),
            .togepi: PokemonPrototype.init(pokemonId: .togepi, pokemonType: [.pokemonTypeFairy], familyId: .familyTogepi, parentId: .missingno, baseAttack: 67, baseDefense: 116, baseStamina: 70, height: 0.0375, weight: 0.1875, nextEvolve: [.togetic], candyToEvolve: 50, buddyDistance: 3.0),
            .togetic: PokemonPrototype.init(pokemonId: .togetic, pokemonType: [.pokemonTypeFairy, .pokemonTypeFlying], familyId: .familyTogepi, parentId: .togepi, baseAttack: 139, baseDefense: 191, baseStamina: 110, height: 0.07625, weight: 0.4, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .natu: PokemonPrototype.init(pokemonId: .natu, pokemonType: [.pokemonTypePsychic, .pokemonTypeFlying], familyId: .familyNatu, parentId: .missingno, baseAttack: 134, baseDefense: 89, baseStamina: 80, height: 0.025, weight: 0.25, nextEvolve: [.xatu], candyToEvolve: 50, buddyDistance: 3.0),
            .xatu: PokemonPrototype.init(pokemonId: .xatu, pokemonType: [.pokemonTypePsychic, .pokemonTypeFlying], familyId: .familyNatu, parentId: .natu, baseAttack: 192, baseDefense: 146, baseStamina: 130, height: 0.1875, weight: 1.875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .mareep: PokemonPrototype.init(pokemonId: .mareep, pokemonType: [.pokemonTypeElectric], familyId: .familyMareep, parentId: .missingno, baseAttack: 114, baseDefense: 82, baseStamina: 110, height: 0.07625, weight: 0.975, nextEvolve: [.flaaffy], candyToEvolve: 25, buddyDistance: 5.0),
            .flaaffy: PokemonPrototype.init(pokemonId: .flaaffy, pokemonType: [.pokemonTypeElectric], familyId: .familyMareep, parentId: .mareep, baseAttack: 145, baseDefense: 112, baseStamina: 140, height: 0.09875, weight: 1.6625, nextEvolve: [.ampharos], candyToEvolve: 100, buddyDistance: 5.0),
            .ampharos: PokemonPrototype.init(pokemonId: .ampharos, pokemonType: [.pokemonTypeElectric], familyId: .familyMareep, parentId: .flaaffy, baseAttack: 211, baseDefense: 172, baseStamina: 180, height: 0.175, weight: 7.6875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .bellossom: PokemonPrototype.init(pokemonId: .bellossom, pokemonType: [.pokemonTypeGrass], familyId: .familyOddish, parentId: .gloom, baseAttack: 169, baseDefense: 189, baseStamina: 150, height: 0.05125, weight: 0.725, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .marill: PokemonPrototype.init(pokemonId: .marill, pokemonType: [.pokemonTypeWater, .pokemonTypeFairy], familyId: .familyMarill, parentId: .missingno, baseAttack: 37, baseDefense: 93, baseStamina: 140, height: 0.05125, weight: 1.0625, nextEvolve: [.azumarill], candyToEvolve: 25, buddyDistance: 3.0),
            .azumarill: PokemonPrototype.init(pokemonId: .azumarill, pokemonType: [.pokemonTypeWater, .pokemonTypeFairy], familyId: .familyMarill, parentId: .marill, baseAttack: 112, baseDefense: 152, baseStamina: 200, height: 0.09875, weight: 3.5625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .sudowoodo: PokemonPrototype.init(pokemonId: .sudowoodo, pokemonType: [.pokemonTypeRock], familyId: .familySudowoodo, parentId: .missingno, baseAttack: 167, baseDefense: 198, baseStamina: 140, height: 0.14875, weight: 4.75, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .politoed: PokemonPrototype.init(pokemonId: .politoed, pokemonType: [.pokemonTypeWater], familyId: .familyPoliwag, parentId: .poliwhirl, baseAttack: 174, baseDefense: 192, baseStamina: 180, height: 0.13625, weight: 4.2375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .hoppip: PokemonPrototype.init(pokemonId: .hoppip, pokemonType: [.pokemonTypeGrass, .pokemonTypeFlying], familyId: .familyHoppip, parentId: .missingno, baseAttack: 67, baseDefense: 101, baseStamina: 70, height: 0.05125, weight: 0.0625, nextEvolve: [.skiploom], candyToEvolve: 25, buddyDistance: 3.0),
            .skiploom: PokemonPrototype.init(pokemonId: .skiploom, pokemonType: [.pokemonTypeGrass, .pokemonTypeFlying], familyId: .familyHoppip, parentId: .hoppip, baseAttack: 91, baseDefense: 127, baseStamina: 110, height: 0.07625, weight: 0.125, nextEvolve: [.jumpluff], candyToEvolve: 100, buddyDistance: 3.0),
            .jumpluff: PokemonPrototype.init(pokemonId: .jumpluff, pokemonType: [.pokemonTypeGrass, .pokemonTypeFlying], familyId: .familyHoppip, parentId: .skiploom, baseAttack: 118, baseDefense: 197, baseStamina: 150, height: 0.09875, weight: 0.375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .aipom: PokemonPrototype.init(pokemonId: .aipom, pokemonType: [.pokemonTypeNormal], familyId: .familyAipom, parentId: .missingno, baseAttack: 136, baseDefense: 112, baseStamina: 110, height: 0.09875, weight: 1.4375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .sunkern: PokemonPrototype.init(pokemonId: .sunkern, pokemonType: [.pokemonTypeGrass], familyId: .familySunkern, parentId: .missingno, baseAttack: 55, baseDefense: 55, baseStamina: 60, height: 0.0375, weight: 0.225, nextEvolve: [.sunflora], candyToEvolve: 50, buddyDistance: 3.0),
            .sunflora: PokemonPrototype.init(pokemonId: .sunflora, pokemonType: [.pokemonTypeGrass], familyId: .familySunkern, parentId: .sunkern, baseAttack: 185, baseDefense: 148, baseStamina: 150, height: 0.09875, weight: 1.0625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .yanma: PokemonPrototype.init(pokemonId: .yanma, pokemonType: [.pokemonTypeBug, .pokemonTypeFlying], familyId: .familyYanma, parentId: .missingno, baseAttack: 154, baseDefense: 94, baseStamina: 130, height: 0.14875, weight: 4.75, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .wooper: PokemonPrototype.init(pokemonId: .wooper, pokemonType: [.pokemonTypeWater, .pokemonTypeGround], familyId: .familyWooper, parentId: .missingno, baseAttack: 75, baseDefense: 75, baseStamina: 110, height: 0.05125, weight: 1.0625, nextEvolve: [.quagsire], candyToEvolve: 50, buddyDistance: 3.0),
            .quagsire: PokemonPrototype.init(pokemonId: .quagsire, pokemonType: [.pokemonTypeWater, .pokemonTypeGround], familyId: .familyWooper, parentId: .wooper, baseAttack: 152, baseDefense: 152, baseStamina: 190, height: 0.175, weight: 9.375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .espeon: PokemonPrototype.init(pokemonId: .espeon, pokemonType: [.pokemonTypePsychic], familyId: .familyEevee, parentId: .eevee, baseAttack: 261, baseDefense: 194, baseStamina: 130, height: 0.11125, weight: 3.3125, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .umbreon: PokemonPrototype.init(pokemonId: .umbreon, pokemonType: [.pokemonTypeDark], familyId: .familyEevee, parentId: .eevee, baseAttack: 126, baseDefense: 250, baseStamina: 190, height: 0.12375, weight: 3.375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .murkrow: PokemonPrototype.init(pokemonId: .murkrow, pokemonType: [.pokemonTypeDark, .pokemonTypeFlying], familyId: .familyMurkrow, parentId: .missingno, baseAttack: 175, baseDefense: 87, baseStamina: 120, height: 0.06375, weight: 0.2625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .slowking: PokemonPrototype.init(pokemonId: .slowking, pokemonType: [.pokemonTypeWater, .pokemonTypePsychic], familyId: .familySlowpoke, parentId: .slowpoke, baseAttack: 177, baseDefense: 194, baseStamina: 190, height: 0.25125, weight: 9.9375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .misdreavus: PokemonPrototype.init(pokemonId: .misdreavus, pokemonType: [.pokemonTypeGhost], familyId: .familyMisdreavus, parentId: .missingno, baseAttack: 167, baseDefense: 167, baseStamina: 120, height: 0.08875, weight: 0.125, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .unown: PokemonPrototype.init(pokemonId: .unown, pokemonType: [.pokemonTypePsychic], familyId: .familyUnown, parentId: .missingno, baseAttack: 136, baseDefense: 91, baseStamina: 96, height: 0.06375, weight: 0.625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .wobbuffet: PokemonPrototype.init(pokemonId: .wobbuffet, pokemonType: [.pokemonTypePsychic], familyId: .familyWobbuffet, parentId: .missingno, baseAttack: 60, baseDefense: 106, baseStamina: 380, height: 0.1625, weight: 3.5625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .girafarig: PokemonPrototype.init(pokemonId: .girafarig, pokemonType: [.pokemonTypeNormal, .pokemonTypePsychic], familyId: .familyGirafarig, parentId: .missingno, baseAttack: 182, baseDefense: 133, baseStamina: 140, height: 0.1875, weight: 5.1875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .pineco: PokemonPrototype.init(pokemonId: .pineco, pokemonType: [.pokemonTypeBug], familyId: .familyPineco, parentId: .missingno, baseAttack: 108, baseDefense: 146, baseStamina: 100, height: 0.07625, weight: 0.9, nextEvolve: [.forretress], candyToEvolve: 50, buddyDistance: 5.0),
            .forretress: PokemonPrototype.init(pokemonId: .forretress, pokemonType: [.pokemonTypeBug, .pokemonTypeSteel], familyId: .familyPineco, parentId: .pineco, baseAttack: 161, baseDefense: 242, baseStamina: 150, height: 0.14875, weight: 15.725, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .dunsparce: PokemonPrototype.init(pokemonId: .dunsparce, pokemonType: [.pokemonTypeNormal], familyId: .familyDunsparce, parentId: .missingno, baseAttack: 131, baseDefense: 131, baseStamina: 200, height: 0.1875, weight: 1.75, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .gligar: PokemonPrototype.init(pokemonId: .gligar, pokemonType: [.pokemonTypeGround, .pokemonTypeFlying], familyId: .familyGligar, parentId: .missingno, baseAttack: 143, baseDefense: 204, baseStamina: 130, height: 0.13625, weight: 8.1, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .steelix: PokemonPrototype.init(pokemonId: .steelix, pokemonType: [.pokemonTypeSteel, .pokemonTypeGround], familyId: .familyOnix, parentId: .onix, baseAttack: 148, baseDefense: 333, baseStamina: 150, height: 1.14875, weight: 50.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .snubbull: PokemonPrototype.init(pokemonId: .snubbull, pokemonType: [.pokemonTypeFairy], familyId: .familySnubbull, parentId: .missingno, baseAttack: 137, baseDefense: 89, baseStamina: 120, height: 0.07625, weight: 0.975, nextEvolve: [.granbull], candyToEvolve: 50, buddyDistance: 3.0),
            .granbull: PokemonPrototype.init(pokemonId: .granbull, pokemonType: [.pokemonTypeFairy], familyId: .familySnubbull, parentId: .snubbull, baseAttack: 212, baseDefense: 137, baseStamina: 180, height: 0.175, weight: 6.0875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .qwilfish: PokemonPrototype.init(pokemonId: .qwilfish, pokemonType: [.pokemonTypeWater, .pokemonTypePoison], familyId: .familyQwilfish, parentId: .missingno, baseAttack: 184, baseDefense: 148, baseStamina: 130, height: 0.06375, weight: 0.4875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .scizor: PokemonPrototype.init(pokemonId: .scizor, pokemonType: [.pokemonTypeBug, .pokemonTypeSteel], familyId: .familyScyther, parentId: .scyther, baseAttack: 236, baseDefense: 191, baseStamina: 140, height: 0.25125, weight: 15.625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .shuckle: PokemonPrototype.init(pokemonId: .shuckle, pokemonType: [.pokemonTypeBug, .pokemonTypeRock], familyId: .familyShuckle, parentId: .missingno, baseAttack: 17, baseDefense: 396, baseStamina: 40, height: 0.07625, weight: 2.5625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .heracross: PokemonPrototype.init(pokemonId: .heracross, pokemonType: [.pokemonTypeBug, .pokemonTypeFighting], familyId: .familyHeracross, parentId: .missingno, baseAttack: 234, baseDefense: 189, baseStamina: 160, height: 0.1875, weight: 6.75, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .sneasel: PokemonPrototype.init(pokemonId: .sneasel, pokemonType: [.pokemonTypeDark, .pokemonTypeIce], familyId: .familySneasel, parentId: .missingno, baseAttack: 189, baseDefense: 157, baseStamina: 110, height: 0.11125, weight: 3.5, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .teddiursa: PokemonPrototype.init(pokemonId: .teddiursa, pokemonType: [.pokemonTypeNormal], familyId: .familyTeddiursa, parentId: .missingno, baseAttack: 142, baseDefense: 93, baseStamina: 120, height: 0.07625, weight: 1.1, nextEvolve: [.ursaring], candyToEvolve: 50, buddyDistance: 3.0),
            .ursaring: PokemonPrototype.init(pokemonId: .ursaring, pokemonType: [.pokemonTypeNormal], familyId: .familyTeddiursa, parentId: .teddiursa, baseAttack: 236, baseDefense: 144, baseStamina: 180, height: 0.225, weight: 15.725, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .slugma: PokemonPrototype.init(pokemonId: .slugma, pokemonType: [.pokemonTypeFire], familyId: .familySlugma, parentId: .missingno, baseAttack: 118, baseDefense: 71, baseStamina: 80, height: 0.08875, weight: 4.375, nextEvolve: [.magcargo], candyToEvolve: 50, buddyDistance: 1.0),
            .magcargo: PokemonPrototype.init(pokemonId: .magcargo, pokemonType: [.pokemonTypeFire, .pokemonTypeRock], familyId: .familySlugma, parentId: .slugma, baseAttack: 139, baseDefense: 209, baseStamina: 100, height: 0.09875, weight: 6.875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .swinub: PokemonPrototype.init(pokemonId: .swinub, pokemonType: [.pokemonTypeIce, .pokemonTypeGround], familyId: .familySwinub, parentId: .missingno, baseAttack: 90, baseDefense: 74, baseStamina: 100, height: 0.05125, weight: 0.8125, nextEvolve: [.piloswine], candyToEvolve: 50, buddyDistance: 3.0),
            .piloswine: PokemonPrototype.init(pokemonId: .piloswine, pokemonType: [.pokemonTypeIce, .pokemonTypeGround], familyId: .familySwinub, parentId: .swinub, baseAttack: 181, baseDefense: 147, baseStamina: 200, height: 0.13625, weight: 6.975, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .corsola: PokemonPrototype.init(pokemonId: .corsola, pokemonType: [.pokemonTypeWater, .pokemonTypeRock], familyId: .familyCorsola, parentId: .missingno, baseAttack: 118, baseDefense: 156, baseStamina: 110, height: 0.07625, weight: 0.625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .remoraid: PokemonPrototype.init(pokemonId: .remoraid, pokemonType: [.pokemonTypeWater], familyId: .familyRemoraid, parentId: .missingno, baseAttack: 127, baseDefense: 69, baseStamina: 70, height: 0.07625, weight: 1.5, nextEvolve: [.octillery], candyToEvolve: 50, buddyDistance: 1.0),
            .octillery: PokemonPrototype.init(pokemonId: .octillery, pokemonType: [.pokemonTypeWater], familyId: .familyRemoraid, parentId: .remoraid, baseAttack: 197, baseDefense: 141, baseStamina: 150, height: 0.11125, weight: 3.5625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 1.0),
            .delibird: PokemonPrototype.init(pokemonId: .delibird, pokemonType: [.pokemonTypeIce, .pokemonTypeFlying], familyId: .familyDelibird, parentId: .missingno, baseAttack: 128, baseDefense: 90, baseStamina: 90, height: 0.11125, weight: 2.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .mantine: PokemonPrototype.init(pokemonId: .mantine, pokemonType: [.pokemonTypeWater, .pokemonTypeFlying], familyId: .familyMantine, parentId: .missingno, baseAttack: 148, baseDefense: 260, baseStamina: 130, height: 0.26375, weight: 27.5, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .skarmory: PokemonPrototype.init(pokemonId: .skarmory, pokemonType: [.pokemonTypeSteel, .pokemonTypeFlying], familyId: .familySkarmory, parentId: .missingno, baseAttack: 148, baseDefense: 260, baseStamina: 130, height: 0.2125, weight: 6.3125, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .houndour: PokemonPrototype.init(pokemonId: .houndour, pokemonType: [.pokemonTypeDark, .pokemonTypeFire], familyId: .familyHoundour, parentId: .missingno, baseAttack: 152, baseDefense: 93, baseStamina: 90, height: 0.07625, weight: 1.35, nextEvolve: [.houndoom], candyToEvolve: 50, buddyDistance: 3.0),
            .houndoom: PokemonPrototype.init(pokemonId: .houndoom, pokemonType: [.pokemonTypeDark, .pokemonTypeFire], familyId: .familyHoundour, parentId: .houndour, baseAttack: 224, baseDefense: 159, baseStamina: 150, height: 0.175, weight: 4.375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .kingdra: PokemonPrototype.init(pokemonId: .kingdra, pokemonType: [.pokemonTypeWater, .pokemonTypeDragon], familyId: .familyHorsea, parentId: .missingno, baseAttack: 194, baseDefense: 194, baseStamina: 150, height: 0.225, weight: 19.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .phanpy: PokemonPrototype.init(pokemonId: .phanpy, pokemonType: [.pokemonTypeGround], familyId: .familyPhanpy, parentId: .missingno, baseAttack: 107, baseDefense: 107, baseStamina: 180, height: 0.06375, weight: 4.1875, nextEvolve: [.donphan], candyToEvolve: 50, buddyDistance: 3.0),
            .donphan: PokemonPrototype.init(pokemonId: .donphan, pokemonType: [.pokemonTypeGround], familyId: .familyPhanpy, parentId: .phanpy, baseAttack: 214, baseDefense: 214, baseStamina: 180, height: 0.13625, weight: 15.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .porygon2: PokemonPrototype.init(pokemonId: .porygon2, pokemonType: [.pokemonTypeNormal], familyId: .familyPorygon, parentId: .porygon, baseAttack: 198, baseDefense: 183, baseStamina: 170, height: 0.07625, weight: 4.0625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .stantler: PokemonPrototype.init(pokemonId: .stantler, pokemonType: [.pokemonTypeNormal], familyId: .familyStantler, parentId: .missingno, baseAttack: 192, baseDefense: 132, baseStamina: 146, height: 0.175, weight: 8.9, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .smeargle: PokemonPrototype.init(pokemonId: .smeargle, pokemonType: [.pokemonTypeNormal], familyId: .familySmeargle, parentId: .missingno, baseAttack: 40, baseDefense: 88, baseStamina: 110, height: 0.14875, weight: 7.25, nextEvolve: [], candyToEvolve: 0, buddyDistance: 3.0),
            .tyrogue: PokemonPrototype.init(pokemonId: .tyrogue, pokemonType: [.pokemonTypeFighting], familyId: .familyTyrogue, parentId: .missingno, baseAttack: 64, baseDefense: 64, baseStamina: 70, height: 0.08875, weight: 2.625, nextEvolve: [.hitmontop], candyToEvolve: 25, buddyDistance: 5.0),
            .hitmontop: PokemonPrototype.init(pokemonId: .hitmontop, pokemonType: [.pokemonTypeFighting], familyId: .familyTyrogue, parentId: .tyrogue, baseAttack: 173, baseDefense: 214, baseStamina: 100, height: 0.175, weight: 6.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .smoochum: PokemonPrototype.init(pokemonId: .smoochum, pokemonType: [.pokemonTypeIce, .pokemonTypePsychic], familyId: .familyJynx, parentId: .missingno, baseAttack: 153, baseDefense: 116, baseStamina: 90, height: 0.05125, weight: 0.75, nextEvolve: [.jynx], candyToEvolve: 25, buddyDistance: 5.0),
            .elekid: PokemonPrototype.init(pokemonId: .elekid, pokemonType: [.pokemonTypeElectric], familyId: .familyElectabuzz, parentId: .missingno, baseAttack: 135, baseDefense: 110, baseStamina: 90, height: 0.07625, weight: 2.9375, nextEvolve: [.electabuzz], candyToEvolve: 25, buddyDistance: 5.0),
            .magby: PokemonPrototype.init(pokemonId: .magby, pokemonType: [.pokemonTypeFire], familyId: .familyMagmar, parentId: .missingno, baseAttack: 151, baseDefense: 108, baseStamina: 90, height: 0.08875, weight: 2.675, nextEvolve: [.magmar], candyToEvolve: 25, buddyDistance: 5.0),
            .miltank: PokemonPrototype.init(pokemonId: .miltank, pokemonType: [.pokemonTypeNormal], familyId: .familyMiltank, parentId: .missingno, baseAttack: 157, baseDefense: 211, baseStamina: 190, height: 0.14875, weight: 9.4375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .blissey: PokemonPrototype.init(pokemonId: .blissey, pokemonType: [.pokemonTypeNormal], familyId: .familyChansey, parentId: .chansey, baseAttack: 129, baseDefense: 229, baseStamina: 510, height: 0.1875, weight: 5.85, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .raikou: PokemonPrototype.init(pokemonId: .raikou, pokemonType: [.pokemonTypeElectric], familyId: .familyRaikou, parentId: .missingno, baseAttack: 241, baseDefense: 210, baseStamina: 180, height: 0.23875, weight: 22.25, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .entei: PokemonPrototype.init(pokemonId: .entei, pokemonType: [.pokemonTypeFire], familyId: .familyEntei, parentId: .missingno, baseAttack: 235, baseDefense: 176, baseStamina: 230, height: 0.26375, weight: 24.75, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .suicune: PokemonPrototype.init(pokemonId: .suicune, pokemonType: [.pokemonTypeWater], familyId: .familySuicune, parentId: .missingno, baseAttack: 180, baseDefense: 235, baseStamina: 200, height: 0.25125, weight: 23.375, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .larvitar: PokemonPrototype.init(pokemonId: .larvitar, pokemonType: [.pokemonTypeRock, .pokemonTypeGround], familyId: .familyLarvitar, parentId: .missingno, baseAttack: 115, baseDefense: 93, baseStamina: 100, height: 0.07625, weight: 9.0, nextEvolve: [.pupitar], candyToEvolve: 25, buddyDistance: 5.0),
            .pupitar: PokemonPrototype.init(pokemonId: .pupitar, pokemonType: [.pokemonTypeRock, .pokemonTypeGround], familyId: .familyLarvitar, parentId: .larvitar, baseAttack: 155, baseDefense: 133, baseStamina: 140, height: 0.14875, weight: 19.0, nextEvolve: [.tyranitar], candyToEvolve: 100, buddyDistance: 5.0),
            .tyranitar: PokemonPrototype.init(pokemonId: .tyranitar, pokemonType: [.pokemonTypeRock, .pokemonTypeDark], familyId: .familyLarvitar, parentId: .pupitar, baseAttack: 251, baseDefense: 212, baseStamina: 200, height: 0.25125, weight: 25.25, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .lugia: PokemonPrototype.init(pokemonId: .lugia, pokemonType: [.pokemonTypePsychic, .pokemonTypeFlying], familyId: .familyLugia, parentId: .missingno, baseAttack: 193, baseDefense: 323, baseStamina: 212, height: 0.65125, weight: 27.0, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .hoOh: PokemonPrototype.init(pokemonId: .hoOh, pokemonType: [.pokemonTypeFire, .pokemonTypeFlying], familyId: .familyHoOh, parentId: .missingno, baseAttack: 263, baseDefense: 301, baseStamina: 212, height: 0.47625, weight: 24.875, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            .celebi: PokemonPrototype.init(pokemonId: .celebi, pokemonType: [.pokemonTypePsychic, .pokemonTypeGrass], familyId: .familyCelebi, parentId: .missingno, baseAttack: 210, baseDefense: 210, baseStamina: 200, height: 0.07625, weight: 0.625, nextEvolve: [], candyToEvolve: 0, buddyDistance: 5.0),
            
            ]
    
    
}
